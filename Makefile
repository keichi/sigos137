MARKDOWNS=$(wildcard ./src/*.md)
TMP_MARKDOWNS=$(MARKDOWNS:.md=.tmd)
MAIN=src/main.tex
SOURCES=$(MARKDOWNS:.md=.tex)
IMAGES=$(wildcard ./img/*.png) $(wildcard ./img/*.pdf)
REFERENCES=references.bib
STYLES=ipsj.cls ipsjsort.bst ipsjtech.sty

.SUFFIXES: .tex .pdf .md .png .tmd
.PHONY: all clean open watch lint

all: main.pdf

.md.tex:
	pandoc --wrap=preserve --listings -S -o $@ $<
	sed -i -e "s/\\\\\\$$/\\$$/g" $@

main.pdf: $(MAIN) $(SOURCES) $(IMAGES) $(REFERENCES) $(STYLES)
	latexmk $(MAIN)

clean:
	latexmk -C $(MAIN)
	-rm $(TMP_MARKDOWNS)
	-rm $(SOURCES)

open: main.pdf
	latexmk -pv $(MAIN)

watch: main.pdf
	latexmk -pvc $(MAIN)

.md.tmd:
	sed -e "s/\\\\[a-z]*\\({.*}\\)\\{0,1\\}//g" $< > $@

lint: $(TMP_MARKDOWNS)
	redpen -l 2 -c redpen.xml -f markdown $(TMP_MARKDOWNS)

