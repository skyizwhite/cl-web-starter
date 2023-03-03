(defpackage #:project/app
  (:use #:cl)
  (:import-from #:jingle)
  (:import-from #:project/controllers/hello
                #:greet)
  (:export #:*app*))
(in-package #:project/app)

(defparameter *app* (jingle:make-app))

(setf (jingle:route *app* "/hello" :method :GET) #'greet)

*app*
