DESTDIR=
PREFIX =/usr/local
FILES  =fnames.idx locdata.idx street.idx lnames.idx mnames.idx
all: $(FILES)
install:
	mkdir -p $(DESTDIR)$(PREFIX)/share/rig/spain
	cp $(FILES) $(DESTDIR)$(PREFIX)/share/rig/spain
