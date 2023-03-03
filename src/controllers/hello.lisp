(defpackage #:project/controllers/hello
  (:use #:cl)
  (:import-from #:jingle)
  (:export #:greet))
(in-package #:project/controllers/hello)

(defun greet (params)
  (declare (ignore params))
  (jingle:with-json-response
    '(:|text| "Hello, world!")))
