(defpackage #:project/lib/routes
  (:use #:cl)
  (:import-from #:jingle)
  (:export #:register-handlers))
(in-package #:project/lib/routes)

(defun concatenate-path (parent child)
  (if (string= parent "/")
      child
      (concatenate 'string parent child)))

(defun flatten-routes (routes)
  (let ((path  (car routes))
        (binds (cadr routes))
        (sub-routes (cddr routes)))
    (append (loop :for (method handler) :on binds :by #'cddr
                  :collect
                     (if (eq (car handler) 'function)
                         ;handler is function
                         `(:path ,path
                           :method ,method
                           :handler ,handler)
                         ;handler is (function ...requirements)
                         `(:path ,path
                           :method ,method
                           :handler ,(car handler)
                           :requirements ,(cdr handler))))
            (when sub-routes
              (reduce #'append
                      (loop :for sub-route :in sub-routes
                            :collect (flatten-routes (cons (concatenate-path path
                                                                             (car sub-route))
                                                           (cdr sub-route)))))))))

(defmacro register-handlers (app &body roots)
  `(setf
    ,@(reduce
       #'append
       (loop
         :for root :in roots
         :collect
            (reduce
             #'append
             (loop
               :for route :in (flatten-routes root)
               :collect
                  (let ((path (getf route :path))
                        (method (getf route :method))
                        (handler (getf route :handler))
                        (requirements (getf route :requirements)))
                    `((jingle:route ,app ,path :method ,method ,@requirements) ,handler))))))))
