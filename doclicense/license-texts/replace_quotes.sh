#!/bin/bash

for i in *latex.tex
do
	cat $i | perl -0pe "s/\"(([^\"])*)\"/\`\`\1''/g" > $i.quoteless
	mv -v $i.quoteless $i
done
