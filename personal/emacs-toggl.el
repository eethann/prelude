;;; emacs-toggl --- A basic toggl integraiton for emacs and org
;; Author: Ethan Winn <ethan@colab.coop>


;; TODO: factor out emacs-toggl and org-toggl

;;; Code:

(prelude-require-package 'request)
(require 'json)

(make-local-variable 'toggl-current-timer-id)
(setq toggl-current-timer-id nil)

(defvar toggl-api-key nil "API key to use for Toggl API requests")

(defvar toggl-request-protocol "https" "protocol string for url of toggl requests")
(defvar toggl-request-domain "www.toggl.com")
(defvar toggl-request-base-path "/api/v8")

;; TODO Use gpg encrypted file for this (authorization.txt.gpg?)
(setq toggl-api-key "<SECRET>")

(defun toggl-request-url (request-path)
  (concat
   toggl-request-protocol "://" toggl-request-domain toggl-request-base-path request-path)
)

(cl-defun toggl-request-do (request-path &key data type success)
  (let (
        (authorization-header
         (base64-encode-string (concat toggl-api-key ":api_token")))
        )
    (request
     (toggl-request-url request-path)
     :type type
     :headers (list
                (cons "Authorization" (concat "Basic " authorization-header))
                '("Content-Type" . "application/json")
                )
     :data data
     :parser 'json-read
     ;; TODO add support for message queing, for when offline
     ;; (note: will need to change timer starts to timer entries/start times/end times)
     :error (function* (lambda (&rest rest &key error-thrown &allow-other-keys)
                         (message "Got error: %S" error-thrown)
                         (message "Rest: %S" rest)
                         ))
     :success success
     )
    )
  )

(defun toggl-start-timer (timer-description)
  (interactive "MDescription: ")
  (toggl-request-do
   "/time_entries/start"
   :type "POST"
   :data (json-encode (list :time_entry (list :description timer-description)))
   :success (function* (lambda (&rest rest &key data &allow-other-keys)
                         (setq toggl-current-timer-id
                                     (cdr (assoc 'id (car data))))
                         ))
   )
  )

(cl-defun toggl-stop-timer ()
  (interactive)
  (if toggl-current-timer-id
      (toggl-request-do
       (format "/time_entries/%d/stop" toggl-current-timer-id)
       :type "PUT"
       ))
)

(add-hook 'org-clock-in-hook
          (lambda ()
            (toggl-start-timer (org-clock-in-last))
))

(add-hook 'org-clock-out-hook
          (lambda ()
            (toggl-stop-timer)
))

(defun toggl-test-request ()
  (toggl-start-timer "test 2")
  (toggl-stop-timer)
)

(define-key global-map "\C-xt" 'toggl-start-timer)
(define-key global-map "\C-xT" 'toggl-stop-timer)

(provide 'emacs-toggl)

;;; emacs-toggl.el ends here
