
# ------------------------------------------------------------------------------

bash_cell 'query trs enforced policies' << END_CELL

# What TRS policies are enforced by the TRS?

geist query --format table << __END_QUERY__

    PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
    PREFIX trov: <https://w3id.org/trace/2022/10/trov#>

    SELECT DISTINCT ?trs ?policyName ?policyDescription
    WHERE {
        ?trs      rdf:type        trov:System .
        ?trs      trov:enforces   ?policy .
        ?policy   rdf:type        trov:SystemPolicy .
        ?policy   rdfs:label      ?policyName .
        ?policy   rdfs:comment    ?policyDescription .
    } ORDER BY ?trs ?policyName

__END_QUERY__

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'query tro enforced policies' << END_CELL

# What TRO policies are enforced by the TRS?

geist query --format table << __END_QUERY__

    PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
    PREFIX trov: <https://w3id.org/trace/2022/10/trov#>

    SELECT DISTINCT ?trs ?policyName ?policyDescription
    WHERE {
        ?trs        rdf:type        trov:System .
        ?trs        trov:enforces   ?policy .
        ?policy     rdf:type        trov:ObjectPolicy .
        ?policy     rdfs:label      ?policyName .
        ?policy     rdfs:comment    ?policyDescription .
    } ORDER BY ?trs ?policyName

__END_QUERY__

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'query all enforced policies' << END_CELL

# What policies are enforced by the TRS?

geist query --format table << __END_QUERY__

    PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
    PREFIX trov: <https://w3id.org/trace/2022/10/trov#>

    SELECT DISTINCT ?trs ?policyName ?policyDescription
    WHERE {
        ?trs      rdf:type        trov:System .
        ?trs      trov:enforces   ?policy .
        ?policy   rdfs:label      ?policyName .
        ?policy   rdfs:comment    ?policyDescription .
    } ORDER BY ?trs ?policyName

__END_QUERY__

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'query trs prevented policies' << END_CELL

# What TRS policies are prevented by the TRS?

geist query --format table << __END_QUERY__

    PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
    PREFIX trov: <https://w3id.org/trace/2022/10/trov#>

    SELECT DISTINCT ?trs ?policyName ?policyDescription
    WHERE {
        ?trs      rdf:type        trov:System .
        ?trs      trov:prevents   ?policy .
        ?policy   rdf:type        trov:SystemPolicy .
        ?policy   rdfs:label      ?policyName .
        ?policy   rdfs:comment    ?policyDescription .
    } ORDER BY ?trs ?policyName

__END_QUERY__

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'query tro prevented policies' << END_CELL

# What TRO policies are prevented by the TRS?

geist query --format table << __END_QUERY__

    PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
    PREFIX trov: <https://w3id.org/trace/2022/10/trov#>

    SELECT DISTINCT ?trs ?policyName ?policyDescription
    WHERE {
        ?trs        rdf:type        trov:System .
        ?trs        trov:prevents   ?policy .
        ?policy     rdf:type        trov:ObjectPolicy .
        ?policy     rdfs:label      ?policyName .
        ?policy     rdfs:comment    ?policyDescription .
    } ORDER BY ?trs ?policyName

__END_QUERY__

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'query all prevented policies' << END_CELL

# What policies are prevented by the TRS?

geist query --format table << __END_QUERY__

    PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
    PREFIX trov: <https://w3id.org/trace/2022/10/trov#>

    SELECT DISTINCT ?trs ?policyName ?policyDescription
    WHERE {
        ?trs      rdf:type        trov:System .
        ?trs      trov:prevents   ?policy .
        ?policy   rdfs:label      ?policyName .
        ?policy   rdfs:comment    ?policyDescription .
    } ORDER BY ?trs ?policyName

__END_QUERY__

END_CELL

# ------------------------------------------------------------------------------
