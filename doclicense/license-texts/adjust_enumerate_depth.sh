#!/bin/bash

for file in *latex.tex
do
	(
		echo '\advance\csname @enumdepth\endcsname\csname @ne\endcsname'
		cat "$file"
		echo '\advance\csname @enumdepth\endcsname-\csname @ne\endcsname'
	) > "${file}.adjusted"

	mv -v "${file}.adjusted" "$file"
done
