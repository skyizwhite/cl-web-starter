(defpackage #:project/domains/user
  (:use #:cl)
  (:import-from #:cl-ppcre)
  (:import-from #:project/lib/validator
                #:valid-class))
(in-package #:project/domains/user)

(defclass user ()
  ((name     :type     (satisfies valid-name-p)
             :accessor user-name
             :initarg  :name)
   (email    :type     (satisfies valid-email-p)
             :accessor user-email
             :initarg  :email)
   (password :type     (satisfies valid-password-p)
             :accessor user-password
             :initarg  :password))
  (:metaclass valid-class))

(defparameter *name-regex*
  "^[0-9a-zA-Z_]{4,14}$")

(defparameter *email-regex*
  "^[a-zA-Z0-9_+-]+(.[a-zA-Z0-9_+-]+)*@([a-zA-Z0-9][a-zA-Z0-9-]*[a-zA-Z0-9]*\.)+[a-zA-Z]{2,254}$")

(defparameter *password-regex*
  "^(?=[A-Za-z0-9]+$)^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.{8,100}).*$")

(defun valid-name-p (name)
  (and (typep name 'string)
       (ppcre:scan *name-regex* name)))

(defun valid-email-p (email)
  (and (typep email 'string)
       (ppcre:scan *email-regex* email)))

(defun valid-password-p (password)
  (and (typep password 'string)
       (ppcre:scan *password-regex* password)))

(defun make-user (&key name email password)
  (make-instance 'user
                 :name     name
                 :email    email
                 :password password))
