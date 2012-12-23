;;; yard-mode.el --- Minor mode for font-locking and editing YARD comments in ruby files
;;; Version: 0.1
;;; Author: Kyle Hargraves
;;; URL: https://github.com/pd/yard-mode.el

(eval-when-compile (require 'cl))
(require 'regexp-opt)

(defcustom yard-tags
  '("abstract" "api" "attr" "attr_reader" "attr_writer"
    "author" "deprecated" "example" "note" "option" "overload"
    "param" "private" "raise" "return" "see" "since" "todo" "version"
    "yield" "yieldparam" "yieldreturn")
  "The list of known YARD @tag names.

See http://rubydoc.info/docs/yard/file/docs/Tags.md#Tag_List")

(defcustom yard-directives
  '("attribute" "endgroup" "group" "macro" "method"
    "parse" "scope" "visibility")
  "The list of known YARD @!directive names.

See http://rubydoc.info/docs/yard/file/docs/Tags.md#Directive_List")

(defun yard-font-lock-keywords ()
  "Generate a list of keywords suitable for `font-lock-add-keywords'
and `font-lock-remove-keywords' based on the contents of `yard-tags'
and `yard-directives'."
  `((,(concat "# *\\(@" (regexp-opt yard-tags) "\\)") 1 font-lock-doc-face t)
    (,(concat "# *\\(@!" (regexp-opt yard-directives) "\\)") 1 font-lock-doc-face t)
    ))

(defun yard-turn-on ()
  "Turn on yard-mode."
  (font-lock-add-keywords nil (yard-font-lock-keywords)))

(defun yard-turn-off ()
  "Turn off yard-mode."
  (font-lock-remove-keywords nil (yard-font-lock-keywords)))

;;;###autoload
(define-minor-mode yard-mode "Font locking and completion for YARD tags and directives"
  :lighter " YARD"
  (progn
    (if yard-mode
        (yard-turn-on)
      (yard-turn-off))
    (font-lock-mode 1)))

(provide 'yard-mode)
