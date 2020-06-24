alias Acl.Accessibility.Always, as: AlwaysAccessible
alias Acl.Accessibility.ByQuery, as: AccessByQuery
alias Acl.GraphSpec.Constraint.Resource, as: ResourceConstraint
alias Acl.GraphSpec, as: GraphSpec
alias Acl.GroupSpec, as: GroupSpec
alias Acl.GroupSpec.GraphCleanup, as: GraphCleanup

defmodule Acl.UserGroups.Config do
  def user_groups do
    # These elements are walked from top to bottom.  Each of them may
    # alter the quads to which the current query applies.  Quads are
    # represented in three sections: current_source_quads,
    # removed_source_quads, new_quads.  The quads may be calculated in
    # many ways.  The useage of a GroupSpec and GraphCleanup are
    # common.
    [
      # // PUBLIC
      %GroupSpec{
        name: "public",
        useage: [:read],
        access: %AlwaysAccessible{}, # Needed for mock-login page
        graphs: [ %GraphSpec{
                    graph: "http://mu.semte.ch/graphs/public",
                    constraint: %ResourceConstraint{
                      resource_types: [
                        "http://xmlns.com/foaf/0.1/Person",
                        "http://xmlns.com/foaf/0.1/OnlineAccount",
                        "http://data.vlaanderen.be/ns/besluit#Bestuurseenheid"
                      ]
                    } } ] },
      # // Logged in users
      %GroupSpec{
        name: "readers",
        useage: [:read, :read_for_write],
        access: %AccessByQuery{
          vars: ["session_group"],
          query: "PREFIX ext: <http://mu.semte.ch/vocabularies/ext/>
                  PREFIX mu: <http://mu.semte.ch/vocabularies/core/>
                  SELECT DISTINCT ?session_group WHERE {
                    <SESSION_ID> ext:sessionGroup/mu:uuid ?session_group
                    }" },
        graphs: [ %GraphSpec{
                    graph: "http://mu.semte.ch/graphs/organizations/",
                    constraint: %ResourceConstraint{
                      resource_types: [
                        "http://xmlns.com/foaf/0.1/Person",
                        "http://xmlns.com/foaf/0.1/OnlineAccount",
                        "http://www.w3.org/ns/adms#Identifier",
                        "http://mu.semte.ch/vocabularies/ext/DocumentStatus",
                        "http://www.semanticdesktop.org/ontologies/2007/03/22/nfo#FileDataObject",
                        "http://www.semanticdesktop.org/ontologies/2007/03/22/nfo#RemoteDataObject",
                        "http://www.w3.org/ns/prov#Location",
                        "http://mu.semte.ch/vocabularies/ext/BestuurseenheidClassificatieCode",
                        "http://data.vlaanderen.be/ns/besluit#Bestuursorgaan",
                        "http://mu.semte.ch/vocabularies/ext/BestuursorgaanClassificatieCode",
                        "http://data.vlaanderen.be/ns/besluit#Bestuurseenheid",
                        "http://mu.semte.ch/vocabularies/ext/ChartOfAccount",
                        "http://mu.semte.ch/vocabularies/ext/AuthenticityType",
                        "http://mu.semte.ch/vocabularies/ext/TaxType",
                        "http://mu.semte.ch/vocabularies/ext/SubmissionDocumentStatus",
                        "http://www.w3.org/2004/02/skos/core#ConceptScheme",
                        "http://www.w3.org/2004/02/skos/core#Concept",
                        "http://xmlns.com/foaf/0.1/Document",
                        "http://rdf.myexperiment.org/ontologies/base/Submission",
                        "http://mu.semte.ch/vocabularies/ext/SubmissionDocument",
                        "http://lblod.data.gift/vocabularies/besluit/TaxRate",
                        "http://lblod.data.gift/vocabularies/automatische-melding/FormData",
                        "http://mu.semte.ch/vocabularies/ext/Vendor",
                        "http://mu.semte.ch/vocabularies/ext/SubmissionReviewStatus",
                        "http://schema.org/Review",
                        "http://mu.semte.ch/vocabularies/ext/supervision/InzendingVoorToezicht", # still needed to be able to redirect old URLs correctly
                        "http://lblod.data.gift/vocabularies/search-queries-toezicht/SearchQuery"
                      ]
                    } } ] },
      %GroupSpec{
        name: "editors",
        useage: [:write],
        access: %AccessByQuery{
          vars: ["session_group"],
          query: "PREFIX ext: <http://mu.semte.ch/vocabularies/ext/>
                  PREFIX mu: <http://mu.semte.ch/vocabularies/core/>
                  SELECT DISTINCT ?session_group WHERE {
                    <SESSION_ID> ext:sessionGroup/mu:uuid ?session_group ;
                       ext:sessionRole ?role .
                    VALUES ?role { \"ABBDatabankToezicht-DatabankToezichtEditeur\" }
                    }" },
        graphs: [ %GraphSpec{
                    graph: "http://mu.semte.ch/graphs/organizations/",
                    constraint: %ResourceConstraint{
                      resource_types: [
                        "http://schema.org/Review",
                         "http://xmlns.com/foaf/0.1/Person",
                        "http://lblod.data.gift/vocabularies/search-queries-toezicht/SearchQuery"
                      ] } } ] },

      # // CLEANUP
      #
      %GraphCleanup{
        originating_graph: "http://mu.semte.ch/application",
        useage: [:write],
        name: "clean"
      }
    ]
  end
end
