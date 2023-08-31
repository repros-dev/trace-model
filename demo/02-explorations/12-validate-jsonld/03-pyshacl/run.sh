#!/usr/bin/env bash

# ------------------------------------------------------------------------------

bash_cell 'validate tro declaration with pyshacl (without comments)' << END_CELL

python3 << END_PYTHON

# It allows any number of comments for each TRO
from pyshacl import validate

tro_jsonld = """
{
    "@context": [{
        "rdf": "http://www.w3.org/1999/02/22-rdf-syntax-ns#",
        "rdfs": "http://www.w3.org/2000/01/rdf-schema#",
        "trov": "https://w3id.org/trace/2023/05/trov#",
        "@base": "https://github.com/transparency-certified/trace-model/tree/master/demo/01-trov-examples/01-two-artifacts-no-trp/"
    }],
    
    "@graph": [
        { "@id": "tro", "@type": "trov:TransparentResearchObject" }
    ]
}
"""

with open("data/tro.schema.ttl") as fin:
    tro_schema = fin.read()

r = validate(data_graph=tro_jsonld,
      shacl_graph=tro_schema,
      data_graph_format="json-ld",
      inference='rdfs',
      debug=True)
conforms, results_graph, results_text = r

print("results_text: ", results_text)

END_PYTHON

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'validate tro declaration with pyshacl (multiple trs pk)' << END_CELL

python3 << END_PYTHON

from pyshacl import validate

tro_jsonld = """
{
    "@context": [{
        "rdf": "http://www.w3.org/1999/02/22-rdf-syntax-ns#",
        "rdfs": "http://www.w3.org/2000/01/rdf-schema#",
        "trov": "https://w3id.org/trace/2023/05/trov#",
        "@base": "https://github.com/transparency-certified/trace-model/tree/master/demo/01-trov-examples/01-two-artifacts-no-trp/"
    }],
    
    "@graph": [
        { "@id": "trs", "@type": "trov:TrustedResearchSystem" },
        { "@id": "trs", "trov:publicKey": "trs.pk.1" },
        { "@id": "trs", "trov:publicKey": "trs.pk.2" }
    ]
}
"""

with open("data/tro.schema.ttl") as fin:
    tro_schema = fin.read()

r = validate(data_graph=tro_jsonld,
      shacl_graph=tro_schema,
      data_graph_format="json-ld",
      inference='rdfs',
      debug=True)
conforms, results_graph, results_text = r

print("results_text: ", results_text)

END_PYTHON

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'validate tro declaration with pyshacl (multiple tsa pk)' << END_CELL

python3 << END_PYTHON

from pyshacl import validate

tro_jsonld = """
{
    "@context": [{
        "rdf": "http://www.w3.org/1999/02/22-rdf-syntax-ns#",
        "rdfs": "http://www.w3.org/2000/01/rdf-schema#",
        "trov": "https://w3id.org/trace/2023/05/trov#",
        "@base": "https://github.com/transparency-certified/trace-model/tree/master/demo/01-trov-examples/01-two-artifacts-no-trp/"
    }],
    
    "@graph": [{
        "@id": "tsa", "@type": "trov:TimeStampingAuthority" },
        { "@id": "tsa", "trov:publicKey": "tsa.pk.1" },
        { "@id": "tsa", "trov:publicKey": "tsa.pk.2" }
    ]
}
"""

with open("data/tro.schema.ttl") as fin:
    tro_schema = fin.read()

r = validate(data_graph=tro_jsonld,
      shacl_graph=tro_schema,
      data_graph_format="json-ld",
      inference='rdfs',
      debug=True)
conforms, results_graph, results_text = r

print("results_text: ", results_text)

END_PYTHON

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'validate tro declaration with pyshacl (multiple fingerprints per composition)' << END_CELL

python3 << END_PYTHON

from pyshacl import validate

tro_jsonld = """
{
    "@context": [{
        "rdf": "http://www.w3.org/1999/02/22-rdf-syntax-ns#",
        "rdfs": "http://www.w3.org/2000/01/rdf-schema#",
        "trov": "https://w3id.org/trace/2023/05/trov#",
        "@base": "https://github.com/transparency-certified/trace-model/tree/master/demo/01-trov-examples/01-two-artifacts-no-trp/"
    }],
    
    "@graph": [{
        "trov:hasComposition":
        {
            "@id": "composition/1",
            "@type": "trov:ArtifactComposition",
        
             "trov:hasFingerprint":
            {
                "@id": "fp1",
                "@type": "trov:CompositionFingerprint",
                "trov:sha256": "sha256.fp1"
            }
        }
    },
    {
        "@id": "composition/1", 
        "trov:hasFingerprint": {
            "@id": "fp2",
            "trov:sha256": "sha256.fp2"
        }
    }]
}
"""

with open("data/tro.schema.ttl") as fin:
    tro_schema = fin.read()

r = validate(data_graph=tro_jsonld,
      shacl_graph=tro_schema,
      data_graph_format="json-ld",
      inference='rdfs',
      debug=True)
conforms, results_graph, results_text = r

print("results_text: ", results_text)

END_PYTHON

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'validate tro declaration with pyshacl (multiple sha256 per fingerprint)' << END_CELL

python3 << END_PYTHON

from pyshacl import validate

tro_jsonld = """
{
    "@context": [{
        "rdf": "http://www.w3.org/1999/02/22-rdf-syntax-ns#",
        "rdfs": "http://www.w3.org/2000/01/rdf-schema#",
        "trov": "https://w3id.org/trace/2023/05/trov#",
        "@base": "https://github.com/transparency-certified/trace-model/tree/master/demo/01-trov-examples/01-two-artifacts-no-trp/"
    }],
    
    "@graph": [{
        "trov:hasComposition":
        {
            "@id": "composition/1",
            "@type": "trov:ArtifactComposition",
        
            "trov:hasFingerprint":
            {
                "@id": "fp1",
                "@type": "trov:CompositionFingerprint",
                "trov:sha256": "sha256.fp1"
            }
        }
    },
    { "@id": "fp1", "trov:sha256": "sha256.fp2" }
    ]
}
"""

with open("data/tro.schema.ttl") as fin:
    tro_schema = fin.read()

r = validate(data_graph=tro_jsonld,
      shacl_graph=tro_schema,
      data_graph_format="json-ld",
      inference='rdfs',
      debug=True)
conforms, results_graph, results_text = r

print("results_text: ", results_text)

END_PYTHON

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'validate tro declaration with pyshacl (composition with at least one artifact)' << END_CELL

python3 << END_PYTHON

from pyshacl import validate

tro_jsonld = """
{
    "@context": [{
        "rdf": "http://www.w3.org/1999/02/22-rdf-syntax-ns#",
        "rdfs": "http://www.w3.org/2000/01/rdf-schema#",
        "trov": "https://w3id.org/trace/2023/05/trov#",
        "@base": "https://github.com/transparency-certified/trace-model/tree/master/demo/01-trov-examples/01-two-artifacts-no-trp/"
    }],
    
    "@graph": [{
        "trov:hasComposition": [
        {
            "@id": "composition/1",
            "@type": "trov:ArtifactComposition",

            "trov:hasFingerprint":
            {
                "@id": "fp1",
                "@type": "trov:CompositionFingerprint",
                "trov:sha256": "sha256.fp1"
            },

            "trov:hasArtifact": [
            {
                "@id": "composition/1/artifact/1",
                "@type": "trov:ResearchArtifact",
                "trov:mimeType": "text/plain",
                "trov:sha256": "art.sha256.1"
            }]
        },
        { 
            "@id": "composition/2", 
            "@type": "trov:ArtifactComposition",
          
            "trov:hasFingerprint":
            {
                "@id": "fp2",
                "@type": "trov:CompositionFingerprint",
                "trov:sha256": "sha256.fp2"
            }
        }]
    }]
}
"""

with open("data/tro.schema.ttl") as fin:
    tro_schema = fin.read()

r = validate(data_graph=tro_jsonld,
      shacl_graph=tro_schema,
      data_graph_format="json-ld",
      inference='rdfs',
      debug=True)
conforms, results_graph, results_text = r

print(results_text)

END_PYTHON

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'validate tro declaration with pyshacl (arrangement links to a valid artifact) and validate error msg with SPARQL' << END_CELL

python3 << END_PYTHON

from pyshacl import validate

tro_jsonld = """
{
    "@context": [{
        "rdf": "http://www.w3.org/1999/02/22-rdf-syntax-ns#",
        "rdfs": "http://www.w3.org/2000/01/rdf-schema#",
        "trov": "https://w3id.org/trace/2023/05/trov#",
        "@base": "https://github.com/transparency-certified/trace-model/tree/master/demo/01-trov-examples/01-two-artifacts-no-trp/"
    }],
    
    "@graph": [{
        "trov:hasComposition": [
        {
            "@id": "composition/1",
            "@type": "trov:ArtifactComposition",

            "trov:hasFingerprint":
            {
                "@id": "fp1",
                "@type": "trov:CompositionFingerprint",
                "trov:sha256": "sha256.fp1"
            },

            "trov:hasArtifact": [
            {
                "@id": "composition/1/artifact/1",
                "@type": "trov:ResearchArtifact",
                "trov:sha256": "art.sha256.1"
            }]
        }],
        "trov:hasArrangement": {
        "@id": "arrangement/1",
        "@type": "trov:ArtifactArrangement",
        "trov:hasLocus": [
            {
                "@id": "arrangement/1/locus/1",
                "@type": "trov:ArtifactLocus",
                "trov:hasArtifact": { "@id": "composition/1/artifact/1" },
                "trov:hasLocation": "filepath1"
            },
            {
                "@id": "arrangement/1/locus/2",
                "@type": "trov:ArtifactLocus",
                "trov:hasArtifact": { "@id": "composition/1/artifact/100" },
                "trov:hasLocation": "filepath2"
            }]
        }
    }]
}
"""

with open("data/tro.schema.ttl") as fin:
    tro_schema = fin.read()

r = validate(data_graph=tro_jsonld,
      shacl_graph=tro_schema,
      data_graph_format="json-ld",
      inference='rdfs',
      debug=True)
conforms, results_graph, results_text = r

print(results_text)

print("***"*15)
# Show triples
for s,p,o in results_graph:
    print(s, p, o)
print("***"*15)

q = """
    ASK {   
        ?node ?p "Value does not have class trov:ResearchArtifact" .
    }
"""

res = bool(results_graph.query(q))
print("Validate error message: " + ("PASS" if res else "FAIL"))

END_PYTHON

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'validate tro declaration with pyshacl (arrangement links to a valid artifact) and select msg with SPARQL' << END_CELL

python3 << END_PYTHON

from pyshacl import validate

tro_jsonld = """
{
    "@context": [{
        "rdf": "http://www.w3.org/1999/02/22-rdf-syntax-ns#",
        "rdfs": "http://www.w3.org/2000/01/rdf-schema#",
        "trov": "https://w3id.org/trace/2023/05/trov#",
        "@base": "https://github.com/transparency-certified/trace-model/tree/master/demo/01-trov-examples/01-two-artifacts-no-trp/"
    }],
    
    "@graph": [{
        "trov:hasComposition": [
        {
            "@id": "composition/1",
            "@type": "trov:ArtifactComposition",

            "trov:hasFingerprint":
            {
                "@id": "fp1",
                "@type": "trov:CompositionFingerprint",
                "trov:sha256": "sha256.fp1"
            },

            "trov:hasArtifact": [
            {
                "@id": "composition/1/artifact/1",
                "@type": "trov:ResearchArtifact",
                "trov:sha256": "art.sha256.1"
            }]
        }],
        "trov:hasArrangement": {
        "@id": "arrangement/1",
        "@type": "trov:ArtifactArrangement",
        "trov:hasLocus": [
            {
                "@id": "arrangement/1/locus/1",
                "@type": "trov:ArtifactLocus",
                "trov:hasArtifact": { "@id": "composition/1/artifact/1" },
                "trov:hasLocation": "filepath1"
            },
            {
                "@id": "arrangement/1/locus/2",
                "@type": "trov:ArtifactLocus",
                "trov:hasArtifact": { "@id": "composition/1/artifact/100" },
                "trov:hasLocation": "filepath2"
            }]
        }
    }]
}
"""

with open("data/tro.schema.ttl") as fin:
    tro_schema = fin.read()

r = validate(data_graph=tro_jsonld,
      shacl_graph=tro_schema,
      data_graph_format="json-ld",
      inference='rdfs',
      debug=True)
conforms, results_graph, results_text = r

print(results_text)

print("***"*15)
# Show triples
for s,p,o in results_graph:
    print(s, p, o)
print("***"*15)

q = """
    PREFIX : <http://www.w3.org/ns/shacl#>

    SELECT ?focus ?value ?msg
    WHERE {   
        ?curr_node :focusNode ?focus .
        ?curr_node :value ?value .
        ?curr_node :resultMessage ?msg .
        ?another_node :focusNode ?another_focus .
        FILTER (?value != ?another_focus)
        FILTER (?another_node != ?curr_node)
    }
    ORDER BY ?focus ?value ?msg
"""

for x in results_graph.query(q):
    print(x)

END_PYTHON

END_CELL

# ------------------------------------------------------------------------------
