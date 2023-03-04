(defpackage #:project/lib/routes
  (:use #:cl)
  (:import-from #:jingle)
  (:export #:register-routes))
(in-package #:project/lib/routes)

(defun concatenate-path (parent child)
  (if (string= parent "/")
      child
      (concatenate 'string parent child)))

(defun flatten-route-trees (route-trees)
  (reduce #'append
          (loop
            :for route-tree :in route-trees
            :collect
               (let ((path  (car route-tree))
                     (binds (cadr route-tree))
                     (sub-route-trees (cddr route-tree)))
                 (append (loop
                           :for (method handler) :on binds :by #'cddr
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
                         (when sub-route-trees
                           (flatten-route-trees
                            (loop
                              :for sub-route-tree :in sub-route-trees
                              :collect
                                 (cons (concatenate-path path
                                                         (car sub-route-tree))
                                       (cdr sub-route-tree))))))))))

(defmacro register-routes (app &body route-trees)
  `(setf
    ,@(reduce #'append
              (loop
                :for route :in (flatten-route-trees route-trees)
                :collect
                   (let ((path (getf route :path))
                         (method (getf route :method))
                         (handler (getf route :handler))
                         (requirements (getf route :requirements)))                          
                     `((jingle:route ,app ,path :method ,method ,@requirements) ,handler))))))
