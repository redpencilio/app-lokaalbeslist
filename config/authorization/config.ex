alias Acl.Accessibility.Always, as: AlwaysAccessible
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
        access: %AlwaysAccessible{},
        graphs: [ %GraphSpec{
                    graph: "http://mu.semte.ch/graphs/public",
                    constraint: %ResourceConstraint{
                      resource_types: [
                          "http://data.lblod.info/vocabularies/leidinggevenden/Bestuursfunctie",
                          "http://data.lblod.info/vocabularies/leidinggevenden/Functionaris",
                          "http://data.lblod.info/vocabularies/leidinggevenden/FunctionarisStatusCode",
                          "http://data.lblod.info/vocabularies/mobiliteit/Maatregelconcept",
                          "http://data.lblod.info/vocabularies/mobiliteit/Maatregelconceptcombinatie",
                          "http://data.lblod.info/vocabularies/mobiliteit/VerkeersbordconceptStatusCode",
                          "http://data.vlaanderen.be/ns/besluit#Agendapunt",
                          "http://data.vlaanderen.be/ns/besluit#Artikel",
                          "http://data.vlaanderen.be/ns/besluit#BehandelingVanAgendapunt",
                          "http://data.vlaanderen.be/ns/besluit#Besluit",
                          "http://data.vlaanderen.be/ns/besluit#Bestuurseenheid",
                          "http://data.vlaanderen.be/ns/besluit#Bestuursorgaan",
                          "http://data.vlaanderen.be/ns/besluit#Stemming",
                          "http://data.vlaanderen.be/ns/besluit#Zitting",
                          "http://data.vlaanderen.be/ns/mandaat#Fractie",
                          "http://data.vlaanderen.be/ns/mandaat#Mandaat",
                          "http://data.vlaanderen.be/ns/mandaat#Mandataris",
                          "http://data.vlaanderen.be/ns/persoon#Geboorte",
                          "http://mu.semte.ch/vocabularies/ext/BeleidsdomeinCode",
                          "http://mu.semte.ch/vocabularies/ext/BestuurseenheidClassificatieCode",
                          "http://mu.semte.ch/vocabularies/ext/BestuursfunctieCode",
                          "http://mu.semte.ch/vocabularies/ext/BestuursorgaanClassificatieCode",
                          "http://mu.semte.ch/vocabularies/ext/DynamicSubform",
                          "http://mu.semte.ch/vocabularies/ext/FormInput",
                          "http://mu.semte.ch/vocabularies/ext/FormNode",
                          "http://mu.semte.ch/vocabularies/ext/GeslachtCode",
                          "http://mu.semte.ch/vocabularies/ext/InputState",
                          "http://mu.semte.ch/vocabularies/ext/MandatarisStatusCode",
                          "http://mu.semte.ch/vocabularies/ext/supervision/DecisionType",
                          "http://mu.semte.ch/vocabularies/ext/supervision/DocumentAuthenticityType",
                          "http://mu.semte.ch/vocabularies/ext/supervision/InzendingVoorToezichtFormVersion",
                          "http://mu.semte.ch/vocabularies/ext/supervision/Nomenclature",
                          "http://mu.semte.ch/vocabularies/ext/supervision/TaxType",
                          "http://openbelgium-2021.lblod.info/vocabularies/leidinggevenden/Bestuursfunctie",
                          "http://openbelgium-2021.lblod.info/vocabularies/leidinggevenden/Functionaris",
                          "http://openbelgium-2021.lblod.info/vocabularies/mobiliteit/Maatregelconcept",
                          "http://openbelgium-2021.lblod.info/vocabularies/mobiliteit/Maatregelconceptcombinatie",
                          "http://purl.org/dc/terms/PeriodOfTime",
                          "http://schema.org/ContactPoint",
                          "http://www.semanticdesktop.org/ontologies/2007/03/22/nfo#FileDataObject",
                          "http://www.w3.org/2000/01/rdf-schema#Class",
                          "http://www.w3.org/2004/02/skos/core#Concept",
                          "http://www.w3.org/2004/02/skos/core#ConceptScheme",
                          "http://www.w3.org/ns/locn#Address",
                          "http://www.w3.org/ns/org#Membership",
                          "http://www.w3.org/ns/org#Organization",
                          "http://www.w3.org/ns/person#Person",
                          "http://www.w3.org/ns/prov#Location",
                          "http://xmlns.com/foaf/0.1/Document",
                          "http://xmlns.com/foaf/0.1/Image",
                          "http://xmlns.com/foaf/0.1/OnlineAccount",
                          "http://xmlns.com/foaf/0.1/Person",
                          "https://data.vlaanderen.be/id/concept/BesluitDocumentType/13fefad6-a9d6-4025-83b5-e4cbee3a8965",
                          "https://data.vlaanderen.be/id/concept/BesluitDocumentType/3fa67785-ffdc-4b30-8880-2b99d97b4dee",
                          "https://data.vlaanderen.be/id/concept/BesluitDocumentType/8e791b27-7600-4577-b24e-c7c29e0eb773",
                          "https://data.vlaanderen.be/id/concept/BesluitType/1869e152-e724-4dd7-927c-a11e7d832858",
                          "https://data.vlaanderen.be/id/concept/BesluitType/2f189152-1786-4b55-a3a9-d7f06de63f1c",
                          "https://data.vlaanderen.be/id/concept/BesluitType/35c15ea0-d0c3-4ba7-b91f-b1c6264800b1",
                          "https://data.vlaanderen.be/id/concept/BesluitType/4673d472-8dbc-4cea-b3ab-f92df3807eb3",
                          "https://data.vlaanderen.be/id/concept/BesluitType/4d8f678a-6fa4-4d5f-a2a1-80974e43bf34",
                          "https://data.vlaanderen.be/id/concept/BesluitType/84121221-4217-40e3-ada2-cd1379b168e1",
                          "https://data.vlaanderen.be/id/concept/BesluitType/849c66c2-ba33-4ac1-a693-be48d8ac7bc7",
                          "https://data.vlaanderen.be/id/concept/BesluitType/a8486fa3-6375-494d-aa48-e34289b87d5b",
                          "https://data.vlaanderen.be/id/concept/BesluitType/ba5922c9-cfad-4b2e-b203-36479219ba56",
                          "https://data.vlaanderen.be/id/concept/BesluitType/c945b531-4742-43fe-af55-b13da6ecc6fe",
                          "https://data.vlaanderen.be/id/concept/BesluitType/d7060f97-c417-474c-abc6-ef006cb61f41",
                          "https://data.vlaanderen.be/id/concept/BesluitType/df261490-cc74-4f80-b783-41c35e720b46",
                          "https://data.vlaanderen.be/id/concept/BesluitType/efa4ec5a-b006-453f-985f-f986ebae11bc",
                          "https://data.vlaanderen.be/id/concept/BesluitType/f56c645d-b8e1-4066-813d-e213f5bc529f",
                          "https://data.vlaanderen.be/id/concept/BesluitType/fb21d14b-734b-48f4-bd4e-888163fd08e8",
                          "https://data.vlaanderen.be/id/concept/BesluitType/fb92601a-d189-4482-9922-ab0efc6bc935",
                          "https://data.vlaanderen.be/ns/mobiliteit#Verkeersbordcategorie",
                          "https://data.vlaanderen.be/ns/mobiliteit#Verkeersbordconcept",
                          "https://data.vlaanderen.be/ns/mobiliteit#VerkeersbordconceptStatus",
                      ]
                    } } ] },

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