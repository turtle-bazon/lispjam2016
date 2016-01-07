;;;; -*- mode: lisp -*-

(in-package #:lispjam2016)

(defun compile-parens ()
  (with-output-to-string (s)
    (paren-files:compile-script-file "paren/lispjam2016.paren" :output-stream s)))

(defvar *acceptor* (make-instance 'easy-acceptor :port 8080))

(setf *dispatch-table* (list 'dispatch-easy-handlers
                             (create-folder-dispatcher-and-handler "/" "public/")))

(define-easy-handler (root :uri "/") ()
  (setf (content-type*) "text/html; charset=utf-8")
  (with-output-to-string (os)
    (with-open-file (is "public/index.html")
      (loop
         for line = (read-line is nil 'eof)
         until (eq line 'eof)
         do (princ line os)))))

(define-easy-handler (main-js :uri "/js/main.js") ()
  (setf (content-type*) "application/javascript")
  (compile-parens))
