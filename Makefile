PANDOC=pandoc
MARKDOWNS=$(wildcard ./src/*.md)
MAIN=src/main.tex
SOURCES=$(MARKDOWNS:.md=.tex)
IMAGES=$(wildcard ./img/*.png) $(wildcard ./img/*.pdf)
REFERENCES=references.bib
STYLES=
RM=rm

.SUFFIXES: .tex .pdf .md .bb .png
.PHONY: all clean semiclean open watch lint

all: main.pdf

.md.tex:
	$(PANDOC) --wrap=preserve --listings -S -o $@ $<
	sed -i -e "s/\\\\\\$$/\\$$/g" $@

main.pdf: $(MAIN) $(SOURCES) $(IMAGES) $(REFERENCES) $(STYLES)
	latexmk $(MAIN)

semiclean:
	latexmk -c $(MAIN)
	-$(RM) ./img/*.bb
	-$(RM) $(SOURCES)

clean:
	latexmk -C $(MAIN)
	-$(RM) $(SOURCES)

open: main.pdf
	latexmk -pv $(MAIN)

watch: main.pdf
	latexmk -pvc $(MAIN)

lint: $(SOURCES)
	redpen -c redpen.xml -f latex $(SOURCES)

