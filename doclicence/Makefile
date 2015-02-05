
all: doclicense.sty doclicense.pdf

%.sty: %.ins %.dtx
	pdflatex "$<"

%.pdf: %.dtx
	pdflatex "$<"
	makeindex -s gglo.ist -o doclicense.gls doclicense.glo
	makeindex -s gind doclicense
	pdflatex "$<"
	pdflatex "$<"
