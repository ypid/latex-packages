<!--
SPDX-FileCopyrightText: 2015,2021 Robin Schneider <ypid@riseup.net>

SPDX-License-Identifier: LPPL-1.3c

This work consists of all files listed in manifest.txt.
For more details about the licensing, refer "License" section of this file.
-->

# LaTeX package 'doclicense'

[![CTAN](https://img.shields.io/ctan/v/doclicense.svg)](https://ctan.org/pkg/doclicense)

CTAN: https://www.ctan.org/pkg/doclicense

Code repository: https://github.com/ypid/latex-packages/tree/master/doclicense

Question on Stackexchange: https://tex.stackexchange.com/a/226788/32320

## Description

Support for putting documents under a license.

The doclicense package allows you to put your document under a license and include a link
to read about the license or include an icon or image of the license.
Currently, only Creative Commons is supported but this package is designed to
handle all kinds of licenses.

## Generating the files

You can generate the `doclicense.sty` file with:

```Shell
tex doclicense.ins
```

The documentation can be generated with:

```Shell
make doclicense.pdf
```

Note that this will only work when this directory is below your
`$TEXMFHOME` tree (unless the doclicense package is already installed
for example by your TeX distribution). Example for doing this manually:

```Shell
mkdir --parents ~/texmf/tex/latex/ && cd ~/texmf/tex/latex/
git clone https://github.com/ypid/latex-packages.git ypid-latex-packages
cd ypid-latex-packages/doclicense && make build
```

If you have not worked with `$TEXMFHOME` you might want to refer to the
documentation of your TeX distribution for details. See also the next section.

## Important notes regarding TDS

Please note that the `images/` and the `license-texts/` subdirectories must end up
in the runtime `tex/` subtree (that is `tex/latex/doclicense/`) for the
`\doclicenseImage` macro and the `\doclicense*FullText` macros to work correctly.

## License

SPDX-License-Identifier: LPPL-1.3c

This work may be distributed and/or modified under the
conditions of the LaTeX Project Public License, either version 1.3
of this license or (at your option) any later version.
The latest version of this license is in
  https://www.latex-project.org/lppl.txt
and version 1.3 or later is part of all distributions of LaTeX
version 2005/12/01 or later.

This work has the LPPL maintenance status `maintained'.

The Current Maintainer of this work is Robin Schneider.

This work consists of all files listed in manifest.txt.
