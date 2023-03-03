(uiop:define-package #:project
  (:nicknames #:project/main)
  (:use #:cl)
  (:import-from #:jingle)
  (:import-from #:project/app
                #:*app*)
  (:export #:start-server
           #:stop-server))
(in-package #:project)

(defparameter *server-handler* nil)

(defun start-server ()
  (when *server-handler*
    (error "Server is already started"))
  (setf *server-handler* (clack:clackup *app*)))

(defun stop-server ()
  (unless *server-handler*
    (error "Server is not started"))
  (clack:stop *server-handler*)
  (setf *server-handler* nil))
