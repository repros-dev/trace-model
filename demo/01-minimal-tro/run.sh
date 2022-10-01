#!/usr/bin/env bash

# *****************************************************************************

bash_cell DUMP-1 << END_CELL

# Import minimal TRO and TROS as JSON-LD and export as N-TRIPLES

geist destroy --dataset kb --quiet
geist create --dataset kb --quiet
geist import --format jsonld --file minimal-tros.jsonld
geist import --format jsonld --file minimal-tro.jsonld
geist export --format nt | sort

END_CELL
