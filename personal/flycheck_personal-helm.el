(prelude-require-packages '(helm helm-swoop helm-ack helm-flycheck popwin))

(global-set-key (kbd "C-c C-SPC") 'helm-mini)

(global-set-key (kbd "C-c C-a") 'helm-ack)

;; TODO: implement dynamic functin for helm jumping, based on mode.
(global-key-binding "C-c j" 'helm-org-headlines)

;; Change the keybinds to whatever you like :)
(global-set-key (kbd "M-i") 'helm-swoop)
(global-set-key (kbd "M-I") 'helm-swoop-back-to-last-point)
(global-set-key (kbd "C-c M-i") 'helm-multi-swoop)
(global-set-key (kbd "C-x M-i") 'helm-multi-swoop-all)

;; When doing isearch, hand the word over to helm-swoop
(define-key isearch-mode-map (kbd "M-i") 'helm-swoop-from-isearch)
;; From helm-swoop to helm-multi-swoop-all
;; (define-key helm-swoop-map (kbd "M-i") 'helm-multi-swoop-all-from-helm-swoop)
;; When doing evil-search, hand the word over to helm-swoop
;; (define-key evil-motion-state-map (kbd "M-i") 'helm-swoop-from-evil-search)

;; Save buffer when helm-multi-swoop-edit complete
(setq helm-multi-swoop-edit-save t)

;; If this value is t, split window inside the current window
(setq helm-swoop-split-with-multiple-windows nil)

;; Split direcion. 'split-window-vertically or 'split-window-horizontally
(setq helm-swoop-split-direction 'split-window-vertically)

;; If nil, you can slightly boost invoke speed in exchange for text color
(setq helm-swoop-speed-or-color nil)

(setq helm-dash-common-docsets '(
                                 "AngularJS"
                                 ))

(require 'popwin)
(popwin-mode 1)
(push "*Shell Command Output*" popwin:special-display-config)
(push "*mail*" popwin:special-display-config)

(provide 'personal-helm)
