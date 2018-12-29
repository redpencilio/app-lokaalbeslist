(define-resource gebruiker ()
  :class (s-prefix "foaf:Person")
  :resource-base (s-url "http://data.lblod.info/id/gebruiker/")
  :properties `((:voornaam :string ,(s-prefix "foaf:firstName"))
                (:achternaam :string ,(s-prefix "foaf:familyName"))
                (:rijksregister-nummer :string ,(s-prefix "dct:identifier")))
  :has-many `((account :via ,(s-prefix "foaf:account")
                       :as "account")
              (bestuurseenheid :via ,(s-prefix "foaf:member")
                              :as "bestuurseenheden")
             )
  :on-path "gebruikers"
)

(define-resource account ()
  :class (s-prefix "foaf:OnlineAccount")
  :resource-base (s-url "http://data.lblod.info/id/account/")
  :properties `((:provider :via ,(s-prefix "foaf:accountServiceHomepage"))
                (:vo-id :via ,(s-prefix "dct:identifier")))
  :has-one `((gebruiker :via ,(s-prefix "foaf:account")
                         :inverse t
                         :as "gebruiker"))
;;; Temporary workaround until authentication through ACM/IDM is fixed
  :has-many `((permission :via ,(s-prefix "ext:hasPermission")
                         :as "permissions"))
  :on-path "accounts"
)

;;;;;;
;;;
;;; Temporary workaround until authentication through ACM/IDM is fixed
;;;
;;;;;;
(define-resource permission ()
  :class (s-prefix "ext:Permission")
  :resource-base (s-url "http://data.lblod.info/id/account-permissions/")
  :properties `((:name :via ,(s-prefix "skos:prefLabel")))
  :has-many `((account :via ,(s-prefix "ext:hasPermission")
                         :inverse t
                         :as "accounts"))
  :features `(include-uri)
  :on-path "permissions"
)
