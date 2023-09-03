#!/usr/bin/env bash

# paths to data files
TRO_DECLARATION_SCHEMA_PATH="data/tro.schema.ttl"
MAPPINGS_PATH="data/mappings.json"

# ------------------------------------------------------------------------------

bash_cell 'tro validation 1 png: refer to a nonexistent artifact' << END_CELL

rdfvr -f data/tro1.jsonld -s ${TRO_DECLARATION_SCHEMA_PATH} -m ${MAPPINGS_PATH} -o products/tro1 -of png

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'tro validation 1 gv: refer to a nonexistent artifact' << END_CELL

rdfvr -f data/tro1.jsonld -s ${TRO_DECLARATION_SCHEMA_PATH} -m ${MAPPINGS_PATH} -o products/tro1 -of gv

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'tro validation 2 png: refer to a nonexistent artifact' << END_CELL

rdfvr -f data/tro2.jsonld -s ${TRO_DECLARATION_SCHEMA_PATH} -m ${MAPPINGS_PATH} -o products/tro2 -of png

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'tro validation 2 gv: refer to a nonexistent artifact' << END_CELL

rdfvr -f data/tro2.jsonld -s ${TRO_DECLARATION_SCHEMA_PATH} -m ${MAPPINGS_PATH} -o products/tro2 -of gv

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'tro validation 3 png: refer to a nonexistent artifact' << END_CELL

rdfvr -f data/tro3.jsonld -s ${TRO_DECLARATION_SCHEMA_PATH} -m ${MAPPINGS_PATH} -o products/tro3 -of png

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'tro validation 3 gv: refer to a nonexistent artifact' << END_CELL

rdfvr -f data/tro3.jsonld -s ${TRO_DECLARATION_SCHEMA_PATH} -m ${MAPPINGS_PATH} -o products/tro3 -of gv

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'tro validation 4 png: lack of sha256' << END_CELL

rdfvr -f data/tro4.jsonld -s ${TRO_DECLARATION_SCHEMA_PATH} -m ${MAPPINGS_PATH} -o products/tro4 -of png

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'tro validation 4 gv: lack of sha256' << END_CELL

rdfvr -f data/tro4.jsonld -s ${TRO_DECLARATION_SCHEMA_PATH} -m ${MAPPINGS_PATH} -o products/tro4 -of gv

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'tro validation 5 export as png: multiple sha256' << END_CELL

rdfvr -f data/tro5.jsonld -s ${TRO_DECLARATION_SCHEMA_PATH} -m ${MAPPINGS_PATH} -o products/tro5 -of png

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'tro validation 5 export as gv: multiple sha256' << END_CELL

rdfvr -f data/tro5.jsonld -s ${TRO_DECLARATION_SCHEMA_PATH} -m ${MAPPINGS_PATH} -o products/tro5 -of gv

END_CELL

# ------------------------------------------------------------------------------


bash_cell 'tro validation 5 export as txt: multiple sha256' << END_CELL

rdfvr -f data/tro5.jsonld -s ${TRO_DECLARATION_SCHEMA_PATH} -m ${MAPPINGS_PATH} -o products/tro5 -of txt

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'tro validation 5 print report text: multiple sha256' << END_CELL

rdfvr -f data/tro5.jsonld -s ${TRO_DECLARATION_SCHEMA_PATH} -m ${MAPPINGS_PATH}

END_CELL

# ------------------------------------------------------------------------------