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
macdef A0          = $extval(uint8, "A0")

abst@ype ANALOG_REFERENCE = $extype"uint8_t"
macdef DEFAULT = $extval(ANALOG_REFERENCE, "DEFAULT")
macdef INTERNAL = $extval(ANALOG_REFERENCE, "INTERNAL")
macdef EXTERNAL = $extval(ANALOG_REFERENCE, "EXTERNAL")

fun pinMode:      (uint8, INOUT)   -> void    = "mac#"
fun digitalWrite: (uint8, HIGHLOW) -> void    = "mac#"
fun digitalRead:  (uint8)          -> HIGHLOW = "mac#"
fun analogReference: (ANALOG_REFERENCE) -> () = "mac#"
fun analogRead:   (uint8)          -> int     = "mac#"
fun analogWrite:  (uint8, int)     -> void    = "mac#"
fun delay_ms:     (double)         -> void    = "mac#_delay_ms"
fun delay_us:     (double)         -> void    = "mac#_delay_us"
fun interrupts:   ()               -> void    = "mac#"
fun nointerrupts: ()               -> void    = "mac#"
