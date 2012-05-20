VERSION = 1.0
TARBALL = ufbathesis-$(VERSION).tar.gz
UPLOAD_TO = app.dcc.ufba.br:~/public_html/ufbathesis/

all: test

test: ufbathesis.cls template.dvi template.pdf template-full.dvi template-full.pdf

%.dvi: %.tex
	latex $<

%.pdf: %.tex
	pdflatex $<

dist: $(TARBALL)

$(TARBALL): ufbathesis.cls ufba.eps ufba.pdf
	tar czf $(TARBALL) $^

index.html: README.md
	(pandoc -s -f markdown -t html $< | sed -e 's/##VERSION##/$(VERSION)/g' > $@) || ($(RM) $@; false)

upload: $(TARBALL) index.html template.tex
	scp index.html $^ $(UPLOAD_TO)

clean:
	$(RM) $(TARBALL)
	$(RM) *.aux *.lof *.log *.lot *.toc template*.pdf template*.dvi
	$(RM) index.html
