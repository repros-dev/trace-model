#!/usr/bin/env bash

CONTEXT_FILE_PATH=data/context.csv
JSON_FILE_PATH=data/tro.json
JSONLD_FILE_PATH=products/tro.jsonld

# ------------------------------------------------------------------------------

bash_cell json2jsonld << END_CELL

python3 << END_PYTHON

from pyld import jsonld
import pandas as pd
import numpy as np
import json

def process_id(value):
    return str(int(value))

def update_dict(data, keys, cm):
    # TYPE 1
    # e.g., {"trp": 1, "trpAttribute": 1} => {"@id": "trp/1/attribute/1" }
    type1 = [{"k1": "trp", "k2": "trpAttribute", "id": "trp/{id1}/attribute/{id2}"},
             {"k1": "composition", "k2": "compArtifact", "id": "composition/{id1}/artifact/{id2}"}]
    for item in type1:
        k1, k2 = item["k1"], item["k2"]
        if (k1 in keys) and (k2 in keys):
            data["@id"] = item["id"].format(id1=process_id(data[k1]), id2=process_id(data[k2]))
            data.pop(k1)
            data.pop(k2)

    # TYPE 2
    # e.g., {"composition": 1, "hasArtifact": {"artifact": 1}} OR {"composition": 1, "hasArtifact": [{"artifact": 1}]} 
    # => {"composition": 1, "hasArtifact": {"@id": "composition/1/artifact/1"}} OR {"composition": 1, "hasArtifact": [{"@id": "composition/1/artifact/1"}]}
    type2 = [{"k1": "composition", "k2": "hasArtifact", "k3": "artifact", "id": "composition/{id1}/artifact/{id2}"},
             {"k1": "arrangement", "k2": "hasLocus", "k3": "locus", "id": "arrangement/{id1}/locus/{id2}"},
             {"k1": "trp", "k2": "hadPerformanceAttribute", "k3": "trpAttribute", "id": "trp/{id1}/attribute/{id2}"}]
    for item in type2:
        k1, k2, k3 = item["k1"], item["k2"], item["k3"]
        if (k1 in keys) and (k2 in keys):
            if isinstance(data[k2], dict):
                data[k2]["@id"] = item["id"].format(id1=process_id(data[k1]), id2=process_id(data[k2][k3]))
                data[k2].pop(k3)
            else:
                for idx, artifact in enumerate(data[k2]):
                    data[k2][idx]["@id"] = item["id"].format(id1=process_id(data[k1]), id2=process_id(artifact[k3]))
                    data[k2][idx].pop(k3)
    
    # TYPE 3
    # one-to-one mappings based on context.csv
    for key in cm.keys():
        if key in keys:
            if isinstance(cm[key]["idPrefix"], str):
                data[cm[key]["rdfTerm"]] = cm[key]["idPrefix"] + process_id(data.pop(key))
            else:
                data[cm[key]["rdfTerm"]] = data.pop(key)
    
    return data

def traverse_json(obj, cm):
    if isinstance(obj, list):
        for item in obj:
            traverse_json(item, cm)
    elif isinstance(obj, dict):
        keys = obj.keys()
        obj = update_dict(obj, keys, cm)
        for k, v in obj.items():
            if isinstance(v, (list, dict)):
                traverse_json(v, cm)
    return obj

# Load a TRO JSON Declaration
with open('${JSON_FILE_PATH}', 'r', encoding='utf-8') as fin:
    content = fin.read()
json_content = json.loads(content)

# Load the context mappings
cm = pd.read_csv('${CONTEXT_FILE_PATH}', index_col='key').T.to_dict(orient='dict')

# Traverse and update it recursively
content = traverse_json(json_content, cm)

# Add context
jsonld = {
    "@context": [{
        "rdf": "http://www.w3.org/1999/02/22-rdf-syntax-ns#",
        "rdfs": "http://www.w3.org/2000/01/rdf-schema#",
        "trov": "https://w3id.org/trace/2023/05/trov#",
        "@base": "https://github.com/transparency-certified/trace-model/tree/master/02-tro-examples/03-skope-/"
    }]
}

jsonld["@graph"] = [content]

with open('${JSONLD_FILE_PATH}', 'w', encoding='utf-8') as fout:
     json.dump(jsonld, fout, indent=2)

END_PYTHON

END_CELL

# ------------------------------------------------------------------------------
