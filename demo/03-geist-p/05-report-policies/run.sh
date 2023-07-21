#!/usr/bin/env bash

# paths to data files
COMMON=../common

# ------------------------------------------------------------------------------

bash_cell 'import jsonld' << END_CELL

# Import TRO and TRS as JSON-LD and export as N-TRIPLES
geist-p create --dataset kb --inputformat json-ld --inputfile ${COMMON}/trace-vocab.jsonld --infer owl

END_CELL

# ------------------------------------------------------------------------------

bash_cell trs_policies << END_CELL

# What are all of the policies a TRS could enforce?

geist-p query --dataset kb << END_QUERY

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

geist-p query --dataset kb << END_QUERY

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

geist-p report --dataset kb << 'END_TEMPLATE'

    {% set trs_policies = query("""
        SELECT DISTINCT ?trsPolicyName ?trsPolicyDescription
        WHERE {
            ?trsPolicy   rdf:type      trov:SystemPolicy .
            ?trsPolicy   rdfs:label    ?trsPolicyName .
            ?trsPolicy   rdfs:comment  ?trsPolicyDescription .
        } ORDER BY ?trsPolicyName
    """) %}
    {% set tro_policies = query("""
        SELECT DISTINCT ?troPolicyName ?troPolicyDescription
        WHERE {
            ?troPolicy   rdf:type      trov:ObjectPolicy .
            ?troPolicy   rdfs:label    ?troPolicyName .
            ?troPolicy   rdfs:comment  ?troPolicyDescription .
        } ORDER BY ?troPolicyName
    """) %}

    List of policies that a TRS could enforce:
    ==========================================
    {% for _, row in trs_policies.iterrows() -%}
        {{ row["trsPolicyName"] }} : {{ row["trsPolicyDescription"] }}
    {% endfor %}

    List of policies that a TRO could enforce:
    ==========================================
    {% for _, row in tro_policies.iterrows() -%}
        {{ row["troPolicyName"] }} : {{ row["troPolicyDescription"] }}
    {% endfor %}

END_TEMPLATE

END_CELL

# ------------------------------------------------------------------------------

bash_cell destroy_dataset_kb << END_CELL

geist-p destroy --dataset kb

END_CELL

# ------------------------------------------------------------------------------