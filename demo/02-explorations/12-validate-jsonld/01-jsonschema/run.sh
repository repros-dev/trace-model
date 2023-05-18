#!/usr/bin/env bash

TRO_SCHEMA_FILE_PATH=tro.schema.json

# ------------------------------------------------------------------------------

bash_cell 'validate tro1.jsonld' << END_CELL

python3 2>&1 << END_PYTHON

from validate_jsonld import validate_tro

validate_tro("data/tro1_c.jsonld", "${TRO_SCHEMA_FILE_PATH}")

END_PYTHON

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'validate tro2.jsonld' << END_CELL

python3 2>&1 << END_PYTHON

from validate_jsonld import validate_tro

validate_tro("data/tro1_w.jsonld", "${TRO_SCHEMA_FILE_PATH}")

END_PYTHON

END_CELL

# ------------------------------------------------------------------------------
