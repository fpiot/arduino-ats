#ifndef PINS_ARDUINO_H_TOP
#define PINS_ARDUINO_H_TOP

#if defined(__AVR_ATmega2560__) // Arduino Mega 2560
#include "variants/mega/pins_arduino.h"
#else // Arduino Uno
#include "variants/standard/pins_arduino.h"
#endif

#endif
