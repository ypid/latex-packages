
build: doclicense.sty doclicense.pdf

clean:
	rm -rf *.sty *.pdf *.aux *.out

%.sty: %.ins %.dtx
	pdflatex "$<"

%.pdf: %.dtx
	pdflatex "$<"
	makeindex -s gglo.ist -o doclicense.gls doclicense.glo
	makeindex -s gind doclicense
	pdflatex "$<"
	thumbpdf doclicense
	pdflatex "$<"
