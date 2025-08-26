# SPDX-FileCopyrightText: 2015,2020-2021 Robin Schneider <ypid@riseup.net>
#
# SPDX-License-Identifier: LPPL-1.3c
#
# This work consists of all files listed in manifest.txt.
# For more details about the licensing, refer to the README.md file.

# Keep secondary targets.
.SECONDARY:

# But still delete secondary targets if the actual generating fails.
.DELETE_ON_ERROR:

SHELL   := /bin/bash -o nounset -o pipefail -o errexit

WGET_OPTIONS ?= --no-verbose

REQUIRED_FILE_SUFFIXES ?= pdf eps
REQUIRED_BASE_FILES ?= \
	doclicense-CC-by-80x15 \
	doclicense-CC-by-88x31 \
	doclicense-CC-by-sa-80x15 \
	doclicense-CC-by-sa-88x31 \
	doclicense-CC-by-nd-80x15 \
	doclicense-CC-by-nd-88x31 \
	doclicense-CC-by-nc-80x15 \
	doclicense-CC-by-nc-88x31 \
	doclicense-CC-by-nc-eu-88x31 \
	doclicense-CC-by-nc-sa-80x15 \
	doclicense-CC-by-nc-sa-88x31 \
	doclicense-CC-by-nc-sa-eu-88x31 \
	doclicense-CC-by-nc-nd-80x15 \
	doclicense-CC-by-nc-nd-88x31 \
	doclicense-CC-by-nc-nd-eu-88x31 \
	doclicense-CC-zero-80x15 \
	doclicense-CC-zero-88x31 \
	$(patsubst %.svg,%,$(wildcard doclicense-*-unofficial-*.svg))

REQUIRED_FILES = $(foreach prefix,$(REQUIRED_BASE_FILES),$(foreach suffix,$(REQUIRED_FILE_SUFFIXES),$(prefix).$(suffix)))

.PHONY: default
default: all

.PHONY: all
all: $(REQUIRED_FILES)


define download-creativecommons =
modifier="$(subst zero,cc-zero,$(@:doclicense-CC-%=%))"; \
image_type="$${modifier##*.}"; \
image_variant="$${modifier##*-}"; \
image_variant="$${image_variant%%.*}"; \
modifier="$${modifier/pd-80x15/publicdomain-80x15}"; \
modifier="$${modifier%%-80x15*}"; \
modifier="$${modifier%%-88x31*}"; \
modifier="$${modifier/-eu/.eu}"; \
wget $(WGET_OPTIONS) "https://mirrors.creativecommons.org/presskit/buttons/$${image_variant}/$${image_type}/$${modifier}.$${image_type}" -O "$@"
endef

## cc-zero file missing.
# doclicense-CC-%.eps:
#     $(download-creativecommons)

## png is not a vector file format.
doclicense-CC-%.png:
	$(download-creativecommons)

doclicense-CC-%.svg:
	$(download-creativecommons)

## For reproducibility, the following version was used to generated the files: Inkscape 1.0 (4035a4fb49, 2020-05-01) Pango version: 1.42.3

%.pdf: %.svg
	@# For Inkscape 0.x: inkscape "$<" --export-pdf "$@"
	inkscape "$<" --export-type=pdf --export-filename "$@.tmp.pdf"
	@# Convert to PDF/A
	gs -dPDFA -dBATCH -dNOPAUSE -sColorConversionStrategy=UseDeviceIndependentColor -sDEVICE=pdfwrite -dPDFACompatibilityPolicy=2 -sOutputFile="$@" "$@.tmp.pdf"
	rm -f "$@.tmp.pdf"

	@# Make output deterministic:
	sed --regexp-extended --in-place "s#^(.*/CreationDate \()D:[0-9+')]+\)#\1D:20200523232323+02'00)#;" "$@"
	@# The proper way to do it would be but that changes other parts of the file too which is not wanted.
	@# exiftool -CreateDate='2020-05-23 23:23:23' "$@"

%.eps: %.svg
	@# For Inkscape 0.x: inkscape "$<" --export-eps "$@"
	inkscape "$<" --export-type=eps --export-filename "$@"

	@# Make output deterministic:
	sed --regexp-extended --in-place "s#^(%%CreationDate:).*#\1 Sat May 23 23:23:23 2020#;" "$@"


.PHONY: clean distclean
distclean: clean
clean:
	rm -rf *.pdf *.eps
