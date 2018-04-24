WGET_OPTIONS ?= --no-verbose

REQUIRED_FILE_SUFFIXES ?= pdf eps
REQUIRED_BASE_FILES ?= doclicense-CC-by doclicense-CC-by-sa doclicense-CC-by-nd doclicense-CC-by-nc doclicense-CC-by-nc-eu doclicense-CC-by-nc-sa doclicense-CC-by-nc-sa-eu doclicense-CC-by-nc-nd doclicense-CC-by-nc-nd-eu doclicense-CC-pd doclicense-CC-zero

REQUIRED_FILES = $(foreach prefix,$(REQUIRED_BASE_FILES),$(foreach suffix,$(REQUIRED_FILE_SUFFIXES),$(prefix).$(suffix)))

.PHONY: default
default: all

.PHONY: all
all: $(REQUIRED_FILES)


## Not available as eps.
doclicense-CC-zero.eps: doclicense-CC-cc-zero.svg
	$(eps-from-svg)
doclicense-CC-zero.pdf: doclicense-CC-cc-zero.svg
	$(pdf-from-svg)


define download-creativecommons =
wget $(WGET_OPTIONS) "https://mirrors.creativecommons.org/presskit/buttons/88x31/$(patsubst .%,%,$(suffix $@))/$(subst -eu.,.eu.,$(@:doclicense-CC-%=%))" -O "$@"
endef

doclicense-CC-%.eps:
	$(download-creativecommons)

doclicense-CC-%.png:
	$(download-creativecommons)

doclicense-CC-%.svg:
	$(download-creativecommons)


## Make epstopdf behave. Version 2.22 writes an output file even if it fails.
.DELETE_ON_ERROR:

## Not deterministic.
define pdf-from-eps =
epstopdf --outfile="$@" "$<"
endef

%.pdf: %.eps
	$(pdf-from-eps)

define pdf-from-svg =
rsvg-convert -f pdf -o "$@" "$<"
endef

define eps-from-svg =
inkscape "$<" --export-eps "$@"
endef

## Alternative build pipeline. Prefer eps -> pdf
# %.pdf: %.svg
#     $(pdf-from-svg)


.PHONY: clean distclean
distclean: clean
clean:
	rm -rf *.svg
