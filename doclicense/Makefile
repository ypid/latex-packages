TEXMFHOME ?= $(shell kpsewhich -var-value TEXMFHOME)

all: install build

build: check-quick doclicense.sty doclicense.pdf

install:
	mkdir --parents "$(TEXMFHOME)/tex/latex/"
	test -L "$(TEXMFHOME)/tex/latex/doclicense" || ln --no-target-directory --symbolic "$$PWD" "$(TEXMFHOME)/tex/latex/doclicense"

check-quick: doclicense.dtx
	chktex "$<"

check: run_tests doclicense.sty lint
	./"$<"

lint:
	find -regextype posix-egrep -iregex '.*\.(tex|ldf)' -and -not -iname '*-plaintext.tex' -print0 | xargs --null chktex

clean:
	rm -rf *.sty *.pdf *.aux *.out *.glo *.gls *.hd *.idx *.ilg *.ind *.log *.toc

doclicense.sty:
doclicense.pdf:

%.sty: %.ins %.dtx
	tex "$<"

%.pdf: %.dtx doclicense.sty
	lualatex "$<"
	makeindex -s gglo.ist -o doclicense.gls doclicense.glo
	makeindex -s gind doclicense
	lualatex "$<"
	# thumbpdf doclicense
	# lualatex "$<"
