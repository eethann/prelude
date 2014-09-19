(prelude-require-packages '(
                            evil
                            evil-god-state
                            evil-leader
                            evil-surround
                            evil-matchit
                            evil-nerd-commenter
                            ace-jump-mode
                            ace-jump-buffer
                            ))
(global-evil-leader-mode)
(evil-mode 1)
(setq evil-shift-width 2)

(global-evil-surround-mode 1)

(evil-leader/set-leader ";")

(evil-define-key 'normal global-map "," 'evil-execute-in-god-state)
(evil-define-key 'god global-map [escape] 'evil-god-state-bail)

;; evil-nerd-commenter bindings

(global-set-key (kbd "M-;") 'evilnc-comment-or-uncomment-lines)
(evil-leader/set-key
  "/i" 'evilnc-comment-or-uncomment-lines
  "/l" 'evilnc-comment-or-uncomment-to-the-line
  "/c" 'evilnc-copy-and-comment-lines
  "/p" 'evilnc-comment-or-uncomment-paragraphs
  "/r" 'comment-or-uncomment-region)

;; Evil Leader Basics

(global-evil-leader-mode)

(evil-leader/set-key
  ";" 'evil-buffer
  "'" 'helm-mini
  "e" 'helm-projectile
  "b" 'evil-buffer
  "k" 'kill-buffer
  "B" 'switch-to-buffer
  "c" 'org-capture
  "r" 'quickrun
  "G" 'magit-status
  "g" 'evil-execute-in-god-state
  "D" 'deft
  "x" 'execute-extended-command
  "d" 'kill-this-buffer
  "q" 'kill-buffer-and-window
  "a" 'helm-mini
  "s" 'ag
  "F" 'fill-region
  "w" 'switch-window
  "##" 'linum-mode
  "#$" 'linum-relative-toggle
  "?" 'help
  "tt" 'toggl-start-timer
  "ts" 'toggl-stop-timer
  "m" 'mc/mark-next-like-this
  "M" 'mc/mark-all-like-this
  "E" 'mc/edit-lines
  "P" 'popwin:popup-last-buffer
  "T" 'bw/open-term
  "y" 'bury-buffer
  ">" 'mail
  )

;; Window handling


;; Evil leader for Flycheck

(evil-leader/set-key
  "fl" 'flycheck-list-errors
  "ff" 'flycheck-next-error
  "fn" 'flycheck-next-error
  "fp" 'flycheck-previous-error)

;; Evil leader for org

(evil-leader/set-key-for-mode 'org-mode
  "C" 'org-toggle-checkbox
  "oj" 'org-goto
  "os" 'org-schedule
  "oo" 'org-open-at-point
  "op" 'org-priority
  "or" 'org-refile
  "oa" 'org-archive-subtree
  "od" 'org-deadline
  "ot" 'org-todo
  "oS" 'org-save-all-org-buffers
  )


;; Evil for Helm
;; from https://github.com/syl20bnr/spacemacs/blob/master/my-keybindings.el
(evil-leader/set-key
  "a"     'helm-mini
  "hh"    'helm-mini
  "ho"    'helm-occur
  "hp"    'helm-projectile
  "h:"    'helm-helm-commands
  "hc"    'helm-css-scss
  "hg"    'helm-bookmarks
  "hk"    'helm-make
  "hM"    'helm-switch-major-mode
  "hm"    'helm-disable-minor-mode
  "h C-m" 'helm-enable-minor-mode
  "hS"    'helm-multi-swoop
  "hs"    'helm-swoop
  "h C-s" 'helm-multi-swoop-all
  "ht"    'helm-themes
  "hi"    'helm-imenu
  "hr"    'helm-regexp ;; totally awesome regexp builder and then action execute
  "h;"    'helm-projectile
  "hy"    'helm-show-kill-ring
  )

(evil-set-initial-state 'org-capture-mode 'insert)
(evil-set-initial-state 'org-note 'insert)
(evil-set-initial-state 'org 'insert)
(evil-set-initial-state 'org-mode 'insert)
(evil-set-initial-state 'mail-mode 'insert)

;; Fancy display stuff ((can probably remove this with powerline))
(setq evil-normal-state-tag (propertize "N" 'face '((:background "green" :foreground "black")))
      evil-emacs-state-tag (propertize "E" 'face '((:background "orange" :foreground "black")))
      evil-insert-state-tag (propertize "I" 'face '((:background "red")))
      evil-motion-state-tag (propertize "M" 'face '((:background "blue")))
      evil-visual-state-tag (propertize "V" 'face '((:background "grey80" :foreground "black")))
      evil-operator-state-tag (propertize "O" 'face '((:background "purple"))))

;; Evil god mode

(evil-leader/set-key "[" 'evil-execute-in-god-state)
;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Key maps
;;;;;;;;;;;;;;;;;;;;;;;;;;

(define-key evil-normal-state-map "\C-e" 'move-end-of-line)
(define-key evil-motion-state-map "\C-e" 'evil-end-of-line)
(define-key evil-insert-state-map "\C-e" 'evil-end-of-line)

(define-key evil-insert-state-map "j" #'mam/maybe-exit)

(evil-define-command mam/maybe-exit ()
  :repeat change
  (interactive)
  (let ((modified (buffer-modified-p)))
    (insert "j")
    (let ((evt (read-event (format "Insert %c to exit insert state" ?j)
               nil 0.5)))
      (cond
       ((null evt) (message ""))
       ((and (integerp evt) (char-equal evt ?j))
    (delete-char -1)
    (set-buffer-modified-p modified)
    (push 'escape unread-command-events))
       (t (setq unread-command-events (append unread-command-events
                          (list evt))))))))



;; Adapted from evil-mode

;; Author: Edward Tjörnhammar
;; URL: https://github.com/edwtjo/evil-org-mode.git

(define-minor-mode evil-org-mode
  "Buffer local minor mode for evil-org"
  :init-value nil
  :lighter " EvilOrg"
  :keymap (make-sparse-keymap) ; defines evil-org-mode-map
  :group 'evil-org)

(add-hook 'org-mode-hook 'evil-org-mode) ;; only load with org-mode

(defun always-insert-item ()
  "Force insertion of org item"
  (if (not (org-in-item-p))
      (insert "\n- ")
    (org-insert-item))
  )

(defun evil-org-eol-call (fun)
  "Go to end of line and call provided function"
  (end-of-line)
  (funcall fun)
  (evil-append nil)
  )

;; normal state shortcuts
(evil-define-key 'normal evil-org-mode-map
  "gh" 'outline-up-heading
  "gj" (if (fboundp 'org-forward-same-level) ;to be backward compatible with older org version
	   'org-forward-same-level
	  'org-forward-heading-same-level)
  "gk" (if (fboundp 'org-backward-same-level)
	   'org-backward-same-level
	  'org-backward-heading-same-level)
  "gl" 'outline-next-visible-heading
  "t" 'org-todo
  "T" '(lambda () (interactive) (evil-org-eol-call '(org-insert-todo-heading-after-current nil)))
  "H" 'org-beginning-of-line
  "L" 'org-end-of-line
  ";t" 'org-show-todo-tree
  "o" '(lambda () (interactive) (evil-org-eol-call 'always-insert-item))
  "O" '(lambda () (interactive) (evil-org-eol-call 'org-insert-heading-after-current))
  "$" 'org-end-of-line
  "^" 'org-beginning-of-line
  ">" 'orgbox-schedule
  "<" 'org-deadline
  ";a" 'org-agenda
  "-" 'org-cycle-list-bullet
  (kbd "TAB") 'org-cycle)

(evil-leader/set-key-for-mode
  'org-mode
  "$" 'org-archive-subtree
  "r" 'org-refile
  )

;; normal & insert state shortcuts.
(mapc (lambda (state)
        (evil-define-key state evil-org-mode-map
          (kbd "M-l") 'org-metaright
          (kbd "M-h") 'org-metaleft
          (kbd "M-k") 'org-metaup
          (kbd "M-j") 'org-metadown
          (kbd "M-L") 'org-shiftmetaright
          (kbd "M-H") 'org-shiftmetaleft
          (kbd "M-K") 'org-shiftmetaup
          (kbd "M-J") 'org-shiftmetadown
          (kbd "M-o") '(lambda () (interactive)
                         (evil-org-eol-call
                          '(lambda()
                             (org-insert-heading)
                             (org-metaright))))
          (kbd "M-t") '(lambda () (interactive)
                         (evil-org-eol-call
                          '(lambda()
                             (org-insert-todo-heading nil)
                             (org-metaright))))
          ))
      '(normal insert))

;; peep-dired

(evil-define-key 'normal peep-dired-mode-map (kbd "<SPC>") 'peep-dired-scroll-page-down)
(evil-define-key 'normal peep-dired-mode-map (kbd "C-<SPC>") 'peep-dired-scroll-page-up)
(evil-define-key 'normal peep-dired-mode-map (kbd "<backspace>") 'peep-dired-scroll-page-up)
(evil-define-key 'normal peep-dired-mode-map (kbd "j") 'peep-dired-next-file)
(evil-define-key 'normal peep-dired-mode-map (kbd "k") 'peep-dired-prev-file)
(add-hook 'peep-dired-mode-hook 'evil-normalize-keymaps)

;; Set emacs state for various modes

(loop for (mode . state) in '(
                              (inferior-emacs-lisp-mode . emacs)
                              (nrepl-mode . insert)
                              (pylookup-mode . emacs)
                              (comint-mode . normal)
                              (shell-mode . insert)
                              (git-commit-mode . insert)
                              (git-rebase-mode . emacs)
                              (term-mode . emacs)
                              (help-mode . emacs)
                              (helm-grep-mode . emacs)
                              (grep-mode . emacs)
                              (bc-menu-mode . emacs)
                              (magit-branch-manager-mode . emacs)
                              (rdictcc-buffer-mode . emacs)
                              (dired-mode . emacs)
                              (wdired-mode . normal)
                              (project-explorer-mode . emacs)
                              )
      do (evil-set-initial-state mode state))

;; Power-up for the escape key
;;; esc quits
(define-key evil-normal-state-map [escape] 'keyboard-quit)
(define-key evil-visual-state-map [escape] 'keyboard-quit)
(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)
(setq evil-esc-delay 0)

;; Make HJKL keys work in special buffers
(evil-add-hjkl-bindings magit-branch-manager-mode-map 'emacs
  "K" 'magit-discard-item
  "L" 'magit-key-mode-popup-logging)
(evil-add-hjkl-bindings magit-status-mode-map 'emacs
  "K" 'magit-discard-item
  "l" 'magit-key-mode-popup-logging
  "h" 'magit-toggle-diff-refine-hunk)
(evil-add-hjkl-bindings magit-log-mode-map 'emacs)
(evil-add-hjkl-bindings magit-commit-mode-map 'emacs)
(evil-add-hjkl-bindings occur-mode 'emacs)

;; musc evil defaults from https://github.com/mixandgo/emacs.d/blob/master/my-evil.el
(setq evil-shift-width 2)
(setq evil-want-C-i-jump t)
(setq evil-want-C-u-scroll t)
(setq evil-complete-all-buffers nil)

;; Ace jump config
;; (goes here because I use ace-jump with evil)
(setq ace-jump-mode-move-keys
      ;;; QWERT ace jump keys (ASDFJKL)
      (nconc
       '(?a ?s ?d ?f ?j ?k ?l)
       ))

(setq ace-jump-mode-move-keys
      ;; Simple Numeric with 0 last
      (nconc
       (loop for i from ?1 to ?9 collect i)
       '(?0)
       ))

;;
;; enable a more powerful jump back function from ace jump mode
;;
(autoload
  'ace-jump-mode-pop-mark
  "ace-jump-mode"
  "Ace jump back:-)"
  t)
(eval-after-load "ace-jump-mode"
  '(ace-jump-mode-enable-mark-sync))
(define-key global-map (kbd "C-x SPC") 'ace-jump-mode-pop-mark)
(evil-leader/set-key "SPC" 'ace-jump-mode-pop-mark)

;;
;; from https://github.com/bradleywright/emacs.d/blob/master/utils.el
;;
(defun bw/open-term (&optional arg)
  "Opens an ansi-term with value of $TERM - force new ansi-term
with prefix"
  (interactive "p")
  (if (or (not (get-buffer "*terminal*")) (= arg 4))
      (multi-term (getenv "SHELL"))
    (switch-to-buffer "*terminal*")))
(global-set-key (kbd "C-c C-t t") 'bw/open-term)

(provide 'personal-evil)
