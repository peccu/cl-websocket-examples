(in-package :cl-user)
(defpackage websocket-driver-caveman
  (:use :cl)
  (:import-from :websocket-driver-caveman.config
                :config)
  (:import-from :clack
                :clackup)
  (:export :start
           :stop))
(in-package :websocket-driver-caveman)

(defvar *appfile-path*
  (asdf:system-relative-pathname :websocket-driver-caveman #P"app.lisp"))

(defvar *handler* nil)

(defun start (&rest args &key server port debug &allow-other-keys)
  (declare (ignore server port debug))
  (when *handler*
    (restart-case (error "Server is already running.")
      (restart-server ()
        :report "Restart the server"
        (stop))))
  (setf *handler*
        (apply #'clackup *appfile-path* args)))

(defun stop ()
  (prog1
      (clack:stop *handler*)
    (setf *handler* nil)))
