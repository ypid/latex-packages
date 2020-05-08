TEXMFHOME ?= $(shell kpsewhich -var-value TEXMFHOME)

all: install build

build: doclicense.sty doclicense.pdf

install:
	mkdir --parents "$(TEXMFHOME)/tex/latex/"
	test -L "$(TEXMFHOME)/tex/latex/doclicense" || ln --no-target-directory --symbolic "$$PWD" "$(TEXMFHOME)/tex/latex/doclicense"

check: run_tests doclicense.sty
	./"$<"

clean:
	rm -rf *.sty *.pdf *.aux *.out *.glo *.gls *.hd *.idx *.ilg *.ind *.log *.toc

doclicense.sty:
doclicense.pdf:

%.sty: %.ins %.dtx
	tex "$<"

%.pdf: %.dtx doclicense.sty
	pdflatex "$<"
	makeindex -s gglo.ist -o doclicense.gls doclicense.glo
	makeindex -s gind doclicense
	pdflatex "$<"
	# thumbpdf doclicense
	# pdflatex "$<"
