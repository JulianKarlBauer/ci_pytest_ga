
.PHONY: build
.PHONY: build_summary


build:
	pandoc \
	-t beamer \
	--pdf-engine=xelatex \
	--highlight-style=kate \
	slides.md \
	-o \
	slides.pdf \


build_summary:
	pandoc \
	-t beamer \
	--pdf-engine=xelatex \
	--highlight-style=kate \
	summary.md \
	-o \
	summary.pdf \