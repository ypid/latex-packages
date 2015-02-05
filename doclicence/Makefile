WGET_OPTIONS ?= --no-verbose

.PHONY: get-all
get-all: doclicense-CC-by.pdf doclicense-CC-by-sa.pdf doclicense-CC-by-nd.pdf doclicense-CC-by-nc.pdf doclicense-CC-by-nc.eu.pdf doclicense-CC-by-nc-sa.pdf doclicense-CC-by-nc-sa.eu.pdf doclicense-CC-by-nc-nd.eu.pdf

# cc-zero.pdf publicdomain.pdf

doclicense-CC-%.pdf: %.eps
	epstopdf "$<" --outfile="$@"

%.eps:
	wget $(WGET_OPTIONS) "http://mirrors.creativecommons.org/presskit/buttons/88x31/eps/$@"

.PHONY: clean distclean

clean: distclean
	rm -rf *.svg

distclean:
	rm -rf *.eps
