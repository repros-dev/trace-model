#!/usr/bin/env bash

# ------------------------------------------------------------------------------

bash_cell 'convert tro1 from jsonld to csv' << END_CELL

jsonld2csv --file data/tro1.jsonld --output products

cat products/tro1*

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'convert tro1 from jsonld to csv' << END_CELL

jsonld2csv --file data/tro2.jsonld --output products

cat products/tro2*

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'convert tro1 from jsonld to csv' << END_CELL

jsonld2csv --file data/tro3.jsonld --output products

cat products/tro3*

END_CELL

# ------------------------------------------------------------------------------
