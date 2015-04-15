%{^
#include <avr/io.h>
#include <util/delay.h>
#include "Arduino.h"
%}

abst@ype HIGHLOW = $extype"int"
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

fun init (): void = "mac#"
fun pinMode (pin: uint8, mode: INOUT): void = "mac#"
fun digitalWrite (pin: uint8, value: HIGHLOW): void = "mac#"
fun digitalRead (pin: uint8): HIGHLOW = "mac#"
fun analogReference (atype: ANALOG_REFERENCE): void = "mac#"
fun analogRead (pin: uint8): [n:nat | n <= 1023] int n = "mac#"
fun analogWrite {n:nat | n <= 255} (pin: uint8, value: int n): void = "mac#"
fun delay_ms (ms: double): void = "mac#_delay_ms"
fun delay_us (us: double): void = "mac#_delay_us"
fun interrupts (): void = "mac#"
fun nointerrupts (): void = "mac#"

fun main (): void (* Entry point for application *)
