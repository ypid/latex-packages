#!/bin/bash

for i in *latex.tex
do
	echo '\advance\csname @enumdepth\endcsname\csname @ne\endcsname' > $i.adjusted
	cat $i >> $i.adjusted
	echo '\advance\csname @enumdepth\endcsname-\csname @ne\endcsname' >> $i.adjusted

	mv -v $i.adjusted $i
done
