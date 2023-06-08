#!/usr/bin/env bash

# ------------------------------------------------------------------------------

bash_cell 'export tro declaration as triples' << END_CELL

python3 << END_PYTHON

from rdflib import Graph
import pandas as pd

mappings = {
    "http://www.w3.org/1999/02/22-rdf-syntax-ns#": "rdf#",
    "http://www.w3.org/2000/01/rdf-schema#": "rdfs#",
    "https://w3id.org/trace/2023/05/trov#": "trov#",
    "https://github.com/transparency-certified/trace-model/tree/master/demo/01-trov-examples/01-two-artifacts-no-trp/": ""
}

with open("data/tro.jsonld") as fin:
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

graphs = pd.DataFrame(rows, columns=["source", "label", "target"]).replace(mappings, regex=True).sort_values(by=["source", "target"])
graphs.to_csv("products/triples.csv", index=False)

END_PYTHON

END_CELL

# ------------------------------------------------------------------------------
bash_cell 'visualize triples with errors' << END_CELL

jupyter nbconvert --ExecutePreprocessor.kernel_name=python3 --to html --execute visualize_triples.ipynb --output products/report.html

# Please run this code in terminal to check the html file: python3 -m http.server
# Then open your web browser, go to http://127.0.0.1:8000/, and find the products/report.html file

END_CELL
# ------------------------------------------------------------------------------