staload "SATS/arduino.sats"

absvtype LCD = ptr

(* High level functions *)
fun lcd_open: () -> LCD
fun lcd_close: (LCD) -> void

(* Low level functions *)
fun lcd_write4bits: (!LCD, uint8) -> void
