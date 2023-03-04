(defpackage #:project-tests/lib/routes
  (:use :cl :rove)
  (:import-from #:project/lib/routes
                #:register-handlers))
(in-package #:project-tests/lib/routes)

(deftest register-handlers-test
  (testing "Define routing for CRUD operations"
    (ok
     (expands
      '(register-handlers *app*
        ("/api/v1" ()
         ("/users" (:get    #'list-users
                    :post   #'create-user)
          ("/:id"  (:get    #'show-user
                    :put    #'update-user
                    :delete #'destroy-user)))))
      '(setf
        (jingle:route *app* "/api/v1/users" :method :get) #'list-users
        (jingle:route *app* "/api/v1/users" :method :post) #'create-user
        (jingle:route *app* "/api/v1/users/:id" :method :get) #'show-user
        (jingle:route *app* "/api/v1/users/:id" :method :put) #'update-user
        (jingle:route *app* "/api/v1/users/:id" :method :delete) #'destroy-user)))))
