(defmodule hello
  (export all))

(defun hello-server ()
  (receive
    ((tuple caller 'good msg)
     (! caller (tuple 'ok "Hi, you!")))
    ((tuple caller 'bad _msg)
     (! caller (tuple 'error "I'm afraid I can't do that, Dave")))))

(defun send-thing
  ((`#(,kind ,msg))
   (let ((server (spawn 'hello 'hello-server '())))
     (! server (tuple (self) kind msg)))))
  