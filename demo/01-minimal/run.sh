#!/usr/bin/env bash

# paths to data files
COMMON=../common
TRS=${COMMON}/trs
TRO=${COMMON}/tro

# *****************************************************************************

bash_cell import_tro_jsonld << END_CELL

# Import TRO and TRS as JSON-LD and export as N-TRIPLES
geist destroy --dataset kb --quiet
geist create --dataset kb --infer owl --quiet
geist import --format jsonld --file ${COMMON}/trace-vocab.jsonld
geist import --format jsonld --file ${TRS}/trs-01-minimal.jsonld
geist import --format jsonld --file ${TRO}/tro-01-from-minimal-trs.jsonld

END_CELL

# *****************************************************************************

bash_cell export_ntriples << END_CELL

# Import TRO and TRS as JSON-LD and export as N-TRIPLES
geist export --format nt | sort | grep trov

END_CELL

# *****************************************************************************

source ../common/trs-queries.sh





