#!/usr/bin/env bash

# paths to data files
COMMON=../common

# ------------------------------------------------------------------------------

bash_cell 'import jsonld' << END_CELL

# Import TRO and TRS as JSON-LD and export as N-TRIPLES
geist create --dataset kb --inputformat json-ld --inputfile ${COMMON}/trace-vocab.jsonld --infer owl
geist load --dataset kb --inputformat json-ld --inputfile ${COMMON}/trs-02-type-a.jsonld
geist load --dataset kb --inputformat json-ld --inputfile ${COMMON}/tro-02-from-type-a-trs.jsonld

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'export ntriples' << END_CELL

# Import TRO and TRS as JSON-LD and export as N-TRIPLES
geist export --dataset kb --outputformat nt | sort | grep trov

END_CELL

# ------------------------------------------------------------------------------

source ../common/trs-queries.sh

# ------------------------------------------------------------------------------

bash_cell 'destroy kb dataset' << END_CELL

geist destroy --dataset kb

END_CELL

# ------------------------------------------------------------------------------