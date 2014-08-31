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

fun pinMode:      (uchar, INOUT)   -> void    = "mac#"
fun digitalWrite: (uchar, HIGHLOW) -> void    = "mac#"
fun digitalRead:  (uchar)          -> HIGHLOW = "mac#"
fun _delay_ms:    (double)         -> void    = "mac#"
fun interrupts:   ()               -> void    = "mac#"
fun nointerrupts: ()               -> void    = "mac#"
