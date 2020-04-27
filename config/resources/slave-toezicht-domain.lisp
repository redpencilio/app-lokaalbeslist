;; Association resource which should describe properties associated with the form to use
;; now only 'validity period' is specified, but could be extended with specific bestuursorgaan/eenheid/etc..

(define-resource inzending-voor-toezicht ()
  :class (s-prefix "toezicht:InzendingVoorToezicht") ;; subclass of nie:InformationElement > nfo:DataContainer
  :properties `()
  :resource-base (s-url "http://data.lblod.info/inzendingen-voor-toezicht/")
  :features `(no-pagination-defaults include-uri)
  :on-path "inzendingen-voor-toezicht")