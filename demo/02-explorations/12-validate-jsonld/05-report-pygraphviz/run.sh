#!/usr/bin/env bash

# paths to data files
TRO_DECLARATION_JSONLD_PATH="data/tro.jsonld"
TRO_DECLARATION_SCHEMA_PATH="data/tro.schema.ttl"
SCRATCH_REPORT_DOT_PATH="products/scratch_report.dot"
SCRATCH_REPORT_PNG_PATH="products/scratch_report.png"
TOOL_REPORT_TXT_PATH="products/tool_report.txt"
TOOL_REPORT_PNG_PATH="products/tool_report.png"

# ------------------------------------------------------------------------------

bash_cell 'dot report' << END_CELL

python3 << END_PYTHON

from pyshacl import validate
from rdflib import Graph
import pygraphviz as pgv
import pandas as pd
import subprocess

mappings={
    "http://www.w3.org/1999/02/22-rdf-syntax-ns#": "rdf#",
    "http://www.w3.org/2000/01/rdf-schema#": "rdfs#",
    "https://w3id.org/trace/2023/05/trov#": "trov#",
    "https://github.com/transparency-certified/trace-model/tree/master/demo/01-trov-examples/01-two-artifacts-no-trp/": ""
}

with open("${TRO_DECLARATION_JSONLD_PATH}") as fin:
    tro_jsonld = fin.read()

# Load JSON-LD file with RDFLib
g = Graph()
g.parse(data=tro_jsonld, format="json-ld")

# Query the imported triples
q = """
        SELECT ?s ?p ?o
        WHERE {
            ?s ?p ?o
        }
    """
rows = []
for r in g.query(q):
    rows.append(r)
graphs = pd.DataFrame(rows, columns=["source", "label", "target"]).replace(mappings, regex=True) #.sort_values(by=["source", "target"])

# Validate JSON-LD file with SHACL
with open("${TRO_DECLARATION_SCHEMA_PATH}") as fin:
    tro_schema = fin.read()
r = validate(data_graph=tro_jsonld,
      shacl_graph=tro_schema,
      data_graph_format="json-ld",
      inference='rdfs',
      debug=True)
conforms, results_graph, results_text = r
q = """
    PREFIX : <http://www.w3.org/ns/shacl#>

    SELECT ?value ?msg
    WHERE {   
        ?curr_node :focusNode ?focus .
        ?curr_node :value ?value .
        ?curr_node :resultMessage ?msg .
        ?another_node :focusNode ?another_focus .
        FILTER (?value != ?another_focus)
        FILTER (?another_node != ?curr_node)
    }
"""
rows = []
for r in results_graph.query(q):
    rows.append(r)
wrong = pd.DataFrame(rows, columns=["node", "msg"]).replace(mappings, regex=True).drop_duplicates()

# Create a directed graph
G = pgv.AGraph(directed=True)

for _, row in graphs.iterrows():
    G.add_edge(row["source"], row["target"], label=row["label"])
for _, row in wrong.iterrows():
    G.add_node(row["node"], color="#f77580")
    # G.add_edge(row["node"], row["msg"], label="ErrorMsg", color="#f77580")

G.write("${SCRATCH_REPORT_DOT_PATH}")
subprocess.run(["dot", "-Tpng", "${SCRATCH_REPORT_DOT_PATH}", "-o", "${SCRATCH_REPORT_PNG_PATH}"])

END_PYTHON

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'report string with the validate_tro tool' << END_CELL

validate_tro -f ${TRO_DECLARATION_JSONLD_PATH} -s ${TRO_DECLARATION_SCHEMA_PATH}

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'report txt file with the validate_tro tool' << END_CELL

validate_tro -f ${TRO_DECLARATION_JSONLD_PATH} -s ${TRO_DECLARATION_SCHEMA_PATH} -o ${TOOL_REPORT_TXT_PATH}

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'report png file with the validate_tro tool' << END_CELL

validate_tro -f ${TRO_DECLARATION_JSONLD_PATH} -s ${TRO_DECLARATION_SCHEMA_PATH} -o ${TOOL_REPORT_PNG_PATH} -of png

END_CELL

# ------------------------------------------------------------------------------