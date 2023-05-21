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

bash_cell 'rdflib validate tro2.jsonld' << END_CELL

python3 << END_PYTHON

from rdflib import Graph

with open("data/tro2.jsonld") as fin:
    tro_jsonld = fin.read()

# Load JSON-LD file with RDFLib
g = Graph()
g.parse(data=tro_jsonld, format="json-ld")

# Query the imported triples

# 1) TRS with a public key
q = """
    ASK {   
        SELECT ?trs {
            ?tro trov:wasAssembledBy ?trs .
            ?trs trov:publicKey ?trs_pk .
        } GROUP BY ?trs HAVING (count(*) = 1)
    }
"""
res1 = bool(g.query(q))
print("Validate that a TRO Declaration has a TRS with a public key: " + ("PASS" if res1 else "FAIL"))

# 2) TSA with public key
## Method 1
q = """
    ASK {
        {
            SELECT (COUNT(*) AS ?c1) 
            WHERE {
                SELECT ?tsa {
                    ?tro trov:wasTimestampedBy ?tsa .
                    ?tsa trov:publicKey ?tsa_pk .
                } GROUP BY ?tsa HAVING (count(*) = 1)
            }
        }

        {
            SELECT (COUNT(*) AS ?c2) {
                ?tro trov:wasTimestampedBy ?tsa .
            }
        }
        FILTER (?c2 = 0 || ?c1 = ?c2)
    }
    """
res2 = bool(g.query(q))
print("Validate that a TRO Declaration has (1) NO TSA or (2) ONE TSA with a public key: [method 1]" + ("PASS" if res2 else "FAIL"))

## Method 2 (negation: do NOT have TSA with multiple public keys)
q = """
    ASK {
        {
            SELECT (COUNT(*) AS ?c1) 
            WHERE {
                SELECT ?tsa {
                    ?tro trov:wasTimestampedBy ?tsa .
                    ?tsa trov:publicKey ?tsa_pk .
                } GROUP BY ?tsa HAVING (count(*) > 1)
            }
        }
        FILTER (?c1 = 0)
    }
"""
res2 = bool(g.query(q))
print("Validate that a TRO Declaration has (1) NO TSA or (2) ONE TSA with a public key: [method 2]" + ("PASS" if res2 else "FAIL"))

# 3) Composition with a fingerprint
q = """
    ASK {
        {
            SELECT ?comp {
                ?tro trov:hasComposition ?comp .
                ?comp trov:hasFingerprint/trov:sha256 ?comp_fp .
            } GROUP BY ?comp HAVING (count(*) = 1)
        }
    }
    """
res3 = bool(g.query(q))
print("Validate that a TRO Declaration has at least a composition and each composition has exactly ONE fingerprint: " + ("PASS" if res3 else "FAIL"))

# 4) Composition with at least an artifact
q = """
    ASK {
        {   
            SELECT (COUNT(?comp) AS ?c1) 
            WHERE{
                SELECT ?comp {
                ?tro trov:hasComposition ?comp .
                ?comp trov:hasArtifact/trov:sha256 ?art_digest .
            } GROUP BY ?comp}
        }

        {
            SELECT (COUNT(?comp) AS ?c2) {
                ?tro trov:hasComposition ?comp .
            }
        }
        FILTER (?c1 = ?c2)
    }
    """
res4 = bool(g.query(q))
print("Validate that a TRO Declaration has at least a composition and each composition has at least an artifact: " + ("PASS" if res4 else "FAIL"))

# 5) Arrangement with validate artifacts
q = """
    ASK {
        {
            SELECT (COUNT(*) AS ?c1)
            WHERE {
                ?tro trov:hasArrangement ?arr .
                ?arr trov:hasLocus/trov:hasArtifact ?art .
            }
        }

        {
            SELECT (COUNT(*) AS ?c2)
            WHERE {
                ?tro trov:hasArrangement ?arr .
                ?arr trov:hasLocus/trov:hasArtifact/trov:sha256 ?art_digest .
            }
        }
    FILTER (?c1 = ?c2)
    }
"""

res5 = bool(g.query(q))
print("Validate that a TRO Declaration has arrangement(s) with valid artifacts: " + ("PASS" if res5 else "FAIL"))

if res1 and res2 and res3 and res4 and res5:
    print("This is a valid TRO Declaration!!!")
else:
    print("This is NOT a valid TRO Declaration!!!")

END_PYTHON

END_CELL

# ------------------------------------------------------------------------------
