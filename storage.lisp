(in-package :mammoth.storage)
(defclass store ()
    ((collections :initform (make-hash-table :test 'equal)
                  :accessor store-collections
                  :documentation "A hash table mapping collection names to their data hash tables.")))


; create the in memory document store
(defun make-store ()
  "Create a new in memory document store."
  (make-instance 'store))


(defun get-collection (store name)
  "Return a collection hash-table by name, create if missing."
  (or (gethash name (store-collections store))
      (setf (gethash name (store-collections store))
        (make-hash-table :test 'equal))))


; insert documents

(defun insert-document (store collection-name doc)
  "Insert a document (an alist) into the named collection.
    If it lacks an _id key, a uuid is generated
    "
  (let ((coll (get-collection store collection-name))
        (id (or (cdr (assoc :_id doc)) (frugal-uuid:make-v4-string))))
    (setf (gethash id coll) (acons :_id id doc)) id))

; get document by id from a collection
(defun get-document (store collection-name id)
  "Get a document by ID from the collection"
  (gethash id (get-collection store collection-name)))


;   delete a document from a collection
(defun delete-document (store collection-name id)
  "Remove a document by ID from the collection."
  (remhash id (get-collection store collection-name)))