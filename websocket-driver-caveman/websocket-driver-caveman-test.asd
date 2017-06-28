(in-package :cl-user)
(defpackage websocket-driver-caveman-test-asd
  (:use :cl :asdf))
(in-package :websocket-driver-caveman-test-asd)

(defsystem websocket-driver-caveman-test
  :author "kentaro shimatani"
  :license ""
  :depends-on (:websocket-driver-caveman
               :prove)
  :components ((:module "t"
                :components
                ((:file "websocket-driver-caveman"))))
  :perform (load-op :after (op c) (asdf:clear-system c)))
