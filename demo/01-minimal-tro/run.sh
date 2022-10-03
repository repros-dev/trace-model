#!/usr/bin/env bash

# *****************************************************************************

bash_cell import_tro_jsonld << END_CELL

# Import minimal TRO and TRS as JSON-LD and export as N-TRIPLES
geist destroy --dataset kb --quiet
geist create --dataset kb --quiet
geist import --format jsonld --file minimal-trs.jsonld
geist import --format jsonld --file minimal-tro.jsonld

END_CELL


bash_cell 'export tro ntriples' << END_CELL

# Import minimal TRO and TRS as JSON-LD and export as N-TRIPLES
geist export --format nt | sort

END_CELL


