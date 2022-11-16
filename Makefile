DESTDIR=
PREFIX =/usr/local
FILES  =fnames.idx locdata.idx street.idx lnames.idx mnames.idx
all: $(FILES)
install:
	mkdir -p $(DESTDIR)$(PREFIX)/share/rig/spain
	cp $(FILES) $(DESTDIR)$(PREFIX)/share/rig/spain
## -- license --
install: install-license
install-license: LICENSE
	@echo 'I share/doc/rig-spain/LICENSE'
	@mkdir -p $(DESTDIR)$(PREFIX)/share/doc/rig-spain
	@cp LICENSE $(DESTDIR)$(PREFIX)/share/doc/rig-spain
## -- license --
