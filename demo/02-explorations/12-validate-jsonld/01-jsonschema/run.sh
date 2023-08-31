#!/usr/bin/env bash

TRO_SCHEMA_FILE_PATH=tro.schema.json

# ------------------------------------------------------------------------------

bash_cell 'validate tro1.jsonld' << END_CELL

validate_jsonld --jsonldpath "data/tro1_c.jsonld" --schemapath "${TRO_SCHEMA_FILE_PATH}"

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'validate tro2.jsonld' << END_CELL

python3 2>&1 << END_PYTHON

from trace_model.validate_jsonld import validate_tro

validate_tro("data/tro1_w.jsonld", "${TRO_SCHEMA_FILE_PATH}")

END_PYTHON

END_CELL

# ------------------------------------------------------------------------------
