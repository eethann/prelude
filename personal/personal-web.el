;;; Code:
(prelude-require-packages '(drupal-mode zencoding-mode emmet-mode apache-mode))

;; Disable whitespace-mode when using web-mode
(add-hook 'web-mode-hook (lambda () (whitespace-mode -1)))
(add-to-list 'auto-mode-alist '("\\.inc$" . php-mode)) ;; - For Drupal
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.blade\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.dust\\(js\\)?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("/\\(views\\|html\\|theme\\|templates\\)/.*\\.php\\'" . web-mode))

(add-to-list 'auto-mode-alist '("\\.\\(module\\|test\\|install\\|theme\\)$" . php-mode)) ;; - For Drupal
(add-hook 'php-mode-hook
          (lambda ()
            (whitespace-mode -1)
            (set 'tab-width 2)
            (set 'c-basic-offset 2)
            (set 'indent-tabs-mode nil)
            (c-set-offset 'case-label '+)
            (c-set-offset 'arglist-intro '+) ; for FAPI arrays and DBTNG
            (c-set-offset 'arglist-cont-nonempty 'c-lineup-math) ; for DBTNG fields and values
                                        ; More Drupal-specific customizations here
            ))

;; Customizations
(setq web-mode-markup-indent-offset 4)
(setq web-mode-css-indent-offset 2)
(setq web-mode-code-indent-offset 2)
(setq web-mode-disable-autocompletion t)
(local-set-key (kbd "RET") 'newline-and-indent)

(provide 'personal-web)
