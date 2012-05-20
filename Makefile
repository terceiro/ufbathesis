VERSION = 1.0
TARBALL = ufbathesis-$(VERSION).tar.gz
UPLOAD_TO = app.dcc.ufba.br:~/public_html/ufbathesis/

all: test

test: ufbathesis.cls template.tex
	latex template.tex
	pdflatex template.tex

dist: $(TARBALL)

$(TARBALL): ufbathesis.cls ufba.eps ufba.pdf
	tar czf $(TARBALL) $^

index.html: README.md
	pandoc -s -f markdown -t html $< > $@

upload: $(TARBALL) index.html template.tex
	scp index.html $^ $(UPLOAD_TO)

clean:
	$(RM) $(TARBALL)
	$(RM) template.aux template.dvi template.lof template.log template.lot template.pdf template.toc
	$(RM) index.html
