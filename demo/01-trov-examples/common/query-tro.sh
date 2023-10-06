

TRACE_VOCAB=$REPRO_MNT/exports/trace-vocab.jsonld
TRO_DECLARATION=tro/tro.jsonld
TRS_CERTIFICATE=trs/trs.jsonld
GEIST_TEMPLATES=../common/templates.geist

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

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'query tro attributes' << END_CELL

# What subclasses of TROAttribute have been defined?

geist query --dataset kb << __END_QUERY__

    PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
    PREFIX trov: <https://w3id.org/trace/2023/05/trov#>

    SELECT DISTINCT ?attribute ?attributeLabel ?attributeComment
    WHERE {
        ?attribute      rdfs:subClassOf   trov:TROAttribute .
        ?attribute      rdfs:label        ?attributeLabel .
        ?attribute      rdfs:comment      ?attributeComment .
    } ORDER BY ?attribute ?attributeLabel ?attributeComment
    
__END_QUERY__

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'query trs attributes' << END_CELL

# What subclasses of TRSAttribute have been defined?

geist query --dataset kb << __END_QUERY__

    PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
    PREFIX trov: <https://w3id.org/trace/2023/05/trov#>

    SELECT DISTINCT ?attribute ?attributeLabel ?attributeComment
    WHERE {
        ?attribute      rdfs:subClassOf   trov:TRSAttribute .
        ?attribute      rdfs:label        ?attributeLabel .
        ?attribute      rdfs:comment      ?attributeComment .
    } ORDER BY ?attribute ?attributeLabel ?attributeComment
    
__END_QUERY__

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'reload trov vocabulary without inferences' << END_CELL

# Destroy the dataset
geist destroy --dataset kb

# Import TRACE vocabulary and TRO Manifest and export as N-TRIPLES
geist create --dataset kb --inputformat json-ld --inputfile ${TRACE_VOCAB} --infer none

END_CELL

# ------------------------------------------------------------------------------


bash_cell 'query subclass vocab' << END_CELL

# What (ParentClass, ChildClass) pairs does trov vocabulary have?

geist report --outputroot products << END_TEMPLATE

{%- use "${GEIST_TEMPLATES}" %}
{%- query isfilepath=False as query_subclass_vocab_str %}
    PREFIX rdf:  <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
    PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>

    SELECT DISTINCT ?ParentLabel ?ChildLabel
    WHERE {
        ?ParentClass    rdf:type        rdfs:Class ;
                        rdfs:label      ?ParentLabel .
        
        ?ChildClass     rdfs:subClassOf ?ParentClass ;
                        rdf:type        rdfs:Class ;
                        rdfs:label      ?ChildLabel .

        FILTER (?ParentLabel != ?ChildLabel)
    }
    ORDER BY ?ParentLabel ?ChildLabel
{% endquery %}
{%- set query_subclass_vocab = query_subclass_vocab_str | json2df %}

{%- html "report_subclass.html" %}
{%- head "Subclass Report" %}
    <body>
        <h1>Visualize subclass of the vocabularies</h1>
        <h4>1. SVG</h4>
        {% img src="img.svg", width="80%" %}
            {%- gv_graph "subclass_vocab_graph", "LR" %}
            {%- gv_title "Subclass Vocab Graph" %}

            node[shape=box style="filled, rounded" fillcolor="#b3e2cd" peripheries=1 fontname=Courier]
            {% for _, row in query_subclass_vocab.iterrows() %}
                {% gv_edge row["ParentLabel"], row["ChildLabel"] %}
            {% endfor %}

            {% gv_end %}
        {% endimg %}

        <h4>2. GV</h4>
        {% img src="img.gv" %}
            {%- gv_graph "subclass_vocab_graph", "LR" %}
            {%- gv_title "Subclass Vocab Graph" %}

            node[shape=box style="filled, rounded" fillcolor="#b3e2cd" peripheries=1 fontname=Courier]
            {% for _, row in query_subclass_vocab.iterrows() %}
                {% gv_edge row["ParentLabel"], row["ChildLabel"] %}
            {% endfor %}

            {% gv_end %}
        {% endimg %}
        
        <h4>3. Table</h3>
        {%- table %}
            {{ query_subclass_vocab_str }}
        {% endtable %}
</body>
{% endhtml %}
{%- destroy %}
    
END_TEMPLATE

END_CELL

# ------------------------------------------------------------------------------
