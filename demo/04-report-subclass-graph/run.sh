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

bash_cell export_citation_data << END_CELL

geist export --format nt | sort

END_CELL

# ------------------------------------------------------------------------------

bash_cell query_subclass_vocab << END_CELL

geist query -format table << END_QUERY

    PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
    PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>

    SELECT DISTINCT ?ChildLabel ?ParentLabel
    WHERE {
        ?ParentClass    rdf:type        rdfs:Class ;
                        rdfs:label      ?ParentLabel .
        
        ?ChildClass     rdfs:subClassOf ?ParentClass ;
                        rdf:type        rdfs:Class ;
                        rdfs:label      ?ChildLabel .

        FILTER (?ChildLabel != ?ParentLabel)
    }
    ORDER BY ?ChildLabel ?ParentLabel

END_QUERY

END_CELL

# ------------------------------------------------------------------------------

bash_dot_cell visualize_subclass_vocab_using_graphviz << 'END_CELL'

geist report << 'END_TEMPLATE'

    {{{
        {{ include "graphviz.g" }}

        {{ query "select_subclass_vocab" '''
            SELECT DISTINCT ?ChildLabel ?ParentLabel
            WHERE {
                ?ParentClass    rdf:type        rdfs:Class ;
                                rdfs:label      ?ParentLabel .
                
                ?ChildClass     rdfs:subClassOf ?ParentClass ;
                                rdf:type        rdfs:Class ;
                                rdfs:label      ?ChildLabel .

                FILTER (?ChildLabel != ?ParentLabel)
            }
            ORDER BY ?ChildLabel ?ParentLabel
        ''' }}
    }}}                                                              \\

                                                                     \\
    {{ prefix "rdf" "http://www.w3.org/1999/02/22-rdf-syntax-ns#" }} \\
    {{ prefix "rdfs" "http://www.w3.org/2000/01/rdf-schema#" }}      \\
                                                                     \\
    {{ gv_graph "subclass_vocab_graph" "BT" }}
    {{ gv_title "Subclass Vacab Graph" }}
    {{ gv_cluster "subclass" }}

    node[shape=box style="filled" fillcolor="#CCFFCC" peripheries=1 fontname=Courier]
    {{ range $ClassLabel := select_subclass_vocab | rows }}         \\
        {{ gv_edge (index $ClassLabel 0) (index $ClassLabel 1) }}
    {{ end }}
                                                                    \\
    {{ gv_cluster_end }}
    {{ gv_end }}

END_TEMPLATE

END_CELL

# ------------------------------------------------------------------------------
