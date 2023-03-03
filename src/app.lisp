(defpackage #:project/app
  (:use #:cl)
  (:import-from #:jingle)
  (:import-from #:project/lib/routes
                #:register-handlers)
  (:import-from #:project/controllers/hello
                #:greet)
  (:export #:*app*))
(in-package #:project/app)

(defparameter *app* (jingle:make-app))

(register-handlers *app*
  ("/api"     ()
   ("/v1"     ()
    ("/hello" (:get #'greet)))))

*app*
