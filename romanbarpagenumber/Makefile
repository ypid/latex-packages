
build: romanbarpagenumber.sty romanbarpagenumber.pdf

clean:
	rm -rf *.sty *.pdf *.aux *.out

%.sty: %.ins %.dtx
	pdflatex "$<"

%.pdf: %.dtx
	pdflatex "$<"
	makeindex -s gglo.ist -o romanbarpagenumber.gls romanbarpagenumber.glo
	makeindex -s gind romanbarpagenumber
	pdflatex "$<"
	thumbpdf romanbarpagenumber
	pdflatex "$<"
