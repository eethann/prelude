(prelude-require-packages '(jabber sauron))

;; See:
;; https://gist.github.com/puffnfresh/4002033
;; http://www.snip2code.com/Snippet/22380/hipchat-el


;; (require 'mine-jabber)

;; Username & nickname fields from https://banno.hipchat.com/account/xmpp
(setq hipchat-username "44554_465240")
(setq hipchat-nickname "ethan winn")
(setq hipchat-password "cohipchatlab")

(setq hipchat-autojoin-rooms
      '("it__dev_ops" "code_red" "colab_social_center" "colab_cooperative"))

(setq hipchat-chat-domain "chat.hipchat.com")
(setq hipchat-muc-domain "conf.hipchat.com")

(defalias 'hipchat-jack-in 'jabber-connect-all)
(defalias 'hipchat-lobby 'jabber-roster)

(defun hipchat-join-autojoin-rooms ()
  "Log into all autojoin rooms."
  (interactive)
  (dolist (room-name hipchat-autojoin-rooms)
    (hipchat-join-room room-name)))

(defun hipchat-join-room (room-name)
  (interactive "sRoom (e.g. data_services): ")
  (jabber-groupchat-join
   (jabber-read-account)
   (hipchat-room-id room-name)
   hipchat-nickname
   t))

(defun hipchat-jabber-id ()
  "Your personal jabber id: xxxx_yyyy@chat.hipchat.com."
  (concat hipchat-username "@" hipchat-chat-domain))

(defun hipchat-org-id ()
  "Org part of your hipchat username."
  (car (split-string hipchat-username "_")))

(defun hipchat-room-id (room-name)
  "Constructs room url, e.g. xxxx_room-name@conf.hipchat.com"
  (concat (hipchat-org-id) "_" room-name "@" hipchat-muc-domain))

;; this completion decorator doesn't work very well due to the way completing-read works

;; (defun hipchat-jabber-mention-decorator (&optional arg)
;;   "Decorates @mentions so that hipchat understands them: @\"name\"\s"
;;   (interactive "P")
;;   (let ((starting-text (thing-at-point 'line)))
;;     (jabber-muc-completion arg)
;;     (unless (string= starting-text (thing-at-point 'line))
;;       (hipchat-decorate-mention-line))))

;; (defun hipchat-decorate-mention-line ()
;;   (let* ((mention (thing-at-point 'line))
;;          (trimmed (replace-regexp-in-string "\\`[ \t\n]*" "" (replace-regexp-in-string "[ \t\n]*\\'" "" mention)))
;;          (already-decorated (string-match "@" trimmed)))
;;     (unless already-decorated
;;       (delete-region (line-beginning-position) (line-end-position))
;;       (insert (concat (replace-regexp-in-string "^\\(.+?\\)\\:\\{0,1\\}$" "@\"\\1\"" trimmed) " ")))))

(defun hipchat-decorate-nickname (nickname)
  (let* ((trimmed (replace-regexp-in-string "\\`[ \t\n]*" "" (replace-regexp-in-string "[ \t\n]*\\'" "" nickname)))
         (already-decorated (string-match "@" trimmed)))
    (if already-decorated
        trimmed
      (replace-regexp-in-string "^\\(.+?\\)\\:\\{0,1\\}$" "@\"\\1\"" trimmed))))

(defun hipchat-mention (nickname)
  "Search for a nickname, hipchat-decorate it and insert it at point."
  (interactive (list (jabber-muc-read-nickname jabber-group "Mention: ")))
  (insert (concat (hipchat-decorate-nickname nickname) " ")))

(setq hipchat-interactive-decorate-nick-marker nil)
(defun hipchat-mark-for-interactive-decorate-nick ()
  "Marks point before starting a nickname completing read."
  (interactive)
  (make-local-variable 'hipchat-interactive-decorate-nick-marker)
  (setq hipchat-interactive-decorate-nick-marker (point)))

(defun hipchat-interactive-decorate-nick-from-mark ()
  "Hipchat-decorates a nick that was marked for decoration."
  (interactive)
  (save-restriction
    (narrow-to-region hipchat-interactive-decorate-nick-marker (point))
    (let ((nick (thing-at-point 'line)))
      (delete-region (point-min) (point-max))
      (insert (concat (hipchat-decorate-nickname nick) " "))))
  (setq hipchat-interactive-decorate-nick-from-mark nil))

(add-to-list 'jabber-account-list `(,(hipchat-jabber-id)
                                    (:password . ,hipchat-password)
                                    (:network-server . ,hipchat-chat-domain)
                                    (:port . 5223)
                                    (:connection-type . ssl)))

(setq hipchat-keymap
  (let ((map (make-sparse-keymap)))
    ;; (define-key map (kbd "TAB") 'hipchat-jabber-mention-decorator)
    (define-key map (kbd "C-x C-j m") 'hipchat-mark-for-interactive-decorate-nick)
    (define-key map (kbd "C-x C-j RET") 'hipchat-interactive-decorate-nick-from-mark)
    map))

;;;###autoload
(define-minor-mode hipchat-mode "Hipchat Jabber mode"
  :group 'hipchat
  :lighter " hipchat"
  :keymap hipchat-keymap)

(defun turn-on-hipchat-mode ()
  (interactive)
  (hipchat-mode t))

(defun turn-off-hipchat-mode ()
  (interactive)
  (hipchat-mode -1))

(add-hook 'jabber-chat-mode-hook '(lambda () (when (search "hipchat" (buffer-name)) (turn-on-hipchat-mode))))

(provide 'personal-jabber)
