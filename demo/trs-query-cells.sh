
bash_cell query_trs_policies << END_CELL

# What policies are enforced by the TRS?

geist query --format table << __END_QUERY__

    PREFIX trov: <http://trace.org/trov#>
    PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
    PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>

    SELECT DISTINCT ?trsId ?policyId
    WHERE {
        ?trsId trov:enforcesTROPolicy ?policyId .
    } ORDER BY ?trsId ?policyId

__END_QUERY__

END_CELL
