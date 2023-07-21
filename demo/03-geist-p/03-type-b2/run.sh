#!/usr/bin/env bash

# paths to data files
COMMON=../common

# ------------------------------------------------------------------------------

bash_cell 'import jsonld' << END_CELL

# Import TRO and TRS as JSON-LD and export as N-TRIPLES
geist-p create --dataset kb --inputformat json-ld --inputfile ${COMMON}/trace-vocab.jsonld --infer owl
geist-p load --dataset kb --inputformat json-ld --inputfile ${COMMON}/trs-03-type-b2.jsonld
geist-p load --dataset kb --inputformat json-ld --inputfile ${COMMON}/tro-03-from-type-b2-trs.jsonld

END_CELL

# ------------------------------------------------------------------------------

source ../common/trs-queries.sh

# ------------------------------------------------------------------------------

bash_cell 'destroy kb dataset' << END_CELL

geist-p destroy --dataset kb

END_CELL

# ------------------------------------------------------------------------------