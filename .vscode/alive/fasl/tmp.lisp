(asdf:defsystem "mammoth"

  :description "A mongodb like NoSQL document database written in Common Lisp"
  :version "0.1.0"
  :author "Prajna Prayas"
  :license "MIT"
  :depends-on (:alexandria :frugal-uuid)
  :serial t
  :components ((:file "packages")
               (:file "main")
               (:file "storage")))