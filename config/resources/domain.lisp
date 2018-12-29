(in-package :mu-cl-resources)

(defparameter *cache-count-queries* t)
(defparameter *supply-cache-headers-p* t
  "when non-nil, cache headers are supplied.  this works together with mu-cache.")
(setf *cache-model-properties-p* t)
(defparameter *include-count-in-paginated-responses* t
  "when non-nil, all paginated listings will contain the number
   of responses in the result object's meta.")
(defparameter *max-group-sorted-properties* nil)

(read-domain-file "slave-dynamic-forms-domain.lisp")
(read-domain-file "slave-toezicht-domain.lisp")
(read-domain-file "slave-files-domain.lisp")
(read-domain-file "slave-besluit-domain.lisp")
(read-domain-file "slave-users-domain.lisp")

(define-resource inzending-voor-toezicht-melding ()
  :class (s-prefix "toezicht:InzendingVoorToezichtMelding")
  :properties `((:description :string ,(s-prefix "dct:description")))
  :has-one `((melding-status :via ,(s-prefix "adms:status")
                             :as "status")
             (inzending-voor-toezicht :via ,(s-prefix "dct:subject")
                             :as "inzending-voor-toezicht"))
  :resource-base (s-url "http://data.lblod.info/inzending-voor-toezicht-meldingen/")
  :on-path "inzending-voor-toezicht-meldingen")

(define-resource melding-status ()
  :class (s-prefix "toezicht:MeldingStatus")
  :properties `((:label :string ,(s-prefix "skos:prefLabel")))
  :has-many `((inzending-voor-toezicht-melding :via ,(s-prefix "adms:status")
                                               :inverse t
                                               :as "meldingen"))
  :resource-base (s-url "http://data.lblod.info/melding-statuses/")
  :features `(no-pagination-defaults include-uri)
  :on-path "melding-statuses")
