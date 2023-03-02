(defsystem "project"
  :version "0.0.0"
  :description "Starter kit for web development with Common Lisp"
  :author "paku"
  :license "MIT"
  :class :package-inferred-system
  :pathname "src"
  :depends-on ("project/main")
  :in-order-to ((test-op (test-op "project-tests"))))
