(defpackage #:project/lib/routes
  (:use #:cl)
  (:import-from #:jingle)
  (:export #:register-routes))
(in-package #:project/lib/routes)

(defun has-options-p (handler)
  (not (eq (car handler) 'function)))

(defun concatenate-path (parent child)
  (if (string= parent "/")
      child
      (concatenate 'string parent child)))

(defun propagate-path (path route-trees)
  (loop
    :for route-tree :in route-trees
    :collect
       (cons (concatenate-path path
                               (car route-tree))
             (cdr route-tree))))

(defun parse-route-trees (route-trees)
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
                              `(:path    ,path
                                :method  ,method
                                :options ,(and (has-options-p handler) (cdr handler))
                                :handler ,(if (has-options-p handler)
                                              (car handler)
                                              handler)))
                         (when sub-route-trees
                           (parse-route-trees (propagate-path path
                                                              sub-route-trees))))))))

(defmacro register-routes (app &body route-trees)
  `(setf
    ,@(reduce #'append
              (loop
                :for route :in (parse-route-trees route-trees)
                :collect
                   (let ((path (getf route :path))
                         (method (getf route :method))
                         (options (getf route :options))
                         (handler (getf route :handler)))                          
                     `((jingle:route ,app ,path :method ,method ,@options) ,handler))))))
