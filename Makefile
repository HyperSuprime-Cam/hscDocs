#
#

IN=description
OUT=pipeline_outputs

pdf: $(OUT).pdf
$(OUT).pdf: $(IN).pdf
	cp $< $@

# The '-' sign is probably needed here.  It means "continue with non-zero exit"
# Latex rarely runs clean, but is probably fine (hboxes and such), and we want
# to make sure we continue and build the html
%.pdf: $(IN).tex
	-latexmk -pdf -pdflatex="pdflatex  -interaction nonstopmode" -use-make $(IN)

# use 'all' and 'html' as alias target names
all: $(OUT).html
html: $(OUT).html
$(OUT).html: $(OUT).pdf
	pdf2htmlEX $<

.PHONY: clean

clean:
	latexmk -CA
	$(RM) pipeline_outputs.pdf pipeline_outputs.html
