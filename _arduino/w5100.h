/*
 * Copyright (c) 2010 by Cristian Maglie <c.maglie@bug.st>
 *
 * This file is free software; you can redistribute it and/or modify
 * it under the terms of either the GNU General Public License version 2
 * or the GNU Lesser General Public License version 2.1, both as
 * published by the Free Software Foundation.
 */

#ifndef	W5100_H_INCLUDED
#define	W5100_H_INCLUDED

#include <avr/pgmspace.h>

#if defined(__AVR_ATmega1280__) || defined(__AVR_ATmega2560__)
inline static void initSS()    { DDRB  |=  _BV(4); };
inline static void setSS()     { PORTB &= ~_BV(4); };
inline static void resetSS()   { PORTB |=  _BV(4); };
#elif defined(__AVR_ATmega32U4__)
inline static void initSS()    { DDRB  |=  _BV(6); };
inline static void setSS()     { PORTB &= ~_BV(6); };
inline static void resetSS()   { PORTB |=  _BV(6); };
#elif defined(__AVR_AT90USB1286__) || defined(__AVR_AT90USB646__) || defined(__AVR_AT90USB162__)
inline static void initSS()    { DDRB  |=  _BV(0); };
inline static void setSS()     { PORTB &= ~_BV(0); };
inline static void resetSS()   { PORTB |=  _BV(0); };
#else
inline static void initSS()    { DDRB  |=  _BV(2); };
inline static void setSS()     { PORTB &= ~_BV(2); };
inline static void resetSS()   { PORTB |=  _BV(2); };
#endif

#endif
