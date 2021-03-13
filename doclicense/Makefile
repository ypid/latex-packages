# SPDX-FileCopyrightText: 2015,2020-2021 Robin Schneider <ypid@riseup.net>
#
# SPDX-License-Identifier: LPPL-1.3c
#
# This work consists of all files listed in manifest.txt.
# For more details about the licensing, refer to the README.md file.

TEXMFHOME ?= $(shell kpsewhich -var-value TEXMFHOME)

all: install build manifest.txt

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
	reuse lint

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

manifest.txt: manifest_header.txt Makefile
	cat "$<" > "$@"
	echo "% This work consists of the files:" >> "$@"
	echo manifest.txt doclicense.dtx doclicense.ins README.md Makefile doclicense-*.ldf \
		images/doclicense-*.pdf \
		images/doclicense-*.eps \
		license-texts/doclicense-*.tex | tr ' ' '\n' >> "$@"
	echo "% and the derived files:" >> "$@"
	echo doclicense.sty doclicense.pdf | tr ' ' '\n' >> "$@"
