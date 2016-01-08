;;;; -*- mode: lisp -*-

(asdf:operate 'asdf:load-op :paren-files)

(defsystem :lispjam2016
    :depends-on (hunchentoot cl-who parenscript)
    :components ((:module "src"
                          :components ((:file "package")
                                       (:file "core" :depends-on ("package"))))))
