;;; personal-js: personal js settings, mainly js3 stuff

(setq js3-auto-indent-p t         ; it's nice for commas to right themselves.
      js3-enter-indents-newline t ; don't need to push tab before typing
      js3-indent-on-enter-key t   ; fix indenting before moving on
      )

(prelude-require-packages '(js3-mode js-comint
                                     dart-mode ; yeah, I know this is horrid
                                     ))


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

(add-hook 'js3-mode-hook '(lambda ()
                            (local-set-key "\C-x\C-e" 'js-send-last-sexp)
                            (local-set-key "\C-\M-x" 'js-send-last-sexp-and-go)
                            (local-set-key "\C-cb" 'js-send-buffer)
                            (local-set-key "\C-c\C-b" 'js-send-buffer-and-go)
                            (local-set-key "\C-cl" 'js-load-file-and-go)
                            ))

(provide 'personal-js);;; personal-js ends here
