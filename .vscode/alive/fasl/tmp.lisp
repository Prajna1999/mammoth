(defpackage :mammoth

  (:use :cl :alexandria)
  (:export :hello))

(defpackage :mammoth.storage
  (:use :cl :alexandria :frugal-uuid)
  (:export :make-store :insert-document :get-document :delete-document))

(defpackage :mammoth.query

  (:use :cl :alexandria)
  (:export :evaluate-query))