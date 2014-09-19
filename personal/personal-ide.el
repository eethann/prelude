(prelude-require-packages '(grizzl
                            flx-ido
                            project-explorer
                            dash-at-point
                            powerline
                            helm-projectile
                            peep-dired
                            diminish
                            quickrun
                            company
                            company-cider
                            helm-company
                            flycheck-color-mode-line
                            linum
                            linum-relative
                            ggtags
                            helm-gtags
                        ))

(eval-after-load "flycheck"
  '(add-hook 'flycheck-mode-hook 'flycheck-color-mode-line-mode))

(global-company-mode)
;; Add js3-mode to dabbrev-code modes
;; otherwise all js3-mode completions are lowercased
(add-to-list 'company-dabbrev-code-modes 'js3-mode)

(powerline-center-evil-theme)

(setq projectile-completion-system 'grizzl)
(setq projectile-completion-system 'ido)

(global-set-key "\C-cd" 'dash-at-point)
(global-set-key "\C-ce" 'dash-at-point-with-docset)


;; Drupal PHP settings

;; The coder_sniffer standard is set up at "Drupal"
(setq drupal/phpcs-standard "Drupal")
(provide 'personal-ide)
