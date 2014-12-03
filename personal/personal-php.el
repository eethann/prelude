;;; package --- My settings for editing PHP (mainly Drupal)

;;; Commentary:
;;; None!

;;; Code:

(prelude-require-packages '(geben php-mode))


(custom-set-variables
 '(geben-pause-at-entry-line t)
 '(geben-session-enter-hook (quote (geben-session-redirect-init geben-session-context-init geben-session-breakpoint-init geben-session-source-init drupal-emacs-geben-session-init)))
 '(geben-show-breakpoints-debugging-only t))

(provide 'personal-php)
;;; personal-php.el ends here
