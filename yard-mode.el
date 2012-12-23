;;; yard-mode.el --- Minor mode for font-locking and editing YARD comments in ruby files
;;; Version: 0.1
;;; Author: Kyle Hargraves
;;; URL: https://github.com/pd/yard-mode.el

(eval-when-compile (require 'cl))
(require 'regexp-opt)

(defgroup yard nil
  "Minor mode to fontify YARD tags and directives.")

(defcustom yard-tags
  '("abstract" "api" "attr" "attr_reader" "attr_writer"
    "author" "deprecated" "example" "note" "option" "overload"
    "param" "private" "raise" "return" "see" "since" "todo" "version"
    "yield" "yieldparam" "yieldreturn")
  "The list of known YARD @tag names.

See http://rubydoc.info/docs/yard/file/docs/Tags.md#Tag_List"
  :type 'list
  :group 'yard)

(defcustom yard-tags-with-names
  '("attr" "attr_reader" "attr_writer" "param" "yieldparam")
  "YARD tags which require a name value."
  :type 'list
  :group 'yard)

(defcustom yard-directives
  '("attribute" "endgroup" "group" "macro" "method"
    "parse" "scope" "visibility")
  "The list of known YARD @!directive names.

See http://rubydoc.info/docs/yard/file/docs/Tags.md#Directive_List"
  :type 'list
  :group 'yard)

(defface yard-tag-face
  '((t :inherit font-lock-doc-face))
  "Face for YARD tags."
  :group 'yard)

(defface yard-directive-face
  '((t :inherit font-lock-doc-face))
  "Face for YARD directives."
  :group 'yard)

(defface yard-types-face
  '((t :inherit font-lock-type-face))
  "Face for YARD types list; ie 'String, #to_s': @param [String, #to_s] name"
  :group 'yard)

(defface yard-name-face
  '((t :inherit font-lock-variable-name-face))
  "Face for YARD variable name; eg. 'name': @param [String] name"
  :group 'yard)

(defun yard-font-lock-keywords ()
  "Generate a list of keywords suitable for `font-lock-add-keywords'
and `font-lock-remove-keywords'."
  `((,(concat "# *\\(@" (regexp-opt yard-tags) "\\)") 1 'yard-tag-face t)
    (,(concat "# *\\(@!" (regexp-opt yard-directives) "\\)") 1 'yard-directive-face t)
    (,(concat "# *@!?.+?\\[\\(.+?\\)\\]") 1 'yard-types-face t)
    (,(concat "# *@!?" (regexp-opt yard-tags-with-names) " \\(\\sw+\\)") 1 'yard-name-face t)
    (,(concat "# *@!?" (regexp-opt yard-tags-with-names) " \\[.+?\\] \\(\\sw+\\)") 1 'yard-name-face t)
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
