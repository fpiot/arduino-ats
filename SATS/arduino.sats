%{^
#include <avr/io.h>
#include <util/delay.h>
#include "Arduino.h"
%}

#define LOW 0x0
#define HIGH 0x1

#define INPUT 0x0
#define OUTPUT 0x1

#define LSBFIRST 0
#define MSBFIRST 1

typedef pin_t = natLt(256)

macdef LED_BUILTIN = $extval(pin_t, "LED_BUILTIN")
macdef A0          = $extval(pin_t, "A0")

abst@ype ANALOG_REFERENCE = $extype"uint8_t"
macdef DEFAULT = $extval(ANALOG_REFERENCE, "DEFAULT")
macdef INTERNAL = $extval(ANALOG_REFERENCE, "INTERNAL")
macdef EXTERNAL = $extval(ANALOG_REFERENCE, "EXTERNAL")

fun init (): void = "mac#"
fun pinMode (pin: pin_t, mode: natLt(2)): void = "mac#"
fun digitalWrite (pin: pin_t, value: natLt(2)): void = "mac#"
fun digitalRead (pin: pin_t): natLt(2) = "mac#"
fun analogReference (atype: ANALOG_REFERENCE): void = "mac#"
fun analogRead (pin: pin_t): natLt(1024) = "mac#"
fun analogWrite (pin: pin_t, value: natLt(256)): void = "mac#"
fun millis (): ulint = "mac#"
fun micros (): ulint = "mac#"
fun delay(ms: ulint): void = "mac#"
fun delayMicroseconds(us: uint): void = "mac#"
fun delay_ms (ms: double): void = "mac#_delay_ms"
fun delay_us (us: double): void = "mac#_delay_us"
fun interrupts (): void = "mac#"
fun nointerrupts (): void = "mac#"

fun random_int_1 (int): int = "mac#random"
fun random_lint_1 (lint): lint = "mac#random"
fun random_int_2 (int, int): int = "mac#random"
fun random_lint_2 (lint, lint): lint = "mac#random"
symintr random
overload random with random_int_1
overload random with random_lint_1
overload random with random_int_2
overload random with random_lint_2

fun randomSeed_int (seed: int): void = "mac#randomSeed"
fun randomSeed_uint (seed: uint): void = "mac#randomSeed"
symintr randomSeed
overload randomSeed with randomSeed_int
overload randomSeed with randomSeed_uint

fun main (): void (* Entry point for application *)
