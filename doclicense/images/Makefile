## Keep secondary targets.
.SECONDARY:

## But still delete secondary targets if the actual generating fails.
.DELETE_ON_ERROR:


WGET_OPTIONS ?= --no-verbose

REQUIRED_FILE_SUFFIXES ?= pdf eps
REQUIRED_BASE_FILES ?= doclicense-CC-by doclicense-CC-by-sa doclicense-CC-by-nd doclicense-CC-by-nc doclicense-CC-by-nc-eu doclicense-CC-by-nc-sa doclicense-CC-by-nc-sa-eu doclicense-CC-by-nc-nd doclicense-CC-by-nc-nd-eu doclicense-CC-pd doclicense-CC-zero

REQUIRED_FILES = $(foreach prefix,$(REQUIRED_BASE_FILES),$(foreach suffix,$(REQUIRED_FILE_SUFFIXES),$(prefix).$(suffix)))

.PHONY: default
default: all

.PHONY: all
all: $(REQUIRED_FILES)


define download-creativecommons =
wget $(WGET_OPTIONS) "https://mirrors.creativecommons.org/presskit/buttons/88x31/$(patsubst .%,%,$(suffix $@))/$(subst zero,cc-zero,$(subst -eu.,.eu.,$(@:doclicense-CC-%=%)))" -O "$@"
endef

## cc-zero file missing.
# doclicense-CC-%.eps:
#     $(download-creativecommons)

## png is not a vector format.
# doclicense-CC-%.png:
	# $(download-creativecommons)

doclicense-CC-%.svg:
	$(download-creativecommons)

## For reproducibility, the following version was used to generated the files: Inkscape 0.92.4 (5da689c313, 2019-01-14)

%.pdf: %.svg
	inkscape "$<" --export-pdf "$@"

	@# Make output deterministic:
	sed --regexp-extended --in-place "s#^(.*/CreationDate \()D:[0-9+')]+\)#\1D:20200412232323+02'00)#;" "$@"
	@# The proper way to do it would be but that changes other parts of the file too which is not wanted.
	@# exiftool -CreateDate='2020-04-12 23:23:23' "$@"

%.eps: %.svg
	inkscape "$<" --export-eps "$@"

	@# Make output deterministic:
	sed --regexp-extended --in-place 's#^(%%CreationDate:).*#\1 Sun Apr 12 23:23:23 2020#;' "$@"


.PHONY: clean distclean
distclean: clean
clean:
	rm -rf *.svg
