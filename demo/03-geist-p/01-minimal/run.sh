#!/usr/bin/env bash

# paths to data files
COMMON=../common

# ------------------------------------------------------------------------------

bash_cell 'import jsonld' << END_CELL

# Import TRO and TRS as JSON-LD and export as N-TRIPLES
geist-p create --dataset kb --inputformat json-ld --inputfile ${COMMON}/trace-vocab.jsonld --infer owl
geist-p load --dataset kb --inputformat json-ld --inputfile ${COMMON}/trs-01-minimal.jsonld
geist-p load --dataset kb --inputformat json-ld --inputfile ${COMMON}/tro-01-from-minimal-trs.jsonld

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'export ntriples' << END_CELL

# Import TRO and TRS as JSON-LD and export as N-TRIPLES
geist-p export --dataset kb --outputformat nt | sort | grep trov

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'query comments with file' << END_CELL

geist-p query --dataset kb --file data/query

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'query comments with string' << END_CELL

geist-p query --dataset kb << __END_QUERY__

PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>

SELECT ?s ?o
WHERE {
    ?s rdfs:comment ?o
}
ORDER BY ?s ?o

__END_QUERY__

END_CELL

# ------------------------------------------------------------------------------

source ../common/trs-queries.sh

# ------------------------------------------------------------------------------

bash_cell 'destroy kb dataset' << END_CELL

geist-p destroy --dataset kb

END_CELL

# ------------------------------------------------------------------------------