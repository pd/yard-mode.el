CASK ?= cask

all: script

# Font face testing doesn't work in --win mode,
# so I don't run this by default. Good enough.
win:
	${CASK} exec ecukes features

script:
	${CASK} exec ecukes --script features

cask:
	${CASK} install

travis: cask script
