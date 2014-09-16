staload "SATS/arduino.sats"

absvtype LCD = ptr

fun lcd_open (rs: uint8, rw: uint8, enable: uint8, d0: uint8, d1: uint8, d2: uint8, d3: uint8): LCD
fun lcd_close: (LCD) -> void
fun lcd_clear: (!LCD) -> void
fun lcd_setCursor (lcd: !LCD, col: uint8, row: int): void
fun lcd_print {n:int}{i:nat | i < n}
              (lcd: !LCD, str: string (n), start: size_t (i), len: int): void
fun lcd_write: (!LCD, uint8) -> void
