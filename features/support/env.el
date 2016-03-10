;; This is an example of how you could set up this file. This setup
;; requires a directory called util in the project root and that the
;; util directory contains the testing tools ert and espuds.

(when (require 'undercover nil t)
  (undercover "*.el"))

(let* ((features-directory
        (file-name-directory
         (directory-file-name (file-name-directory load-file-name))))
       (project-directory
        (file-name-directory
         (directory-file-name features-directory))))
  (setq yard-mode-root-path project-directory)
  (setq yard-mode-util-path (expand-file-name "util" yard-mode-root-path)))

(add-to-list 'load-path yard-mode-root-path)
(add-to-list 'load-path (expand-file-name "espuds" yard-mode-util-path))
(add-to-list 'load-path (expand-file-name "ert" yard-mode-util-path))

(require 'ruby-mode)
(require 'yard-mode)
(require 'espuds)
(require 'ert)


(Setup
 ;; Before anything has run
 )

(Before
 ;; Before each scenario is run
 )

(After
 ;; After each scenario is run
 )

(Teardown
 ;; After when everything has been run
 )
