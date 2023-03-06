(defpackage #:project/lib/validator
  (:use #:cl)
  (:import-from #:closer-mop)
  (:export #:valid-class))
(in-package #:project/lib/validator)

(defclass valid-class (c2mop:standard-class)
  ())

(defmethod c2mop:validate-superclass ((class valid-class)
                                      (superclass c2mop:standard-class))
  t)

(defmethod (setf c2mop:slot-value-using-class) :before (new-value
                                                        (class valid-class)
                                                        object
                                                        slot)
  (let ((slot-type (c2mop:slot-definition-type slot)))
    (unless (typep new-value slot-type)
      (error 'type-error :datum new-value :expected-type slot-type))))
