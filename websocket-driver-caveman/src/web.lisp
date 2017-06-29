(in-package :cl-user)
(defpackage websocket-driver-caveman.web
  (:use :cl
        :caveman2
        :websocket-driver-caveman.config
        :websocket-driver-caveman.view
        :websocket-driver-caveman.db
        :datafly
        :sxql
        :websocket-driver)
  (:export :*web*))
(in-package :websocket-driver-caveman.web)

;; for @route annotation
(syntax:use-syntax :annot)

;;
;; Application

(defclass <web> (<app>) ())
(defvar *web* (make-instance '<web>))
(clear-routing-rules *web*)

;;
;; Routing rules

(defroute "/" ()
  (render #P"index.html"))

(defun echo (ws message)
  (format t "~a~%" message)
  (send ws message))

(defroute "/echo" ()
  (format t "env: ~a~%" (request-env *request*))
  (let ((ws (make-server (request-env *request*))))
    (on :message ws
      (lambda (message)
        (echo ws message)))
    (on :open ws
      (lambda ()
        (format t "Connected.~%")))
    (on :error ws
      (lambda (error)
        (format t "Got an error: ~S~%" error)))
    (on :close ws
      (lambda (code reason)
        (format t "Closed because '~A' (Code=~A)~%" reason code)))
    (lambda (responder)
      (declare (ignore responder))
      (start-connection ws))))

;;
;; Error pages

(defmethod on-exception ((app <web>) (code (eql 404)))
  (declare (ignore app))
  (merge-pathnames #P"_errors/404.html"
                   *template-directory*))
