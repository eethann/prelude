;; (setq default-frame-alist '((font-backend . "xft")
;;                             (font . "Inconsolata\-g-12")
;;                             (cursor-color . "white")
;;                             (tool-bar-lines . 0)
;;                             (vertical-scroll-bars . nil)
;;                             (alpha . 85)))

;; from https://github.com/jsulak/.emacs.d/blob/master/james-osx.el

(prelude-require-packages '(
                            color-theme
                            color-theme-solarized
                            solarized-theme
                            color-theme-sanityinc-tomorrow
                            base16-theme
                            smooth-scrolling
                            ))

;; (load-theme 'base16-chalk)
(color-theme-sanityinc-tomorrow-eighties)

(toggle-frame-fullscreen)
(global-set-key (kbd "C-c C-f") 'toggle-frame-fullscreen)



(menu-bar-mode 1)

(setq ring-bell-function 'ignore)

;; (if window-system
;;     (require 'james-gui))

(if window-system
    (progn
      (set-face-attribute 'default nil :font "Inconsolata-g-14")
      ;; (set-frame-font "Inconsolata-g-12" nil)
      )
)

(provide 'personal-display)
