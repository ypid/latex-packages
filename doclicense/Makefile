# SPDX-FileCopyrightText: 2015,2020-2021 Robin Schneider <ypid@riseup.net>
#
# SPDX-License-Identifier: LPPL-1.3c
#
# This work consists of all files listed in manifest.txt.
# For more details about the licensing, refer to the README.md file.

TEXMFHOME ?= $(shell kpsewhich -var-value TEXMFHOME)
SHELL := /bin/bash -o nounset -o pipefail -o errexit

.PHONY: all
all: install build

.PHONY: build
build: manifest.txt doclicense.sty doclicense.pdf

.PHONY: ci
ci: lint build

.PHONY: install
install:
	mkdir --parents "$(TEXMFHOME)/tex/latex/"
	test -L "$(TEXMFHOME)/tex/latex/doclicense" || ln --no-target-directory --symbolic "$(shell pwd)" "$(TEXMFHOME)/tex/latex/doclicense"

.PHONY: check
check: check-copyright-date manifest.txt doclicense.sty lint

# Run before release.
.PHONY: check-full
check-full: check run_tests
	./run_tests

# CTAN people want this when uploading a release.
.PHONY: check-copyright-date
check-copyright-date: README.md
	grep --quiet 'SPDX-FileCopyrightText:.*$(shell date +%Y)\s' "$<"

.PHONY: lint
lint: doclicense.dtx
	chktex "$<"
	find -regextype posix-egrep -iregex '.*\.(tex|ldf)' -and -not -iname '*-plaintext.tex' -print0 | xargs --null chktex
	[[ -z "$(shell lacheck "$<" *.ldf | grep 'possible unwanted space')" ]]
	reuse --root . lint

.PHONY: clean
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

# The `cd .. && git archive` trick was needed with 2.29.2 so that evaluation of
# the `.gitattributes` file worked correctly.
.FORCE:
manifest.txt: manifest_header.txt Makefile .FORCE
	cat "$<" > "$@"
	echo "% This work consists of the files:" >> "$@"
	cd .. && git archive --worktree-attributes HEAD doclicense | tar -t -f - | grep -v '/$$' | sort >> "$(shell pwd)/$@"
	echo "% and the derived files:" >> "$@"
	echo doclicense.sty doclicense.pdf | tr ' ' '\n' >> "$@"
