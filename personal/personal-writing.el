;;; personal-writing.el
;;; My defaults for writing prose, etc.
;;;
;;; ethan@colab.coop

;;; Code:

(prelude-require-packages '(writeroom-mode adoc-mode writegood-mode mmm-mode))


(mmm-add-classes
 '(
   (markdown-python
    :submode python-mode
    :face mmm-declaration-submode-face
    :front "^```python[\n\r]+"
    :back "^```$")
   (markdown-js
    :submode js3-mode
    :face mmm-declaration-submode-face
    :front "^```js[\n\r]+"
    :back "^```$")
   (markdown-json
    :submode js3-mode
    :face mmm-declaration-submode-face
    :front "^```json[\n\r]+"
    :back "^```$")
   ))

(setq mmm-global-mode 't)
(mmm-add-mode-ext-class 'markdown-mode nil 'markdown-python)
(mmm-add-mode-ext-class 'markdown-mode nil 'markdown-js)
(mmm-add-mode-ext-class 'markdown-mode nil 'markdown-json)

(provide 'personal-writing)
;;; personal-writing ends here
