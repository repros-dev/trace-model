#!/usr/bin/env bash

# paths to data files
COMMON=../common

# ------------------------------------------------------------------------------

bash_cell 'import jsonld' << END_CELL

# Import TRO and TRS as JSON-LD and export as N-TRIPLES
geist destroy --dataset kb --quiet
geist create --dataset kb --infer owl --quiet
geist import --format jsonld --file ${COMMON}/trace-vocab.jsonld

END_CELL

# ------------------------------------------------------------------------------

bash_cell trs_policies << END_CELL

# What are all of the policies a TRS could enforce?

geist query -format table << END_QUERY

    PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
    PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
    PREFIX trov: <https://w3id.org/trace/2022/10/trov#>

    SELECT DISTINCT ?trsPolicyName ?trsPolicyDescription
    WHERE {
        ?trsPolicy   rdf:type      trov:SystemPolicy .
        ?trsPolicy   rdfs:label    ?trsPolicyName .
        ?trsPolicy   rdfs:comment  ?trsPolicyDescription .
    } ORDER BY ?trsPolicyName

END_QUERY

END_CELL

# ------------------------------------------------------------------------------

bash_cell tro_policies << END_CELL

# What are all of he policies a TRO could enforce?

geist query -format table << END_QUERY

    PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
    PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
    PREFIX trov: <https://w3id.org/trace/2022/10/trov#>

    SELECT DISTINCT ?troPolicyName ?troPolicyDescription
    WHERE {
        ?troPolicy   rdf:type      trov:ObjectPolicy .
        ?troPolicy   rdfs:label    ?troPolicyName .
        ?troPolicy   rdfs:comment  ?troPolicyDescription .
    } ORDER BY ?troPolicyName

END_QUERY

END_CELL

# ------------------------------------------------------------------------------

bash_cell report_trs_and_tro_policies << 'END_CELL'

# A single report that gives the results of two queries of the vocabulary: 
# 1) What are all of the policies a TRS could enforce? 
# 2) What are all of the policies a TRO could enforce?

geist report << 'END_TEMPLATE'
    {{{
        {{ query "trs_policies" '''
            SELECT DISTINCT ?trsPolicyName ?trsPolicyDescription
            WHERE {
                ?trsPolicy   rdf:type      trov:SystemPolicy .
                ?trsPolicy   rdfs:label    ?trsPolicyName .
                ?trsPolicy   rdfs:comment  ?trsPolicyDescription .
            } ORDER BY ?trsPolicyName
        '''}}
        {{ query "tro_policies" '''
            SELECT DISTINCT ?troPolicyName ?troPolicyDescription
            WHERE {
                ?troPolicy   rdf:type      trov:ObjectPolicy .
                ?troPolicy   rdfs:label    ?troPolicyName .
                ?troPolicy   rdfs:comment  ?troPolicyDescription .
            } ORDER BY ?troPolicyName
        '''}}
    }}}

    {{ prefix "rdf" "http://www.w3.org/1999/02/22-rdf-syntax-ns#" }}       \\
    {{ prefix "rdfs" "http://www.w3.org/2000/01/rdf-schema#" }}            \\
    {{ prefix "trov" "https://w3id.org/trace/2022/10/trov#" }}             \\

    List of policies that a TRS could enforce:
    ==========================================
    {{ range $Policy := trs_policies | rows }}                             \\
        {{ index $Policy 0 }} : {{ index $Policy 1 }}
    {{ end }}

    List of policies that a TRO could enforce:
    ==========================================
    {{ range $Policy := tro_policies | rows }}                             \\
        {{ index $Policy 0 }} : {{ index $Policy 1 }}
    {{ end }}

END_TEMPLATE

END_CELL

# ------------------------------------------------------------------------------
