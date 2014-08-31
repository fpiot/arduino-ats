#define ATS_DYNLOADFLAG 0 // no dynloading at run-time
staload "SATS/lcd.sats"
staload UN = "prelude/SATS/unsafe.sats"

vtypedef LCD_struct = @{
  rs_pin          = uint8 // LOW: command.  HIGH: character.
, rw_pin          = uint8 // LOW: write to LCD.  HIGH: read from LCD.
, enable_pin      = uint8 // activated by a HIGH pulse.
, data_pins       = @(uint8, uint8, uint8, uint8, uint8, uint8, uint8, uint8)
, displayfunction = uint8
, displaycontrol  = uint8
, displaymode     = uint8
, numlines        = uint8
, currline        = uint8
}
absvtype LCD_minus_struct (l:addr)
extern castfn
LCD_takeout_struct
(
  tcp: !LCD >> LCD_minus_struct l
) : #[l:addr] (LCD_struct @ l | ptr l)
extern praxi
LCD_addback_struct
  {l:addr}
(
  pfat: LCD_struct @ l
| tcp: !LCD_minus_struct l >> LCD
) : void

implement lcd_write4bits (lcd, value) = {
  val (pfat | p) = LCD_takeout_struct (lcd)
  // xxx
  prval () = LCD_addback_struct(pfat | lcd)
}
