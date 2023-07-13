#!/usr/bin/env bash

# paths to data files
COMMON=../common

# ------------------------------------------------------------------------------

bash_cell 'import jsonld' << END_CELL

# Import TRO and TRS as JSON-LD and export as N-TRIPLES
geist-p create --dataset kb --inputformat json-ld --inputfile ${COMMON}/trace-vocab.jsonld --infer rdfs
ls -l .geistdata

geist-p add --dataset kb --inputformat json-ld --inputfile ${COMMON}/trs-01-minimal.jsonld
ls -l .geistdata

geist-p add --dataset kb --inputformat json-ld --inputfile ${COMMON}/tro-01-from-minimal-trs.jsonld
ls -l .geistdata

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'export ntriples' << END_CELL

# Import TRO and TRS as JSON-LD and export as N-TRIPLES
geist-p export --dataset kb --outputformat nt | sort | grep trov

END_CELL

# ------------------------------------------------------------------------------







