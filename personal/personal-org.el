;;; package --- Personal org-mode settings
;;; Commentary:
;;; Personal org-mode settings

;;; Code:

(prelude-require-packages '(org
                            org-bullets
                            org-jira
                            ;; orgbox
                            org-pomodoro
                            evil-org
                            ))

(require 'org-agenda)
;; (require 'orgbox)
;; (define-key org-agenda-mode-map ">" 'org-agenda-schedule)
(define-key org-agenda-mode-map "j" 'org-agenda-next-item)
(define-key org-agenda-mode-map "k" 'org-agenda-previous-item)
;; (define-key org-agenda-mode-map ">" 'orgbox-schedule)

(add-to-list 'auto-mode-alist '("\\.org.txt$" . org-mode))
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key mode-specific-map [?a] 'org-agenda)
(setq org-directory "~/org")
(setq org-default-notes-file (concat org-directory "/notes.org"))
(setq org-startup-indented 1)
(setq org-startup-folded t)

(add-hook 'org-mode-hook 'turn-on-auto-fill)
(add-hook 'org-mode-hook 'flyspell-mode)

(define-key global-map "\C-cl" 'org-store-link)

;; Keywords for GTD
(setq org-todo-keywords
      '((sequence "TODO(t)" "|" "DONE(d)" "CANCELED(c)")
        (sequence "PROJECT(p)" "MAYBE(m)" "SOMEDAY(s)" "AGNEDA(a)")
        (sequence "WAITING(w)" "TODELEGATE(T)" "|" "DELEGATED(D)")
        ))

;; Set to the name of the file where new notes will be stored
(setq org-mobile-inbox-for-pull "~/org/inbox.org.txt")
;; Set to <your Dropbox root directory>/MobileOrg.
(setq org-mobile-directory "~/Dropbox/MobileOrg")

(define-key global-map "\C-cc" 'org-capture)
(setq org-agenda-files '("~/org/notes.org"
			 "~/org/plans.org"
                         "~/org/today.org"
			 "~/org/todo.org"
                         "~/org/flagged.org"
                         "~/org/inbox.org.txt"
                         "~/org/inbox.alfred.org.txt"
                         "~/org/inbox.auto.org.txt"
			 "~/org/meeting-agendas.org"
                         "~/org/personal.org"
                         "~/org/projects.org"
                         ;;; project files
                         "~/org/project__colab-ops.org"
			 ))

(setq org-capture-templates
      '(("T" "TODO Today" entry
	 (file+headline "~/org/today.org" "Inbox")
	 "* TODO %?\n  %i\n  %a")
        ("t" "Todo" entry
	 (file+headline "~/org/todo.org" "Inbox")
	 "* TODO %?\n  %i\n  %a")
        ("i" "Inbox" entry
         (file+headline "~/org/inbox.org.txt" "Unprocessed")
         "* TODO %?\n %i\n %a")
	("a" "Agenda" entry
	 (file+headline "~/org/meeting-agendas.org" "Inbox")
	 "* TODO %?\n  %i\n  %a")
	("j" "Journal" entry (file+datetree "~/org/journal.org")
	 "* %?\nEntered on %U\n  %i\n  %a")
	("p" "Personal Journal" entry (file+datetree "~/org/personal-journal.org")
	 "* %?\nEntered on %U\n  %i\n  %a")
	("c" "Coding Todo" entry
	 (file+headline (concat org-directory "/client-projects.org") (projectile-get-project-name))
	 "* TODO  %?\n  %i\n  %a")
	("r" "Reading Note" entry (file+headline "~/org/readings.org" "Unfiled")
	 "* %? \n   %^{CHAPTER}p%^{PAGE}pEntered: %U")
	("w" "org-protocol" entry (file+headline "~/org/todo.org" "Inbox") "* TODO %i
  %U" :immediate-finish t :clock-in t :clock-resume t)
	))

(setq org-refile-allow-creating-parent-nodes (quote confirm))

;; Really critical lines to keep the todo list as a todo list
(setq org-agenda-skip-scheduled-if-done t)
(setq org-agenda-skip-deadline-if-done t)

;; (eval-after-load "org"
  ;; (progn
    ;; (define-prefix-command 'org-todo-state-map)

    ;; (define-key org-mode-map "\C-cx" 'org-todo-state-map)

    ;; (define-key org-todo-state-map "x"
    ;;   (lambda nil (interactive) (org-todo "CANCELLED")))
    ;; (define-key org-todo-state-map "d"
    ;;   (lambda nil (interactive) (org-todo "DONE")))
    ;; (define-key org-todo-state-map "f"
    ;;   (lambda nil (interactive) (org-todo "DEFERRED")))
    ;; (define-key org-todo-state-map "l"
    ;;   (lambda nil (interactive) (org-todo "DELEGATED")))
    ;; (define-key org-todo-state-map "s"
    ;;   (lambda nil (interactive) (org-todo "STARTED")))
    ;; (define-key org-todo-state-map "w"
    ;;   (lambda nil (interactive) (org-todo "WAITING")))

    ;; (define-key org-agenda-mode-map "\C-n" 'next-line)
    ;; (define-key org-agenda-keymap "\C-n" 'next-line)
    ;; (define-key org-agenda-mode-map "\C-p" 'previous-line)
    ;; (define-key org-agenda-keymap "\C-p" 'previous-line)
    ;(setq org-list-ending-method 'both)
    ;(setq org-version )
    ;; )
  ;; )

(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

;; Auto-save org files
;; from http://stackoverflow.com/questions/8146313/emacs-auto-save-for-org-mode-only
;; (add-hook 'org-mode-hook 'my-org-mode-autosave-settings)

;; (defun my-org-mode-autosave-settings ()
;;   ;; (auto-save-mode 1)   ; this is unecessary as it is on by default
;;   (set (make-local-variable 'auto-save-visited-file-name) t)
;;   (setq auto-save-interval 20)
;;   )

;; Agenda customization

(setq org-agenda-sorting-strategy
      '(
        scheduled-up
        deadline-up
        priority-down
        ))

(setq org-agenda-custom-commands
'(
  ("." "Next Actions" todo "NEXT")  
  ("d" "Agenda + Next Actions" ((agenda) (todo "NEXT")))
  ("'" "Todo 3" tags-todo ""
   (setq org-agenda-max-entries 3)
   )
  ("@" "Todo All" tags-todo ""
   (setq org-agenda-max-entries nil)
   )
  ))

;; Faces

(set-face-attribute 'org-agenda-done nil :strike-through t)
(set-face-attribute 'org-upcoming-deadline nil :foreground "DarkRed")

(defadvice enable-theme (after org-strike-done activate)
  "Setup org-agenda-done faces to have strike-through on"
  (and (message "Running advice")
       (set-face-attribute 'org-agenda-done nil :strike-through t)))


;; org-jira
(setq jiralib-url "https://colabcoop.atlassian.net/")
(setq jiralib-user-login-name "ethan@colab.coop")

;; Refiling
;; from http://doc.norang.ca/org-mode.html

; Targets include this file and any file contributing to the agenda - up to 9 levels deep
(setq org-refile-targets (quote ((nil :maxlevel . 1)
                                 (org-agenda-files :maxlevel . 1))))

; Use full outline paths for refile targets - we file directly with IDO
(setq org-refile-use-outline-path t)

; Targets complete directly with IDO
(setq org-outline-path-complete-in-steps nil)

; Allow refile to create parent tasks with confirmation
(setq org-refile-allow-creating-parent-nodes (quote confirm))

; Use IDO for both buffer and file completion and ido-everywhere to t
(setq org-completion-use-ido t)

; Use the current window for indirect buffer display
(setq org-indirect-buffer-display 'current-window)

;;;; Refile settings
; Exclude DONE state tasks from refile targets
(defun bh/verify-refile-target ()
  "Exclude todo keywords with a done state from refile targets"
  (not (member (nth 2 (org-heading-components)) org-done-keywords)))

(setq org-refile-target-verify-function 'bh/verify-refile-target)

(defun org-insert-src-block (src-code-type)
  "Insert a `SRC-CODE-TYPE' type source code block in org-mode."
  (interactive
   (let ((src-code-types
          '("emacs-lisp" "python" "C" "sh" "java" "js" "clojure" "C++" "css"
            "calc" "asymptote" "dot" "gnuplot" "ledger" "lilypond" "mscgen"
            "octave" "oz" "plantuml" "R" "sass" "screen" "sql" "awk" "ditaa"
            "haskell" "latex" "lisp" "matlab" "ocaml" "org" "perl" "ruby"
            "scheme" "sqlite")))
     (list (ido-completing-read "Source code type: " src-code-types))))
  (progn
    (newline-and-indent)
    (insert (format "#+BEGIN_SRC %s\n" src-code-type))
    (newline-and-indent)
    (insert "#+END_SRC\n")
    (previous-line 2)
    (org-edit-src-code)))


;; active Org-babel languages
(org-babel-do-load-languages
 'org-babel-load-languages
 '(;; other Babel languages
   (plantuml . t)))

(setq org-plantuml-jar-path
      (expand-file-name "/usr/local/Cellar/plantuml/8002/plantuml.8002.jar"))
;; Work with custom TODO states
;; From http://sachachua.com/blog/2014/04/thinking-todo-keywords/

;; (defun sacha/org-agenda-skip-scheduled ()
;;   (org-agenda-skip-entry-if 'scheduled 'deadline 'regexp "\n]+>"))

;; (add-to-list 'org-agenda-custom-commands
;;              '("u" "Unscheduled tasks" alltodo ""
;;                ((org-agenda-skip-function 'sacha/org-agenda-skip-scheduled)
;;                 (org-agenda-overriding-header "Unscheduled TODO entries: "))))

;; (require 'emacs-toggl)

(defun eethann/org-advance-narrowed-buffer () 
  (interactive)
  (widen)
  (org-forward-heading-same-level 1)
  (org-narrow-to-subtree)
)

(evil-leader/set-key-for-mode 'org-mode
  "j" 'eethann/org-advance-narrowed-buffer
  "N" 'widen
  "n" 'org-narrow-to-subtree
)

(provide 'personal-org)
;;; personal-org  ends here
