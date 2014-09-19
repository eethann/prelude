;; (setq guru-warn-only t)
(setq prelude-guru nil)

(global-set-key (kbd "M-h") 'helm-mini)
(global-set-key (kbd "M-o") 'other-window)

(defun kill-this-buffer ()
  (interactive)
  (kill-buffer (current-buffer)))
(global-set-key (kbd "C-x C-k") 'kill-this-buffer)

(global-set-key (kbd "<f10>") 'egg-status)

(provide 'personal-keys)
;; peronal-keys ends here
