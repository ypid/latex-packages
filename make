#!/bin/bash
## Buildscript

if [ -z "$1" ]
then	echo "Please give a jobname"
	exit 1
fi
jobname=${1%.}

pdflatex "$jobname.ins"
pdflatex "$jobname.dtx"
makeindex -s gglo.ist -o "$jobname.gls" "$jobname.glo"
makeindex -s gind "$jobname"
pdflatex "$jobname.dtx"
makeindex -s gglo.ist -o "$jobname.gls" "$jobname.glo"
makeindex -s gind "$jobname"
thumbpdf "$jobname"
pdflatex "$jobname.dtx"
