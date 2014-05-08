PRG            = main
OBJ            = main.o
MCU_TARGET     = atmega2560
OPTIMIZE       = -Os
MCU            = atmega2560
F_CPU          = 16000000UL
USB            = ttyACM0
BAUD_RATE      = 115200
LOADER         = avrdude
LOADERFLAGS    = -c stk500v2 -p $(MCU) -b $(BAUD_RATE) -P /dev/$(USB)

DEFS           =
LIBS           =

# You should not have to change anything below here.

CC             = avr-gcc
ATS            = patsopt
#PATSHOME       = /usr/local/lib/ats2-postiats-0.0.8
ATSCFLAGS      = -std=c99 -D_XOPEN_SOURCE -Wno-unused-label -Wno-unused-but-set-variable -Wno-implicit-function-declaration -I. -I${PATSHOME} -I${PATSHOME}/ccomp/runtime

# Override is only needed by avr-lib build system.

override CFLAGS        = -g -Wall $(OPTIMIZE) -mmcu=$(MCU_TARGET) -DF_CPU=$(F_CPU) $(DEFS) $(ATSCFLAGS)
override LDFLAGS       = -Wl,-Map,$(PRG).map

OBJCOPY        = avr-objcopy
OBJDUMP        = avr-objdump

all: $(PRG).elf lst text eeprom

$(PRG).elf: $(OBJ)
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LIBS)

# dependency:
main.o: main.c pats_ccomp_typedefs.h

main.c: main.dats
	$(ATS) -o $@ -d main.dats

pats_ccomp_typedefs.h:
	sed -e 's/_\[0XFFFF\]/_\[0X00FF\]/g' ${PATSHOME}/ccomp/runtime/$@ > $@

clean:
	rm -rf *.o $(PRG).elf *.eps *.png *.pdf *.bak 
	rm -rf *.lst *.map main.c pats_ccomp_typedefs.h $(EXTRA_CLEAN_FILES)

lst:  $(PRG).lst

%.lst: %.elf
	$(OBJDUMP) -h -S $< > $@

# Rules for building the .text rom images

text: hex bin srec

hex:  $(PRG).hex
bin:  $(PRG).bin
srec: $(PRG).srec

%.hex: %.elf
	$(OBJCOPY) -j .text -j .data -O ihex $< $@

%.srec: %.elf
	$(OBJCOPY) -j .text -j .data -O srec $< $@

%.bin: %.elf
	$(OBJCOPY) -j .text -j .data -O binary $< $@

# Rules for building the .eeprom rom images

eeprom: ehex ebin esrec

ehex:  $(PRG)_eeprom.hex
ebin:  $(PRG)_eeprom.bin
esrec: $(PRG)_eeprom.srec

%_eeprom.hex: %.elf
	$(OBJCOPY) -j .eeprom --change-section-lma .eeprom=0 -O ihex $< $@ \
	|| { echo empty $@ not generated; exit 0; }

%_eeprom.srec: %.elf
	$(OBJCOPY) -j .eeprom --change-section-lma .eeprom=0 -O srec $< $@ \
	|| { echo empty $@ not generated; exit 0; }

%_eeprom.bin: %.elf
	$(OBJCOPY) -j .eeprom --change-section-lma .eeprom=0 -O binary $< $@ \
	|| { echo empty $@ not generated; exit 0; }

# Every thing below here is used by avr-libc's build system and can be ignored
# by the casual user.

EXTRA_CLEAN_FILES       = *.hex *.bin *.srec

write: $(PRG).hex
	$(LOADER) $(LOADERFLAGS) -U flash:w:$<
