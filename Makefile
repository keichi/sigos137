MARKDOWNS=$(wildcard ./src/*.md)
MAIN=src/main.tex
SOURCES=$(MARKDOWNS:.md=.tex)
IMAGES=$(wildcard ./img/*.png) $(wildcard ./img/*.pdf)
REFERENCES=references.bib
STYLES=ipsj.cls ipsjsort.bst ipsjtech.sty

.SUFFIXES: .tex .pdf .md .png
.PHONY: all clean open watch lint

all: main.pdf

.md.tex:
	pandoc --wrap=preserve --listings -S -o $@ $<
	sed -i -e "s/\\\\\\$$/\\$$/g" $@

main.pdf: $(MAIN) $(SOURCES) $(IMAGES) $(REFERENCES) $(STYLES)
	latexmk $(MAIN)

clean:
	latexmk -C $(MAIN)
	-rm $(SOURCES)

open: main.pdf
	latexmk -pv $(MAIN)

watch: main.pdf
	latexmk -pvc $(MAIN)

lint: $(SOURCES)
	redpen -l 2 -c redpen.xml -f latex $(SOURCES)

