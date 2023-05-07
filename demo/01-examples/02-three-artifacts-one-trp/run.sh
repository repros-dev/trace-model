#!/usr/bin/env bash

TRACE_VOCAB=$REPRO_MNT/exports/trace-vocab.jsonld
TRO_DECLARATION=tro/tro.jsonld
TRS_CERTIFICATE=trs/trs.jsonld

# ------------------------------------------------------------------------------

bash_cell 'import jsonld' << END_CELL

# Import TRACE vocabulary and TRO Manifest and export as N-TRIPLES
geist destroy --dataset kb --quiet
geist create --dataset kb #--infer owl --quiet
#geist import --format jsonld --file ${TRACE_VOCAB}
geist import --format jsonld --file ${TRO_DECLARATION}

# Import TRO and TRS as JSON-LD and export as N-TRIPLES
geist export --format nt

END_CELL
