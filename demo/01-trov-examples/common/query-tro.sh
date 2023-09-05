

TRACE_VOCAB=$REPRO_MNT/exports/trace-vocab.jsonld
TRO_DECLARATION=tro/tro.jsonld
TRS_CERTIFICATE=trs/trs.jsonld

# ------------------------------------------------------------------------------

bash_cell 'import trov vocabulary' << END_CELL

# Destroy the dataset
geist destroy --dataset kb --quiet

# Import TRACE vocabulary and TRO Manifest and export as N-TRIPLES
geist create --dataset kb --inputformat json-ld --inputfile ${TRACE_VOCAB} --infer owl

# Import TRO and TRS as JSON-LD and export as N-TRIPLES
geist export --dataset kb --outputformat nt | sort | grep trov

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'import tro declaration' << END_CELL

# Import TRACE vocabulary and TRO Manifest and export as N-TRIPLES
geist load --dataset kb --inputformat json-ld --inputfile ${TRO_DECLARATION}

# Import TRO and TRS as JSON-LD and export as N-TRIPLES
geist export --dataset kb --outputformat nt | sort | grep trov-example

# Destroy the dataset
geist destroy --dataset kb

END_CELL

# ------------------------------------------------------------------------------
