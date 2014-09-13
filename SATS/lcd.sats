%{#
#include "../../CATS/lcd.cats"
%}

absvtype LCD = ptr

fun{} lcd_get (): LCD
fun{} lcd_open (rs: int, rw: int, enable: int, d0: int, d1: int, d2: int, d3: int): LCD
fun   lcd_open_ (rs: int, rw: int, enable: int, d0: int, d1: int, d2: int, d3: int): LCD
fun{} lcd_close: (LCD) -> void
fun{} lcd_clear: (!LCD) -> void
fun{} lcd_setCursor (lcd: !LCD, col: uint8, row: int): void
fun{} lcd_print {n:int}{i:nat | i < n}
              (lcd: !LCD, str: string (n), start: size_t (i), len: int): void
fun{} lcd_write: (!LCD, uint8) -> void

(* Private struct *)
vtypedef LCD_struct = @{
  rs_pin          = uint8 // LOW: command.  HIGH: character.
, rw_pin          = uint8 // LOW: write to LCD.  HIGH: read from LCD.
, enable_pin      = uint8 // activated by a HIGH pulse.
, data_pins       = @(uint8, uint8, uint8, uint8)
, displayfunction = uint8
, displaycontrol  = uint8
, displaymode     = uint8
, numlines        = uint8
, currline        = uint8
}
