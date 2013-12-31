#
# Makefile for a single page static website from reStructuredText sources
# 
# Author: Rafael Goncalves Martins
# License: BSD (http://www.opensource.org/licenses/bsd-license.php)
#

RST2HTML = rst2html.py
GITHUB_PAGES_PUBLISH = github-pages-publish

.PHONY: all
all: build/index.html

build/%.html: %.rst static/html4css1.css static/style.css
	mkdir -p build
	$(RST2HTML) --cloak-email-addresses \
		--embed-stylesheet --initial-header-level=2 \
		--stylesheet-path=static/html4css1.css,static/style.css \
		--language=pt_br $< $@

.PHONY: clean
clean:
	$(RM) -rv build/

.PHONY: publish
publish: all
	$(GITHUB_PAGES_PUBLISH) --verbose \
		--cname rafaelmartins.com \
		--message 'Updated webpage' \
		. build
