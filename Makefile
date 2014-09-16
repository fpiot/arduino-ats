SUBDIRS := $(wildcard demo/*/)

all clean:
	@for i in $(SUBDIRS); do \
		$(MAKE) -C $$i $@; \
	done

.PHONY: all clean
