(When "I view a ruby file with yard-mode enabled"
      (lambda ()
        (find-file (expand-file-name "features/stubs/some_class.rb" yard-mode-root-path))
        (ruby-mode)
        (yard-mode)
        (font-lock-fontify-buffer)))

(When "I enable eldoc-mode"
      (lambda ()
        (eldoc-mode)))

(Then "^the \"\\(.+\\)\" tag is highlighted$"
      (lambda (tag)
        (goto-char (point-min))
        (search-forward (concat "# " tag))
        (backward-char (length tag))
        (should
         (equal 'font-lock-doc-face
                (text-properties-at (point))))))

(Then "^the face should be \"\\(.+\\)\"$"
      (lambda (face-name)
        (should
         (equal (intern-soft face-name)
                (plist-get (text-properties-at (point)) 'face)))))

(Then "^eldoc should be showing \"\\(.+\\)\""
      (lambda (msg)
        (should
         (string= msg (funcall eldoc-documentation-function)))))
