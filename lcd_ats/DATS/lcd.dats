#define ATS_DYNLOADFLAG 0 // no dynloading at run-time
staload "SATS/lcd.sats"
staload UN = "prelude/SATS/unsafe.sats"

(* Private struct *)
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

(* High level functions *)
local
  var _global_lcd_struct: LCD_struct
in
  implement lcd_open () = let
    val lcd_noinit = $UN.castvwtp0 (addr@_global_lcd_struct)
    // xxx
  in
    lcd_noinit
  end
end

implement lcd_close (lcd) = {
  val () = $UN.castvwtp0(lcd) (* Consume lcd *)
}

(* Low level functions *)
implement lcd_write4bits (lcd, value) = {
  val (pfat | p) = LCD_takeout_struct (lcd)
  // xxx
  prval () = LCD_addback_struct(pfat | lcd)
}
