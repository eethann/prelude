(prelude-require-packages '(grizzl
                            flx-ido
                            dired+
                            neotree
                            project-explorer
                            dash-at-point
                            powerline
                            smart-mode-line
                            helm-projectile
                            peep-dired
                            diminish
                            quickrun
                            company
                            ;; company-cider
                            helm-company
                            flycheck-color-mode-line
                            linum
                            linum-relative
                            ggtags
                            helm-gtags
                            fullframe
                            discover
                            hl-anything
                            string-inflection
                        ))

(global-hl-line-mode)

;; Generic settings for code editing
(setq c-basic-offset 2)
(setq tab-width 2)
(setq-default indent-tabs-mode nil)

(fullframe magit-status magit-mode-quit-window)

(eval-after-load "flycheck"
  '(add-hook 'flycheck-mode-hook 'flycheck-color-mode-line-mode))

(global-company-mode)
;; Add js3-mode to dabbrev-code modes
;; otherwise all js3-mode completions are lowercased
(add-to-list 'company-dabbrev-code-modes 'js3-mode)

;; (powerline-center-evil-theme)

(sml/setup)
(sml/apply-theme 'dark)

(setq projectile-completion-system 'grizzl)
(setq projectile-completion-system 'ido)

(global-set-key "\C-cd" 'dash-at-point)
(global-set-key "\C-ce" 'dash-at-point-with-docset)


;; Drupal PHP settings

;; The coder_sniffer standard is set up at "Drupal"
(setq drupal/phpcs-standard "Drupal")

(require 'zone)
(zone-when-idle 120)

;; NeoTree Setup
(add-hook 'neotree-mode-hook
          (lambda ()
           (define-key neotree-mode-map [return] 'neotree-enter)
           (define-key neotree-mode-map (kbd "\C-g") 'neotree-refresh)
           (hl-line-mode 1)
           ))

(provide 'personal-ide)
