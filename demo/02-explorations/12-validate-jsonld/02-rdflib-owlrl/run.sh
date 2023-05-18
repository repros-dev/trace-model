#!/usr/bin/env bash

# ------------------------------------------------------------------------------

bash_cell 'rdflib without inferences' << END_CELL

python3 << END_PYTHON

from rdflib import Graph

with open("data/tro1.jsonld") as fin:
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

for r in g.query(q):
    print(r)

END_PYTHON

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'rdflib with inferences: RDFS semantics' << END_CELL

python3 << END_PYTHON

from rdflib import Graph
from owlrl import DeductiveClosure, RDFS_Semantics

with open("data/tro1.jsonld") as fin:
    tro_jsonld = fin.read()

# Load JSON-LD file with RDFLib
g = Graph()
g.parse(data=tro_jsonld, format="json-ld")

# RDFS_Semantics: implementing the RDFS semantics.
DeductiveClosure(RDFS_Semantics).expand(g)

# Query the imported triples
q = """
        SELECT ?s ?p ?o
        WHERE {
            ?s ?p ?o
        }
    """

for r in g.query(q):
    print(r)

END_PYTHON

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'rdflib with inferences: OWL 2 RL' << END_CELL

python3 << END_PYTHON

from rdflib import Graph
from owlrl import DeductiveClosure, OWLRL_Semantics

with open("data/tro1.jsonld") as fin:
    tro_jsonld = fin.read()

# Load JSON-LD file with RDFLib
g = Graph()
g.parse(data=tro_jsonld, format="json-ld")

# OWLRL_Semantics: implementing the OWL 2 RL.
DeductiveClosure(OWLRL_Semantics).expand(g)

# Query the imported triples
q = """
        SELECT ?s ?p ?o
        WHERE {
            ?s ?p ?o
        }
    """

for r in g.query(q):
    print(r)

END_PYTHON

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'rdflib with inferences: a combined semantics of RDFS semantics and OWL 2 RL' << END_CELL

python3 << END_PYTHON

from rdflib import Graph
from owlrl import DeductiveClosure, RDFS_OWLRL_Semantics

with open("data/tro1.jsonld") as fin:
    tro_jsonld = fin.read()

# Load JSON-LD file with RDFLib
g = Graph()
g.parse(data=tro_jsonld, format="json-ld")

# RDFS_OWLRL_Semantics: implementing a combined semantics of RDFS semantics and OWL 2 RL.
DeductiveClosure(RDFS_OWLRL_Semantics).expand(g)

# Query the imported triples
q = """
        SELECT ?s ?p ?o
        WHERE {
            ?s ?p ?o
        }
    """

for r in g.query(q):
    print(r)

END_PYTHON

END_CELL

# ------------------------------------------------------------------------------