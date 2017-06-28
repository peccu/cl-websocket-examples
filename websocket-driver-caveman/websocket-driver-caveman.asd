(in-package :cl-user)
(defpackage websocket-driver-caveman-asd
  (:use :cl :asdf))
(in-package :websocket-driver-caveman-asd)

(defsystem websocket-driver-caveman
  :version "0.1"
  :author "kentaro shimatani"
  :license ""
  :depends-on (:clack
               :lack
               :caveman2
               :envy
               :cl-ppcre
               :uiop

               ;; for @route annotation
               :cl-syntax-annot

               ;; HTML Template
               :djula

               ;; for DB
               :datafly
               :sxql)
  :components ((:module "src"
                :components
                ((:file "main" :depends-on ("config" "view" "db"))
                 (:file "web" :depends-on ("view"))
                 (:file "view" :depends-on ("config"))
                 (:file "db" :depends-on ("config"))
                 (:file "config"))))
  :description ""
  :in-order-to ((test-op (load-op websocket-driver-caveman-test))))
