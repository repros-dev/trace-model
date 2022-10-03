#!/usr/bin/env bash

# path to data files
DATA=../data

# *****************************************************************************

bash_cell import_tro_jsonld << END_CELL

# Import TRO and TRS as JSON-LD and export as N-TRIPLES
geist destroy --dataset kb --quiet
geist create --dataset kb --quiet
geist import --format jsonld --file ${DATA}/trs-type-a.jsonld
#geist import --format jsonld --file ${DATA}/tro-type-a.jsonld

END_CELL


bash_cell export_tro_ntriples << END_CELL

# Import TRO and TRS as JSON-LD and export as N-TRIPLES
geist export --format nt | sort

END_CELL


