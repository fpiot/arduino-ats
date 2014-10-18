#include "config.hats"
staload "{$TOP}/SATS/arduino.sats"

absvtype lcd_t = ptr

fun lcd_open (rs: int, rw: int, enable: int, d0: int, d1: int, d2: int, d3: int): lcd_t
fun lcd_close (lcd: lcd_t): void
fun lcd_clear (lcd: !lcd_t): void
fun lcd_setCursor (lcd: !lcd_t, col: int, row: int): void
fun lcd_print {n:int}{i:nat | i < n}{j:nat | i + j <= n}
              (lcd: !lcd_t, str: string (n), start: size_t (i), len: size_t (j)): void
