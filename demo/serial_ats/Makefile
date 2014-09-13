MCU            = atmega2560
F_CPU          = 16000000UL
USB            = ttyACM0
#USB           = cu.usbmodem1411 # For Mac OS X
BAUD_RATE      = 115200
LOADERFLAGS    = -c stk500v2 -p $(MCU) -b $(BAUD_RATE) -P /dev/$(USB)

COBJ           = hardware_serial.o wiring_digital.o

include ../Makefile.common
