;;; Package personal-email

(add-to-list 'load-path "/usr/local/share/emacs/site-lisp/mu4e")
(prelude-require-packages '(smtpmail))

;;; Need to set user-mail-address before loading mu4e
;;; https://github.com/djcb/mu/issues/399
(setq
 user-mail-address "ethan@colab.coop"
 mu4e-confirm-quit nil
 )

(require 'mu4e)
(require 'org-mu4e)

(setq user-full-name "Ethan Winn"
      user-mail-address "ethan@colab.coop")

(defun eethann/mail-signature-separator () 
  (nth (random 3) '("~~~~~" "---" "=-+-="))
)

(defun eethann/mail-signature () 
  (concat
   ;; (eethann/mail-signature-separator)
   ;; "\n"
   "ethan@colab.coop"
   "\n"
   "(w)866.991.3263"
   "\n"
   "(c)617.517.4949"
   "\n"
   "
In order to stay aligned with what matters most I limit my use of
email. I try to check only twice a day: once at mid-day and once at
the end of the day (usually EST, GMT - 5hrs). If your matter is more
urgent, please reach out to me via Google Chat/jabber or phone.
"
   )
)

(setq mail-signature (eethann/mail-signature))

(setq mu4e-compose-signature
      'eethann/mail-signature)


(defun mailrc ()
  (interactive)
  (find-file "~/.mailrc")
  )

; TODO: Switch to using nullmailer because it's faster
(setq smtpmail-starttls-credentials '(("smtp.gmail.com" 587 nil nil))
      smtpmail-smtp-server "smtp.gmail.com"
      smtpmail-default-smtp-server "smtp.gmail.com"
      send-mail-function 'smtpmail-send-it
      message-send-mail-function 'smtpmail-send-it
      smtpmail-smtp-service 587
      smtp-ssl t
      smtpmail-auth-credentials
      (expand-file-name "~/.authinfo.gpg")
      ;; '(("smtp.gmail.com"
      ;; 587
      ;; "ah.gilberto.c at gmail.com"
      ;; nil))
      )
(setq smtp-ssl t)
(setq starttls-use-gnutls t)
    (setq starttls-gnutls-program "gnutls-cli")
    (setq starttls-extra-arguments nil)



;; default
(setq mu4e-maildir (expand-file-name "~/mail"))

(setq mu4e-drafts-folder "/[Gmail]/.Drafts")
(setq mu4e-sent-folder   "/[Gmail]/.Sent Mail")
(setq mu4e-trash-folder  "/[Gmail]/.Trash")
(setq mu4e-refile-folder "/[Gmail]/.All Mail")

;; don't save message to Sent Messages, GMail/IMAP will take care of this
(setq mu4e-sent-messages-behavior 'delete)
(setq mu4e-headers-skip-duplicates t)
;; setup some handy shortcuts
(setq mu4e-maildir-shortcuts
    '( ("/INBOX"               . ?i)
       ("/[Gmail]/.Sent Mail"   . ?s)
       ("/[Gmail]/.Trash"       . ?t)
       ("/[Gmail]/.All Mail"    . ?a)))

;; allow for updating mail using 'U' in the main view:
(setq mu4e-get-mail-command "mbsync -aq")

;; enable org-to-html
;; this doesn't work.
;; (require 'org-mu4e)
(setq org-mu4e-convert-to-html nil)
(setq mu4e-change-filenames-when-moving t)
(setq mu4e-use-fancy-chars t)




;; need this to convert some e-mails properly
;;    (setq mu4e-html2text-command "html2text -utf8 -width 72")
(setq mu4e-html2text-command 'html2text)

(defun html2text ()
  "Replacement for standard html2text using shr."
  (interactive)
  (let ((dom (libxml-parse-html-region (point-min) (point-max))))
    (erase-buffer)
    (shr-insert-document dom)
    (goto-char (point-min))))

; Optional
(defun jsm:shr-browse-url ()
  "For mu4e messages, browse the URL under point or advance the message"
  (interactive)
  (let ((url (get-text-property (point) 'shr-url)))
    (if (not url)
        (mu4e-scroll-up)
      (shr-browse-url))))
(define-key mu4e-view-mode-map (kbd "RET") 'jsm:shr-browse-url)

;; use horizontal split because my screens are wide but not that wide!
(setq mu4e-split-view 'horizontal)

;; set mu4e as the default email program in emacs
(setq mail-user-agent 'mu4e-user-agent)

;; Set personal bookmark
(add-to-list 'mu4e-bookmarks
  '("flag:unread maildir:/[GMAIL]/.Starred"       "Unread Starred"     ?S))
(add-to-list 'mu4e-bookmarks
  '("flag:unread date:today..now"       "Unread Today"     ?T))

;; use fancy characters where possible
;; (setq mu4e-use-fancy-chars t)

(add-hook 'mu4e-view-mode-hook 'visual-line-mode)

;; Save attachments to my Downloads directory by default
(setq mu4e-attachment-dir  "~/Downloads")
;; TODO: This can be a function that takes a file-name and mime-type
;; which might be cool for dynamically deciding save location.
(eval-after-load 'mu4e
  '(progn
     ;; use the standard bindings as a base
     (evil-make-overriding-map mu4e-view-mode-map 'normal t)
     (evil-make-overriding-map mu4e-main-mode-map 'normal t)
     (evil-make-overriding-map mu4e-headers-mode-map 'normal t)

     (evil-add-hjkl-bindings mu4e-view-mode-map 'normal
       "J" 'mu4e~headers-jump-to-maildir
       "j" 'evil-next-line
       "C" 'mu4e-compose-new
       "o" 'mu4e-view-message
       "Q" 'mu4e-raw-view-quit-buffer)

     ;; (evil-add-hjkl-bindings mu4e-view-raw-mode-map 'normal
     ;;   "J" 'mu4e-jump-to-maildir
     ;;   "j" 'evil-next-line
     ;;   "C" 'mu4e-compose-new
     ;;   "q" 'mu4e-raw-view-quit-buffer)

     (evil-add-hjkl-bindings mu4e-headers-mode-map 'normal
       "j" 'mu4e-headers-next
       "k" 'mu4e-headers-prev
       "J" 'mu4e~headers-jump-to-maildir
       "l" 'mu4e-headers-mark-for-retag'
       "C" 'mu4e-compose-new
       "o" 'mu4e-view-message
       "a" 'mu4e-headers-action
       )

     (evil-add-hjkl-bindings mu4e-main-mode-map 'normal
       "J" 'mu4e~headers-jump-to-maildir
       "j" 'evil-next-line
       "RET" 'mu4e-view-message)
     ))

(loop for (mode) in '('mu4e-headers-mode 'mu4e-compose-mode 'mu4e-main-mode)
      do 
'      (setq evil-emacs-state-modes (remove mode evil-emacs-state-modes)))

;; something about ourselves
;; I don't use a signature...
(setq
 user-mail-address "ethan@colab.coop"
 user-full-name  "Ethan Winn"
  message-signature
   (concat
     "\n---\n"
     "Ethan Winn - worker and owner @ CoLab.coop\n"
     "ethan@colab.coop\n")
 )

;; Set up Queue Mode bindings

(setq smtpmail-queue-mail nil  ;; start in queuing mode
      smtpmail-queue-dir   "~/mail/queue/cur")

(defun eethann/smtpmail-toggle-queue-mail ()
    "Toggle mail queueing"
  (interactive)
  (if smtpmail-queue-mail
      (setq smtpmail-queue-mail nil)
      (setq smtpmail-queue-mail t)
      )
  )

(evil-leader/set-key
  "C->" 'eethann/smtpmail-toggle-queue-mail
  "C-." 'smtpmail-send-queued-mail
)

(provide 'personal-email)
