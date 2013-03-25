;;; yard-mode.el --- Minor mode for Ruby YARD comments

;; Author: Kyle Hargraves
;; URL: https://github.com/pd/yard-mode.el
;; Version: 0.1

(eval-when-compile (require 'cl))
(require 'regexp-opt)

(defgroup yard nil
  "Minor mode to fontify YARD tags and directives."
  :group 'tools)

(defcustom yard-tags
  '("abstract" "api" "attr" "attr_reader" "attr_writer"
    "author" "deprecated" "example" "note" "option" "overload"
    "param" "private" "raise" "return" "see" "since" "todo" "version"
    "yield" "yieldparam" "yieldreturn")
  "The list of known YARD @tag names.

See http://rubydoc.info/docs/yard/file/docs/Tags.md#Tag_List"
  :type 'list
  :group 'yard)

(defcustom yard-tag-docstrings
  '("@abstract description"
    "@api description"
    "@attr name [Types] description"
    "@attr_reader name [Types] description"
    "@attr_writer name [Types] description"
    "@author description"
    "@deprecated description"
    "@example Optional title   Code block"
    "@note description"
    "@option name [Types] option_key (default_value) description"
    "@overload method_signature(parameters)   Indented docstring for overload method"
    "@param name [Types] description"
    "@private"
    "@raise [Types] description"
    "@return [Types] description"
    "@see name description"
    "@since description"
    "@todo description"
    "@version description"
    "@yield [parameters] description"
    "@yieldparam name [Types] description"
    "@yieldreturn [Types] description"
    "@!attribute [r | w | rw] attribute_name   Indented attribute docstring"
    "@!endgroup"
    "@!group description"
    "@!macro [attach | new] optional_name   Optional macro expansion data"
    "@!method method_signature(parameters)   Indented method docstring"
    "@!parse [language] code"
    "@!scope class | instance"
    "@!visibility public | protected | private")
  "The full docstring for defined YARD tags.")

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

(defvar yard-tags-re
  (regexp-opt yard-tags))

(defvar yard-directives-re
  (regexp-opt yard-directives))

(defvar yard-tags-and-directives-re
  (regexp-opt (append yard-tags yard-directives)))

(defvar yard-tags-with-names-re
  (regexp-opt yard-tags-with-names))

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
  `((,(concat "# *\\(@" yard-tags-re "\\)") 1 'yard-tag-face t)
    (,(concat "# *\\(@!" yard-directives-re "\\)") 1 'yard-directive-face t)
    (,(concat "# *@!?.+?\\[\\(.+?\\)\\]") 1 'yard-types-face t)
    (,(concat "# *@!?" yard-tags-with-names-re
              " \\(\\(\\sw\\|\\s_\\)+\\)") 1 'yard-name-face t)
    (,(concat "# *@!?" yard-tags-with-names-re
              " \\[.+?\\] \\(\\(\\sw\\|\\s_\\)+\\)") 1 'yard-name-face t)
    ))

(defun yard-in-comment-p ()
  "Returns whether point is currently inside of a comment."
  (let ((ppss (syntax-ppss (point))))
    (and ppss (nth 4 ppss))))

(defun yard-tag-at-point ()
  (save-excursion
    (save-match-data
      (backward-to-indentation 0)
      (when (looking-at (concat "# *@!?\\(" yard-tags-and-directives-re "\\)"))
        (buffer-substring-no-properties (match-beginning 1) (match-end 1))))))

(defun yard-tag-syntax (tag)
  (let (match)
    (dolist (s yard-tag-docstrings)
      (when (string-match-p (concat "@!?" tag) s)
        (setq match s)))
    match))

(defun yard-eldoc-message ()
  (when (yard-in-comment-p)
    (let ((tag (yard-tag-at-point)))
      (when tag (yard-tag-syntax tag)))))

(defun yard-turn-on ()
  "Turn on yard-mode."
  (font-lock-add-keywords nil (yard-font-lock-keywords))
  (set (make-local-variable 'eldoc-documentation-function) 'yard-eldoc-message))

(defun yard-turn-off ()
  "Turn off yard-mode."
  (font-lock-remove-keywords nil (yard-font-lock-keywords))
  (set (make-local-variable 'eldoc-documentation-function) nil))

;;;###autoload
(define-minor-mode yard-mode "Font locking and completion for YARD tags and directives"
  :lighter " YARD"
  (progn
    (if yard-mode
        (yard-turn-on)
      (yard-turn-off))
    (font-lock-mode 1)))

(provide 'yard-mode)

;;; yard-mode.el ends here
