staload "SATS/arduino.sats"

absvtype LCD = ptr

(* High level functions *)

(* Low level functions *)
fun lcd_write4bits: (!LCD, uint8) -> void
