;;; package --- Personal Auto Complete

;;; Code:

(prelude-require-packages
 '(
   auto-complete
   ))


(global-set-key
 (kbd "M-\\") 'hippie-expand)

;;; Commentary:


(provide 'personal-auto-complete)
