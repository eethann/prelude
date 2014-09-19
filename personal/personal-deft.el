(require 'prelude-packages)

(prelude-require-package 'deft)

(setq deft-extension "txt")
(setq deft-directory "~/notes")
(setq deft-text-mode 'markdown-mode)
(setq deft-use-filename-as-title t)
(global-set-key (kbd "C-c M-d") 'deft)

(provide 'personal-deft)
