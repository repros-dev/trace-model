#!/usr/bin/env bash

# paths to data files
TRO_DECLARATION_SCHEMA_PATH="data/tro.schema.ttl"

# ------------------------------------------------------------------------------

bash_cell 'report string with the validate_tro tool' << END_CELL

python3 validate_tro -f data/tro1.jsonld -s ${TRO_DECLARATION_SCHEMA_PATH} -o products/tro1.png -of png

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'report string with the validate_tro tool' << END_CELL

python3 validate_tro -f data/tro2.jsonld -s ${TRO_DECLARATION_SCHEMA_PATH} -o products/tro2.png -of png

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'report string with the validate_tro tool' << END_CELL

python3 validate_tro -f data/tro3.jsonld -s ${TRO_DECLARATION_SCHEMA_PATH} -o products/tro3.png -of png

END_CELL

# ------------------------------------------------------------------------------