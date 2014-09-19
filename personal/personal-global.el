(scroll-bar-mode 0)

;; read in PATH from .zshrc
;; (if (not (getenv "TERM_PROGRAM"))
;;     (setenv "PATH"
;;             (shell-command-to-string "source $HOME/.zshrc && printf $PATH"))
;;     (setenv "PATH"
;;             (shell-command-to-string "source $HOME/.zshenv && printf $PATH"))
;;     )

;; (require 'exec-path-from-shell)
;; (when (memq window-system '(mac ns))
;;   (exec-path-from-shell-initialize))

(prelude-require-packages
 '(
   pretty-mode
   rainbow-delimiters
   switch-window
   ag
   ))

;; Set up binding for switch window
(global-set-key (kbd "C-x o") 'switch-window)

; Rainbows EVERYWHERE!
(global-rainbow-delimiters-mode)

;; Pretty is nice...
(global-pretty-mode t)

;; I REALLY don't like Guru mode
(setq guru-global-mode -1)
(setq prelude-guru nil)
(guru-global-mode -1)

;; Flyspell makes things slow
(setq prelude-flyspell nil)

(provide 'personal-global)
