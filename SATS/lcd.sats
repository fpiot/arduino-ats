#include "config.hats"
staload "{$TOP}/SATS/arduino.sats"

absvtype LCD = ptr

fun lcd_open (rs: int, rw: int, enable: int, d0: int, d1: int, d2: int, d3: int): LCD
fun lcd_close: (LCD) -> void
fun lcd_clear: (!LCD) -> void
fun lcd_setCursor (lcd: !LCD, col: int, row: int): void
fun lcd_print {n:int}{i:nat | i < n}
              (lcd: !LCD, str: string (n), start: size_t (i), len: size_t): void
