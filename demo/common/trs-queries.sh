
# ------------------------------------------------------------------------------

bash_cell 'query trs policies' << END_CELL

# What TRS policies are enforced by the TRS?

geist query --format table << __END_QUERY__

    PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
    PREFIX trov: <http://trace.org/trov#>

    SELECT DISTINCT ?trsId ?policyName ?policyDescription
    WHERE {
        ?trsId      rdf:type                trov:TraceSystem .
        ?trsId      trov:enforcesTRSPolicy  ?policyId .
        ?policyId   trov:policyName         ?policyName .
        ?policyId   trov:policyDescription  ?policyDescription .
    } ORDER BY ?trsId ?policyName

__END_QUERY__

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'query tro policies' << END_CELL

# What TRO policies are enforced by the TRS?

geist query --format table << __END_QUERY__

    PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
    PREFIX trov: <http://trace.org/trov#>

    SELECT DISTINCT ?trsId ?policyName ?policyDescription
    WHERE {
        ?trsId      rdf:type                trov:TraceSystem .
        ?trsId      trov:enforcesTROPolicy  ?policyId .
        ?policyId   trov:policyName         ?policyName .
        ?policyId   trov:policyDescription  ?policyDescription .
    } ORDER BY ?trsId ?policyName

__END_QUERY__

END_CELL

# ------------------------------------------------------------------------------

bash_cell 'query all policies' << END_CELL

# What policies are enforced by the TRS?

geist query --format table << __END_QUERY__

    PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
    PREFIX trov: <http://trace.org/trov#>

    SELECT DISTINCT ?trsId ?policyName ?policyDescription
    WHERE {
        ?trsId      rdf:type                trov:TraceSystem .
        ?trsId      trov:enforcesPolicy     ?policyId .
        ?policyId   trov:policyName         ?policyName .
        ?policyId   trov:policyDescription  ?policyDescription .
    } ORDER BY ?trsId ?policyName

__END_QUERY__

END_CELL

# ------------------------------------------------------------------------------
