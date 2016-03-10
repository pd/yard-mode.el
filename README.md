# yard-mode
[![Build Status](https://travis-ci.org/pd/yard-mode.el.png)](https://travis-ci.org/pd/yard-mode.el)
[![Coverage Status](https://coveralls.io/repos/github/pd/yard-mode.el/badge.svg)](https://coveralls.io/github/pd/yard-mode.el)

Rudimentary support for fontifying YARD tags and directives in ruby
comments.

![Example screenshot](https://github.com/pd/yard-mode.el/raw/master/screenshot.png)

## Installation
Use [MELPA](https://github.com/milkypostman/melpa): `M-x package-install yard-mode`.

Add it to your ruby hook:

```scheme
(add-hook 'ruby-mode-hook 'yard-mode)
```

If you would also like `eldoc` support, so that the expected syntax for
the tag beneath your cursor is displayed in the minibuffer, add that
hook too:

```scheme
(add-hook 'ruby-mode-hook 'eldoc-mode)
```

## TODO
1. Some reasonable means of providing completions.
2. Tidy up the defcustoms; most could be parsed from `yard-tag-docstrings`.
