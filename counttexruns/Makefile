
build:
	pdflatex counttexruns.dtx
	makeindex -s gglo.ist -o counttexruns.gls counttexruns.glo
	makeindex -s gind counttexruns
	pdflatex counttexruns.dtx
	thumbpdf counttexruns
	pdflatex counttexruns.dtx
