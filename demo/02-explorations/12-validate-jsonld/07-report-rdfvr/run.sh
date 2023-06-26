#!/usr/bin/env bash

# paths to data files
TRO_DECLARATION_SCHEMA_PATH="data/tro.schema.ttl"
MAPPINGS_PATH="data/mappings.json"

# ------------------------------------------------------------------------------

bash_cell 'tro validation 1: refer to a nonexistent artifact' << END_CELL

rdfvr -f data/tro1.jsonld -s ${TRO_DECLARATION_SCHEMA_PATH} -m ${MAPPINGS_PATH} -o products/tro1.png -of png

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'tro validation 2: refer to a nonexistent artifact' << END_CELL

rdfvr -f data/tro2.jsonld -s ${TRO_DECLARATION_SCHEMA_PATH} -m ${MAPPINGS_PATH} -o products/tro2.png -of png

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'tro validation 3: refer to a nonexistent artifact' << END_CELL

rdfvr -f data/tro3.jsonld -s ${TRO_DECLARATION_SCHEMA_PATH} -m ${MAPPINGS_PATH} -o products/tro3.png -of png

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'tro validation 4: lack of sha256' << END_CELL

rdfvr -f data/tro4.jsonld -s ${TRO_DECLARATION_SCHEMA_PATH} -m ${MAPPINGS_PATH} -o products/tro4.png -of png

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'tro validation 5 export as png: multiple sha256' << END_CELL

rdfvr -f data/tro5.jsonld -s ${TRO_DECLARATION_SCHEMA_PATH} -m ${MAPPINGS_PATH} -o products/tro5.png -of png

END_CELL

# ------------------------------------------------------------------------------


bash_cell 'tro validation 5 export as txt: multiple sha256' << END_CELL

rdfvr -f data/tro5.jsonld -s ${TRO_DECLARATION_SCHEMA_PATH} -m ${MAPPINGS_PATH} -o products/tro5.txt -of txt

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'tro validation 5 print report text: multiple sha256' << END_CELL

rdfvr -f data/tro5.jsonld -s ${TRO_DECLARATION_SCHEMA_PATH} -m ${MAPPINGS_PATH}

END_CELL

# ------------------------------------------------------------------------------