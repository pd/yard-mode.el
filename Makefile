CARTON ?= carton
ECUKES = $(shell find elpa/ecukes-*/ecukes | tail -1)

all: script

# Font face testing doesn't work in --win mode,
# so I don't run this by default. Good enough.
win:
	${CARTON} exec ${ECUKES} features

script:
	${CARTON} exec ${ECUKES} --script features

carton:
	${CARTON} install

travis: carton script
