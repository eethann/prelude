;;; personal-js: personal js settings, mainly js3 stuff

;; (setq js3-auto-indent-p t         ; it's nice for commas to right themselves.
;;       js3-enter-indents-newline t ; don't need to push tab before typing
;;       js3-indent-on-enter-key t   ; fix indenting before moving on
;;       )

(prelude-require-packages '(
                            ;; js2-mode
                            js-comint
                            dart-mode ; yeah, I know this is horrid
                            json-mode
                            nodejs-repl
                            ))

(prelude-require-packages '(
                            js2-refactor
                            discover-js2-refactor
                            flycheck
                            ))

;; js2 syntax settings
;; see http://truongtx.me/2014/02/23/set-up-javascript-development-environment-in-emacs/
(add-hook 'js-mode-hook 'js2-minor-mode)
(setq js-indent-level 2)
(setq javascript-indent-level 2)

;; from https://github.com/xiaohanyu/oh-my-emacs/blob/master/modules/ome-javascript.org
;; (add-hook 'js2-mode-hook
;;           (lambda ()
;;             (setq js2-basic-offset 2)))
(setq js2-basic-offset 2)
(setq js2-bounce-indent-p t)

;; json
(setq json-reformat:indent-width 2)


(setenv "NODE_NO_READLINE" "1")

;; (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

(add-to-list 'load-path "/usr/local/lib/node_modules/tern/emacs/tern.el")
(autoload 'tern-mode "tern.el" nil t)
(add-hook 'js-mode-hook (lambda () (tern-mode t)))

;; Settings for js-comint
;; Use node as our repl
(setq inferior-js-program-command "node")

(setq inferior-js-mode-hook
      (lambda ()
        ;; We like nice colors
        (ansi-color-for-comint-mode-on)
        ;; Deal with some prompt nonsense
        (add-to-list 'comint-preoutput-filter-functions
                     (lambda (output)
                       (replace-regexp-in-string ".*1G\.\.\..*5G" "..."
                                                 (replace-regexp-in-string ".*1G.*3G" "&gt;" output)
                                                 )
                       )
                     )
        ))

(js2r-add-keybindings-with-prefix "C-c C-r")

;; from http://truongtx.me/2014/02/21/emacs-setup-jshint-for-on-the-fly-petential-error-checking/
(add-hook 'js-mode-hook
          (lambda () (flycheck-mode t)))

;; (add-hook 'js3-mode-hook
;;           (lambda ()
;;             (setq js3-auto-indent-p t
;;                   js3-curly-indent-offset 0
;;                   js3-enter-indents-newline t
;;                   js3-expr-indent-offset 2
;;                   js3-indent-on-enter-key t
;;                   js3-lazy-commas t
;;                   js3-lazy-dots t
;;                   js3-lazy-operators t
;;                   js3-paren-indent-offset 2
;;                   js3-square-indent-offset 4)
;;             (linum-mode 1)))


;; (add-hook 'js3-mode-hook '(lambda ()
;;                             (local-set-key "\C-x\C-e" 'js-send-last-sexp)
;;                             (local-set-key "\C-\M-x" 'js-send-last-sexp-and-go)
;;                             (local-set-key "\C-cb" 'js-send-buffer)
;;                             (local-set-key "\C-c\C-b" 'js-send-buffer-and-go)
;;                             (local-set-key "\C-cl" 'js-load-file-and-go)
;;                             ))

;; coffeescript
(custom-set-variables
 '(coffee-tab-width 2)
 '(coffee-args-compile '("-c" "--bare")))

(eval-after-load "coffee-mode"
  '(progn
     (define-key coffee-mode-map [(meta r)] 'coffee-compile-buffer)
     (define-key coffee-mode-map (kbd "C-j") 'coffee-newline-and-indent)))

(provide 'personal-js);;; personal-js ends here
