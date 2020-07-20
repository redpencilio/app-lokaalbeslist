(in-package :mu-cl-resources)

(defparameter *cache-count-queries* nil)
(defparameter *supply-cache-headers-p* t
  "when non-nil, cache headers are supplied.  this works together with mu-cache.")
(setf *cache-model-properties-p* t)

(defparameter *include-count-in-paginated-responses* t
  "when non-nil, all paginated listings will contain the number
   of responses in the result object's meta.")
(defparameter *max-group-sorted-properties* nil)
(defparameter sparql:*experimental-no-application-graph-for-sudo-select-queries* t)

(read-domain-file "slave-toezicht-domain.lisp")
(read-domain-file "slave-files-domain.lisp")
(read-domain-file "slave-besluit-domain.lisp")
(read-domain-file "slave-users-domain.lisp")
(read-domain-file "slave-leidinggevenden-domain.lisp")
(read-domain-file "master-submissions-domain.lisp")
(read-domain-file "master-search-query.lisp")