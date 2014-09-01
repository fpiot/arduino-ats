staload "SATS/arduino.sats"

absvtype LCD = ptr

(* High level functions *)
fun lcd_open (rs: uint8, rw: uint8, enable: uint8, d0: uint8, d1: uint8, d2: uint8, d3: uint8): LCD
fun lcd_close: (LCD) -> void
fun lcd_clear: (!LCD) -> void
fun lcd_setCursor (lcd: !LCD, col: uint8, row: int): void
fun lcd_print {n:int}{i:nat | i < n}
              (lcd: !LCD, str: string (n), start: size_t (i), len: int): void
fun lcd_write: (!LCD, uint8) -> void

(* Low level functions *)
fun lcd_display: (!LCD) -> void
fun lcd_command: (!LCD, uint8) -> void
fun lcd_send: (!LCD, uint8, HIGHLOW) -> void
fun lcd_pulseEnable: (!LCD) -> void
fun lcd_write4bits: (!LCD, uint8) -> void
