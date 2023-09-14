#!/usr/bin/env bash

source ../common/query-tro.sh

# ------------------------------------------------------------------------------

bash_cell tro_report_inline << END_CELL

geist report --outputroot report_inline << END_TEMPLATE

{%- use "templates.geist" %}
{%- create %} tro/tro.jsonld {% endcreate %}

{%- html "overall_tro_graph.html" %}
{%- head "Overall TRO Graph" %}

    <body>
        <h1>Overall TRO Graph</h1>
        {%- graph dataset="kb", mappings="mappings.json" as tro_graph %}
        {% img src="tro.svg" %} {{ tro_graph }} {% endimg %}
    </body>

{% endhtml %} 

{%- html "report.html" %}
{%- head "TRO Report" %}

    <body>
        <h1>TRO Report</h1>
        <p>This report shows the TRO of downloading LBDA dataset from NOAA website and preparing for use by researchers employing the SKOPE application.
        <h3>1. The TRO was assembled by what TRS?</h3>
        {%- table mappings="mappings.json" %}
            {% query_tro_trs_str %}
        {% endtable %}
        
        <h3>2. What capabilities does the TRS have?</h3>
        {%- table mappings="mappings.json" %}
            {% query_trs_capability_str %}
        {% endtable %}

        <h3>3. What TRPs does the TRO have? What arrangements are accessed and contributed to per TRP accordingly?</h3>
        {% img src="trp.svg" %}
            {%- gv_graph "trp", "LR" %}
            nodesep=0.6
            node[shape=box style="filled, rounded" fillcolor="#b3e2cd" peripheries=1 fontname=Courier]
            {%- map isfilepath=False, mappings="mappings.json" as query_trp_shorten %} {% query_trp_str %} {% endmap %}
            {%- set query_trp = query_trp_shorten | json2df %}
            {% for _, row in query_trp.iterrows() %}
                {% gv_labeled_edge row["in"], row["out"], row["trp"] %}
            {% endfor %}
            {% gv_end %}
        {% endimg %}

        <h3>4. What artifacts are included in each arrangement?</h3>
        {% img src="arrangement.svg" %}
            {%- gv_graph "arrangement", "LR" %}
            nodesep=0.6
            node[shape=box style="filled, rounded" fillcolor="#b3e2cd" peripheries=1 fontname=Courier]
            {%- map isfilepath=False, mappings="mappings.json" as query_arrangement_shorten %} {% query_arrangement_str %} {% endmap %}
            {%- set query_arrangement = query_arrangement_shorten | json2df %}
            {% for _, row in query_arrangement.iterrows() %}
                {% gv_edge row["arrangement"], row["artifact"] %}
            {% endfor %}
            {% gv_end %}
        {% endimg %}

        <h3>5. What are the type, comment, mimeType, and sha256 of each artifact? Which composition does it belong to?</h3>
        {%- table mappings="mappings.json" %}
            {% query_artifact_str %}
        {% endtable %}

        <h3>6. Overall graph</h3>
        <a href="overall_tro_graph.html">Zoom in the graph</a>
        <img src="tro.svg" width="100%">

</body>
{% endhtml %}

{%- destroy %}

END_TEMPLATE

END_CELL

# ------------------------------------------------------------------------------

bash_cell tro_report_file << END_CELL

geist report --file tro_report --outputroot report_file

END_CELL

# ------------------------------------------------------------------------------