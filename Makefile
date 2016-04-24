PANDOC=pandoc
BB=ebb
MARKDOWNS=$(wildcard ./src/*.md)
MAIN=src/main.tex
SOURCES=$(MARKDOWNS:.md=.tex)
IMAGES=$(wildcard ./img/*.png) $(wildcard ./img/*.pdf)
IMAGE_BBS=$(addsuffix .bb, $(basename $(IMAGES)))
REFERENCES=references.bib
STYLES=
RM=rm

.SUFFIXES: .tex .pdf .md .bb .png
.PHONY: all clean semiclean open watch

all: main.pdf

.png.bb:
	$(BB) $<

.pdf.bb:
	$(BB) $<

.md.tex:
	$(PANDOC) --listings -S -o $@ $<
	sed -i -e "s/\\\\\\$$/\\$$/g" $@

main.pdf: $(MAIN) $(SOURCES) $(IMAGES) $(IMAGE_BBS) $(REFERENCES) $(STYLES)
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

