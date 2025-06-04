(in-package :mammoth.query)

;;; A very basic definition of the query DSL

(defparameter *supported-operators*
              "Allwed operator in the query language"
              '(:= :/= :< :<= :> :>= :and :or))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Public API

(defun evaluate-query (store collection-name query-form)
  "Returns a list of documents from COLLECTIOn-NAME in STORE
    that satisfy the QUERY-FORM. QUERY-FORM is a Lisp list 
    using operator in *supported-operators* "
  (error 'not-implemented

    :format-control "evaluate query is not implemented yet"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Internal stubs
(defun parse-query (query-form)
  "Validate and transform QUERY-FORM into an internal representation (e.g a tree of predicates)"
  (declare (ignore query-form)) nil)

(defun document-matches-p (document predicate-tree)
  "Return T if DOCUMENT (an alist or hashtable) satisfies PREDICATE-TREE. PREDICATE-TREE is the output of PARSE-QUERY"

  (declare (ignore document predicate-tree)) nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Helper functions

(defun get-field-value (document field)
  "Extract the value of FIELD (a keyword) from DOCUMENT (alist or hashtable)"

  (cond
   ((and (listp document) (assoc field document))
     (cdr (assoc field document)))
   ((and (hash-table-p document) (gethash field document))
     (gethash field document)) (t nil)))


(defun compare-values (lhs operator rhs)
  "Return T if (lhs OPERATOR rhs) holds.  OPERATOR is one of :=, :<, etc."
  (case operator
    (:= (eql lhs rhs))
    (:/= (not (eql lhs rhs)))
    (:< (and (numberp lhs) (numberp rhs) (< lhs rhs)))
    (:<= (and (numberp lhs) (numberp rhs) (<= lhs rhs)))
    (:> (and (numberp lhs) (numberp rhs) (> lhs rhs)))
    (:>= (and (numberp lhs) (numberp rhs) (>= lhs rhs)))
    (t (error "Unsupported operator ~A" operator))))