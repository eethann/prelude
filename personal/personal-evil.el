;;; personal-evil --- My crazy Evil configuration

;;; Commentary:
;;; not much else to say.
(require 'cl)

;;; Code:
(prelude-require-packages '(
                            evil
                            evil-god-state
                            evil-leader
                            evil-surround
                            evil-matchit
                            evil-nerd-commenter
                            evil-org
                            evil-paredit
                            evil-exchange
                            ;; evil-extra-operator
                            ace-jump-mode
                            ace-jump-buffer
                            ag
                            evil-jumper
                            ;; evil-easymotion
                            evil-commentary
                            evil-visualstar
                            ))

(evil-mode 1)
;; (require 'evil-nerd-commenter)

(global-evil-jumper-mode)
(global-evil-leader-mode)
(evil-exchange-install)
(setq evil-shift-width 2)

(global-evil-surround-mode 1)
(evil-commentary-default-setup)
(global-evil-visualstar-mode)

;; (evil-leader/set-leader ";")
;; (evil-leader/set-leader ",")
(evil-leader/set-leader "<SPC>")

(evil-define-key 'god global-map [escape] 'evil-god-state-bail)

;; evil-nerd-commenter bindings

(global-set-key (kbd "M-;") 'evilnc-comment-or-uncomment-lines)
(evil-leader/set-key
  "//" 'evilnc-comment-or-uncomment-lines
  "/l" 'evilnc-comment-or-uncomment-to-the-line
  "/c" 'evilnc-copy-and-comment-lines
  "/p" 'evilnc-comment-or-uncomment-paragraphs
  "/r" 'comment-or-uncomment-region
  )

;; Evil Leader Basics

(global-evil-leader-mode)

(evil-leader/set-key
  ":" 'helm-M-x
  ";" 'helm-mini
  "SPC" 'evil-buffer
  "G" 'evil-execute-in-god-state

  ;; the home row
  "a" 'org-agenda
  "s" 'ag
  "d" 'neotree-toggle
  "f" 'fill-region
  "g" 'magit-status
  "j" 'helm-imenu
  "k" 'kill-buffer
  "K" 'kill-buffer-and-window
  "l" 'switch-window

  ;; Others
  "e" 'helm-find-files
  "E" 'helm-projectile
  "b" 'evil-buffer
  "B" 'switch-to-buffer
  "D" 'deft
  "x" 'eval-last-sexp
  "X" 'execute-extended-command
  "qq" 'quickrun
  "qr" 'quickrun-region
  "w" 'switch-window
  "##" 'linum-mode
  "#$" 'linum-relative-toggle
  "?" 'help
  ;; "tt" 'toggl-start-timer
  ;; "ts" 'toggl-stop-timer
  "m" 'mc/mark-next-like-this
  "M" 'mc/mark-all-like-this
  "E" 'mc/edit-lines
  "P" 'popwin:popup-last-buffer
  "T" 'bw/open-term
  ;; "y" 'bury-buffer
  ">" 'mu4e-compose-new
  "<" 'mu4e
  ;; org (most defined in evil-org as well)
  "t"  'org-show-todo-tree
  "a"  'org-agenda
  "c" 'org-capture
  "_" 'string-inflection-all-cycle
  )

;; Window handling

(evil-leader/set-key-for-mode 'clojure-mode
  "x" 'cider-eval-last-sexp
  "d" 'cider-doc
  )

;; Evil leader for Flycheck

(evil-leader/set-key
  "Fl" 'flycheck-list-errors
  "Ff" 'flycheck-next-error
  "Fn" 'flycheck-next-error
  "Fp" 'flycheck-previous-error)

;; Evil leader for org

(evil-leader/set-key-for-mode 'org-mode
  "ox" 'org-toggle-checkbox
  "oj" 'org-goto
  "os" 'org-schedule
  "oo" 'org-open-at-point
  "op" 'org-priority
  "or" 'org-refile
  "oa" 'org-archive-subtree
  "od" 'org-deadline
  "ot" 'org-todo
  "oS" 'org-save-all-org-buffers
  "oc" 'org-clock-in
  "oC" 'org-clock-out
  "o;" 'org-cycle
  "o!" 'org-insert-src-block
  "oq" 'org-set-tags
  )


;; Evil for Helm
;; from https://github.com/syl20bnr/spacemacs/blob/master/my-keybindings.el
(evil-leader/set-key
  "'"     'helm-mini
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
(evil-set-initial-state 'mail-mode 'insert)

;; Fancy display stuff ((can probably remove this with powerline))
;; (setq evil-normal-state-tag (propertize "N" 'face '((:background "green" :foreground "black")))
;;       evil-emacs-state-tag (propertize "E" 'face '((:background "orange" :foreground "black")))
;;       evil-insert-state-tag (propertize "I" 'face '((:background "red")))
;;       evil-motion-state-tag (propertize "M" 'face '((:background "blue")))
;;       evil-visual-state-tag (propertize "V" 'face '((:background "grey80" :foreground "black")))
;;       evil-operator-state-tag (propertize "O" 'face '((:background "purple"))))

;; Evil god mode

;; (evil-leader/set-key )
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

;;;;;;
;; expand region
;;;;;;

(eval-after-load "evil" '(setq expand-region-contract-fast-key "\""))
(evil-leader/set-key "'" 'er/expand-region)

;;;;;
;; js refactor
;;;;;
(evil-leader/set-key-for-mode 'js2-mode
  "ref" 'js2r-extract-function
  "rem" 'js2r-extract-method
  "rip" 'js2r-introduce-parameter
  "rlp" 'js2r-localize-parameter
  "reo" 'js2r-expand-object
  "rco" 'js2r-contract-object
  "reu" 'js2r-expand-function
  "rcu" 'js2r-contract-function
  "rea" 'js2r-expand-array
  "rca" 'js2r-contract-array
  "rwi" 'js2r-wrap-buffer-in-iife
  "rig" 'js2r-inject-global-in-iife
  "rag" 'js2r-add-to-globals-annotation
  "rev" 'js2r-extract-var
  "riv" 'js2r-inline-var
  "rrv" 'js2r-rename-var
  "rvt" 'js2r-var-to-this
  "rao" 'js2r-arguments-to-object
  "r3i" 'js2r-ternary-to-if
  "rsv" 'js2r-split-var-declaration
  "rss" 'js2r-split-string
  "ruw" 'js2r-unwrap
  "rlt" 'js2r-log-this
  "rsl" 'js2r-forward-slurp
  "rba" 'js2r-forward-barf
  "rk" 'js2r-kill
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Evil Org
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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
;; commented out lines are mapping taken care of by evil-org
(evil-define-key 'normal evil-org-mode-map
  ;; "gh" 'outline-up-heading
  ;; "gj" (if (fboundp 'org-forward-same-level) ;to be backward compatible with older org version
  ;;          'org-forward-same-level
  ;;         'org-forward-heading-same-level)
  ;; "gk" (if (fboundp 'org-backward-same-level)
  ;;          'org-backward-same-level
  ;;         'org-backward-heading-same-level)
  ;; "gl" 'outline-next-visible-heading
  "t" 'org-todo
  ;; "T" '(lambda () (interactive) (evil-org-eol-call '(org-insert-todo-heading-after-current nil)))
  ;; "H" 'org-beginning-of-line
  ;; "L" 'org-end-of-line
  ;; "o" '(lambda () (interactive) (evil-org-eol-call 'always-insert-item))
  ;; "O" '(lambda () (interactive) (evil-org-eol-call 'org-insert-heading-after-current))
  ;; "$" 'org-end-of-line
  "^" 'org-beginning-of-line
  "-" 'orgbox-schedule
  "_" 'org-deadline
  "+" 'org-cycle-list-bullet
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

;; (evil-define-key 'normal peep-dired-mode-map (kbd "<SPC>") 'peep-dired-scroll-page-down)
;; (evil-define-key 'normal peep-dired-mode-map (kbd "C-<SPC>") 'peep-dired-scroll-page-up)
;; (evil-define-key 'normal peep-dired-mode-map (kbd "<backspace>") 'peep-dired-scroll-page-up)
;; (evil-define-key 'normal peep-dired-mode-map (kbd "j") 'peep-dired-next-file)
;; (evil-define-key 'normal peep-dired-mode-map (kbd "k") 'peep-dired-prev-file)
;; (add-hook 'peep-dired-mode-hook 'evil-normalize-keymaps)

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
                              (mu4e-headers-mode . emacs)
                              (mu4e-compose-mode . emacs)
                              )
      do (evil-set-initial-state mode state))

(loop for (mode) in '('mu4e-headers-mode 'mu4e-compose-mode 'mu4e-main-mode)
      do
'      (setq evil-emacs-state-modes (remove mode evil-emacs-state-modes)))

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

;; hl-anything bindings
(evil-leader/set-key
  "yy" 'hl-highlight-thingatpt-local
  "yu" 'hl-unhighlight-all-local
  "ys" 'hl-find-thing-forwardly
  "yS" 'hl-find-thing-backwardly
  "yp" 'hl-paren-mode
)

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
(evil-leader/set-key "\"" 'ace-jump-mode-pop-mark)

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

(evil-define-key 'normal global-map
  "," 'evil-ex
  )

;; Evil Org Maps
;; from https://github.com/cofi/dotfiles/blob/master/emacs.d/config/cofi-evil.el

(evil-define-key 'normal org-mode-map
  (kbd "RET") 'org-open-at-point
  "za"        'org-cycle
  "zA"        'org-shifttab
  "zm"        'hide-body
  "zr"        'show-all
  "zo"        'show-subtree
  "zO"        'show-all
  "zc"        'hide-subtree
  "zC"        'hide-all
  (kbd "M-j") 'org-shiftleft
  (kbd "M-k") 'org-shiftright
  (kbd "M-H") 'org-metaleft
  (kbd "M-J") 'org-metadown
  (kbd "M-K") 'org-metaup
  (kbd "M-L") 'org-metaright)

(evil-define-key 'normal orgstruct-mode-map
  (kbd "RET") 'org-open-at-point
  "za"        'org-cycle
  "zA"        'org-shifttab
  "zm"        'hide-body
  "zr"        'show-all
  "zo"        'show-subtree
  "zO"        'show-all
  "zc"        'hide-subtree
  "zC"        'hide-all
  (kbd "M-j") 'org-shiftleft
  (kbd "M-k") 'org-shiftright
  (kbd "M-H") 'org-metaleft
  (kbd "M-J") 'org-metadown
  (kbd "M-K") 'org-metaup
  (kbd "M-L") 'org-metaright)

(evil-define-key 'insert org-mode-map
  (kbd "M-j") 'org-shiftleft
  (kbd "M-k") 'org-shiftright
  (kbd "M-H") 'org-metaleft
  (kbd "M-J") 'org-metadown
  (kbd "M-K") 'org-metaup
  (kbd "M-L") 'org-metaright)

(evil-define-key 'insert orgstruct-mode-map
  (kbd "M-j") 'org-shiftleft
  (kbd "M-k") 'org-shiftright
  (kbd "M-H") 'org-metaleft
  (kbd "M-J") 'org-metadown
  (kbd "M-K") 'org-metaup
  (kbd "M-L") 'org-metaright)

;;; Multiple Cursors Handling

;;; Thanks to tkf on
;;; https://github.com/magnars/multiple-cursors.el/issues/19
;;; insert state has been changed to emacs state
(defvar my-mc-evil-previous-state nil)

(defun my-mc-evil-switch-to-emacs-state ()
  (when (and (bound-and-true-p evil-mode)
             (not (eq evil-state 'emacs)))
    (setq my-mc-evil-previous-state evil-state)
    (evil-emacs-state)))

(defun my-mc-evil-back-to-previous-state ()
  (when my-mc-evil-previous-state
    (unwind-protect
        (case my-mc-evil-previous-state
          ((normal visual insert) (evil-force-normal-state))
          (t (message "Don't know how to handle previous state: %S"
                      my-mc-evil-previous-state)))
      (setq my-mc-evil-previous-state nil))))

(add-hook 'multiple-cursors-mode-enabled-hook
          'my-mc-evil-switch-to-emacs-state)
(add-hook 'multiple-cursors-mode-disabled-hook
          'my-mc-evil-back-to-previous-state)

(evil-leader/set-key
  "--" 'mc/mark-all-like-this
  "-+" 'mc/mark-previous-symbol-like-this
  "-_" 'mc/mark-previous-symbol-like-this
  )

(provide 'personal-evil)
