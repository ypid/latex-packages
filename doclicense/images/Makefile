WGET_OPTIONS ?= --no-verbose

.PHONY: default all
default: all

all: doclicense-CC-by.pdf doclicense-CC-by-sa.pdf doclicense-CC-by-nd.pdf doclicense-CC-by-nc.pdf doclicense-CC-by-nc.eu.pdf doclicense-CC-by-nc-sa.pdf doclicense-CC-by-nc-sa.eu.pdf doclicense-CC-by-nc-nd.pdf doclicense-CC-by-nc-nd.eu.pdf doclicense-CC-pd.pdf doclicense-CC-zero.pdf
	rename 's#\.eu\.#-eu.#' -v *
	for file in *-eu.pdf; do oldfile="$${file%-eu.pdf}.eu.pdf"; ln -s "$$file" "$$oldfile"; done

doclicense-CC-pd.pdf: doclicense-CC-publicdomain.pdf
	mv "$<" "$@"
	ln -sf "$@" "$<"

doclicense-CC-zero.pdf: doclicense-CC-cc-zero.pdf
	mv "$<" "$@"
	ln -sf "$@" "$<"

doclicense-CC-%.pdf: %.svg
	rsvg-convert -f pdf -o "$@" "$<"

doclicense-CC-%.pdf: %.eps
	epstopdf "$<" --outfile="$@"

%.svg:
	wget $(WGET_OPTIONS) "http://mirrors.creativecommons.org/presskit/buttons/88x31/svg/$@"

%.eps:
	wget $(WGET_OPTIONS) "http://mirrors.creativecommons.org/presskit/buttons/88x31/eps/$@"

.PHONY: clean distclean
clean: distclean
	rm -rf *.svg
	rm -rf *.eps
