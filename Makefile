SUBDIRS := blink blink_ats

all clean:
	@for i in $(SUBDIRS); do \
		$(MAKE) -C $$i $@; \
	done

.PHONY: all clean
