(defpackage #:project-tests/domains/user
  (:use #:cl #:rove)
  (:import-from #:project/domains/user
                #:make-user))
(in-package :project-tests/domains/user)

(deftest user-domain-test
  (testing "Create user with valid args"
    (ok (make-user :name     "valid_name"
                   :email    "valid.email@example.com"
                   :password "Val1dPassword")))
  
  (testing "Create user with invalid name"
    (ok (signals (make-user :name     "abc"
                            :email    "valid.email@example.com"
                            :password "Val1dPassword")))
    (ok (signals (make-user :name     "invalid-name!"
                            :email    "valid.email@example.com"
                            :password "Val1dPassword"))))
  
  (testing "Create user with invalid email"
    (ok (signals (make-user :name     "valid_name"
                            :email    "invalid.email.example.com"
                            :password  "Val1dPassword")))
    (ok (signals (make-user :name     "valid_name"
                            :email    ".invalid@example.com"
                            :password "Val1dPassword"))))

  (testing "Create user with invalid password"
    (ok (signals (make-user :name     "valid_name"
                            :email    "valid.email@example.com"
                            :password "invalidpassword")))
    (ok (signals (make-user :name     "valid_name"
                            :email    "valid.email@example.com"
                            :password "abc")))))
