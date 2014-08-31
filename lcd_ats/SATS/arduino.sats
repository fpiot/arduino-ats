%{^
#include <avr/io.h>
#include <util/delay.h>
#include "Arduino.h"
%}

abst@ype HIGHLOW = $extype"uint8_t"
macdef   HIGH    = $extval(HIGHLOW, "HIGH")
macdef   LOW     = $extval(HIGHLOW, "LOW")

abst@ype INOUT  = $extype"uint8_t"
macdef   INPUT  = $extval(INOUT, "INPUT")
macdef   OUTPUT = $extval(INOUT, "OUTPUT")

macdef LED_BUILTIN = $extval(uint8, "LED_BUILTIN")

fun pinMode:      (uint8, INOUT)   -> void    = "mac#"
fun digitalWrite: (uint8, HIGHLOW) -> void    = "mac#"
fun digitalRead:  (uint8)          -> HIGHLOW = "mac#"
fun _delay_ms:    (double)         -> void    = "mac#"
fun _delay_us:    (double)         -> void    = "mac#"
fun interrupts:   ()               -> void    = "mac#"
fun nointerrupts: ()               -> void    = "mac#"
