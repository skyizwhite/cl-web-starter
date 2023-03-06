(defpackage #:project-tests/lib/validator
  (:use #:cl #:rove)
  (:import-from #:project/lib/validator
                #:valid-class))
(in-package #:project-tests/lib/validator)

(defclass hoge ()
  ((prop :type number :initarg :prop))
  (:metaclass valid-class))

(deftest valid-class-test
  (testing "Throw error if assigned value has invalid type" 
    (ok (signals (make-instance 'hoge :prop "text")))
    (let ((obj (make-instance 'hoge :prop 1)))
      (ok (signals (setf (slot-value obj 'prop) "text"))))))
