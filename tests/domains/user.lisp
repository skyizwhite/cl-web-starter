(defpackage #:project-tests/domains/user
  (:use #:cl #:rove)
  (:import-from #:project/domains/user
                #:make-user))
(in-package :project-tests/domains/user)

(deftest user-domain-test
  (testing "Create user with valid args"
    (ok (make-user :name     "skyizwhite"
                   :email    "hoge.fuga@example.com"
                   :password "Val1dPassword"))))
