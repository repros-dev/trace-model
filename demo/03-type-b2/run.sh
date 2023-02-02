#!/usr/bin/env bash

# paths to data files
COMMON=../common

# ------------------------------------------------------------------------------

bash_cell 'import jsonld' << END_CELL

# Import TRO and TRS as JSON-LD and export as N-TRIPLES
geist destroy --dataset kb --quiet
geist create --dataset kb --infer owl --quiet
geist import --format jsonld --file ${COMMON}/trace-vocab.jsonld
geist import --format jsonld --file ${COMMON}/trs-03-type-b2.jsonld
geist import --format jsonld --file ${COMMON}/tro-03-from-type-b2-trs.jsonld

END_CELL

# ------------------------------------------------------------------------------

source ../common/trs-queries.sh

