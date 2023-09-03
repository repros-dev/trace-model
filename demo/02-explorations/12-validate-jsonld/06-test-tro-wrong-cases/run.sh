#!/usr/bin/env bash

# paths to data files
TRO_DECLARATION_SCHEMA_PATH="data/tro.schema.ttl"

# ------------------------------------------------------------------------------

bash_cell 'tro validation 1 png: refer to a nonexistent artifact' << END_CELL

validate_tro -f data/tro1.jsonld -s ${TRO_DECLARATION_SCHEMA_PATH} -o products/tro1 -of png -se True

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'tro validation 1 gv: refer to a nonexistent artifact' << END_CELL

validate_tro -f data/tro1.jsonld -s ${TRO_DECLARATION_SCHEMA_PATH} -o products/tro1 -of gv -se True

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'tro validation 2 png: refer to a nonexistent artifact' << END_CELL

validate_tro -f data/tro2.jsonld -s ${TRO_DECLARATION_SCHEMA_PATH} -o products/tro2 -of png -se True

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'tro validation 2 gv: refer to a nonexistent artifact' << END_CELL

validate_tro -f data/tro2.jsonld -s ${TRO_DECLARATION_SCHEMA_PATH} -o products/tro2 -of gv -se True

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'tro validation 3 png: refer to a nonexistent artifact' << END_CELL

validate_tro -f data/tro3.jsonld -s ${TRO_DECLARATION_SCHEMA_PATH} -o products/tro3 -of png -se True

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'tro validation 3 gv: refer to a nonexistent artifact' << END_CELL

validate_tro -f data/tro3.jsonld -s ${TRO_DECLARATION_SCHEMA_PATH} -o products/tro3 -of gv -se True

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'tro validation 4 png: lack of sha256' << END_CELL

validate_tro -f data/tro4.jsonld -s ${TRO_DECLARATION_SCHEMA_PATH} -o products/tro4 -of png -se True

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'tro validation 4 gv: lack of sha256' << END_CELL

validate_tro -f data/tro4.jsonld -s ${TRO_DECLARATION_SCHEMA_PATH} -o products/tro4 -of gv -se True

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'tro validation 5 export as png: multiple sha256' << END_CELL

validate_tro -f data/tro5.jsonld -s ${TRO_DECLARATION_SCHEMA_PATH} -o products/tro5 -of png -se True

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'tro validation 5 export as gv: multiple sha256' << END_CELL

validate_tro -f data/tro5.jsonld -s ${TRO_DECLARATION_SCHEMA_PATH} -o products/tro5 -of gv -se True

END_CELL

# ------------------------------------------------------------------------------


bash_cell 'tro validation 5 export as txt: multiple sha256' << END_CELL

validate_tro -f data/tro5.jsonld -s ${TRO_DECLARATION_SCHEMA_PATH} -o products/tro5 -of txt -se True

END_CELL

# ------------------------------------------------------------------------------