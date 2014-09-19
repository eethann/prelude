(prelude-require-packages '(
                            expand-region
                            multiple-cursors
                            project-explorer
                            paradox
                            guide-key
                            ))

(global-set-key (kbd "C-=") 'er/expand-region)
(global-set-key (kbd "C-c C-e") 'project-explorer-open)

;; guide-key settings
(setq guide-key/guide-key-sequence '("C-x" "C-c"))
(guide-key-mode 1)
;; ido settings

(setq ido-everywhere t)
(setq ido-max-directory-size 100000)
(ido-mode (quote both))
                                        ; Use the current window when visiting files and buffers with ido
(setq ido-default-file-method 'selected-window)
(setq ido-default-buffer-method 'selected-window)

(setq paradox-github-token "40c4396eba32dca9f091c00ef27af3fc11dac419")

(require 'uniquify)

;;; auto-save settings

;; (setq
;;    backup-by-copying t      ; don't clobber symlinks
;;    backup-directory-alist
;;     '(("." . "~/.saves"))    ; don't litter my fs tree
;;    delete-old-versions t
;;    kept-new-versions 6
;;    kept-old-versions 2
;;    version-control t)       ; use versioned backups
