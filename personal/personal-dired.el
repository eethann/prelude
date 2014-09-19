;; Comments:
;; This is based mainly on Mastering Emacs blogs about working with
;; multiple files in dired and executing commands.
;;
;; Some tricks that I like:
;;
;; "find-name-dired" is a fast way to find by name in dired
;; "!" is used in dired windows to run commands on all marked files.
;; "?" iterates the command for all marked files in a "!" command minibuff

(prelude-require-packages '(dirtree lusty-explorer ))

(require 'find-dired)

(setq find-ls-option '("-print0 | xargs -0 ls -ld" . "-ld"))

(require 'dired-x)

(provide 'personal-dired)
