BUILD_TARGETS = symlink-filter symlink-filter.so

CC = gcc
CFLAGS = -O2 -Wall -fPIC
LDSHARED = $(CC) -shared
LDFLAGS =

prefix = /usr/local
exec_prefix = $(prefix)
bindir = $(exec_prefix)/bin
libdir = $(exec_prefix)/lib

default: build

clean:
	rm -f $(BUILD_TARGETS)
	rm -f *.o *.so *.tmp

install:
	mkdir -m 0755 -p $(DESTDIR)$(bindir)
	rm -f $(DESTDIR)$(bindir)/symlink-filter
	cp symlink-filter $(DESTDIR)$(bindir)/
	mkdir -m 0755 -p $(DESTDIR)$(libdir)
	rm -f $(DESTDIR)$(libdir)/symlink-filter.so
	cp symlink-filter.so $(DESTDIR)$(libdir)/

build: $(BUILD_TARGETS)

symlink-filter: symlink-filter.sh
	sed 's#@libdir@#$(libdir)#g' symlink-filter.sh >$@.tmp
	chmod +x $@.tmp
	mv $@.tmp $@

symlink-filter.so: symlink-filter.o
	$(LDSHARED) $(LDFLAGS) -o $@ symlink-filter.o

