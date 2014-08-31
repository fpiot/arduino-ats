#define ATS_DYNLOADFLAG 0 // no dynloading at run-time
#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"
staload "SATS/arduino.sats"
staload "SATS/lcd.sats"
staload UN = "prelude/SATS/unsafe.sats"

%{
inline uint8_t atspre_uint8_bit_or(uint8_t a, uint8_t b) { return (a | b); }
inline uint8_t atspre_uint8_bit_and(uint8_t a, uint8_t b) { return (a & b); }
%}
extern fun uint8_bit_or: (uint8, uint8) -> uint8 = "mac#atspre_uint8_bit_or"
extern fun uint8_bit_and: (uint8, uint8) -> uint8 = "mac#atspre_uint8_bit_and"

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

local
  var _global_lcd_struct: LCD_struct
in
  implement lcd_open (rs, rw, enable, d0, d1, d2, d3) = let
    val lcd = $UN.castvwtp0 (addr@_global_lcd_struct)
    val (pfat | p) = LCD_takeout_struct (lcd)
    val () = p->rs_pin     := rs
    val () = p->rw_pin     := rw
    val () = p->enable_pin := enable
    val () = p->data_pins  := @(d0, d1, d2, d3)
    val () = pinMode (p->rs_pin, OUTPUT)
    val () = pinMode (p->rw_pin, OUTPUT)
    val () = pinMode (p->enable_pin, OUTPUT)
    val LCD_4BITMODE = $UN.cast 0x00
    val LCD_2LINE    = $UN.cast 0x08
    val LCD_5x8DOTS  = $UN.cast 0x00
    val () = p->displayfunction := uint8_bit_or (LCD_4BITMODE, uint8_bit_or (LCD_2LINE, LCD_5x8DOTS))
    prval () = LCD_addback_struct(pfat | lcd)
    fun lcd_begin (lcd: !LCD, lines: uint8): void = {
      val (pfat | p) = LCD_takeout_struct (lcd)
      val () = p->numlines := lines
      val () = p->currline := $UN.cast 0
      val () = _delay_us 50000.0
      val () = digitalWrite (p->rs_pin, LOW)
      val () = digitalWrite (p->enable_pin, LOW)
      val () = digitalWrite (p->rw_pin, LOW)
      val displayfunction = p->displayfunction
      prval () = LCD_addback_struct(pfat | lcd)
      // this is according to the hitachi HD44780 datasheet / figure 24, pg 46
      // we start in 8bit mode, try to set 4 bit mode
      val () = lcd_write4bits (lcd, $UN.cast 0x03)
      val () = _delay_us 4500.0
      val () = lcd_write4bits (lcd, $UN.cast 0x03) // second try
      val () = _delay_us 4500.0
      val () = lcd_write4bits (lcd, $UN.cast 0x03) // third go!
      val () = _delay_us 150.0
      val () = lcd_write4bits (lcd, $UN.cast 0x02) // finally, set to 4-bit interface
      // finally, set # lines, font size, etc.
      val LCD_FUNCTIONSET = $UN.cast 0x20
      val () = lcd_command (lcd, uint8_bit_or (LCD_FUNCTIONSET, displayfunction))
      // turn the display on with no cursor or blinking default
      val LCD_DISPLAYON = $UN.cast 0x04
      val LCD_CURSOROFF = $UN.cast 0x00
      val LCD_BLINKOFF  = $UN.cast 0x00
      val (pfat | p) = LCD_takeout_struct (lcd)
      val () = p->displaycontrol := uint8_bit_or (LCD_DISPLAYON, uint8_bit_or (LCD_CURSOROFF, LCD_BLINKOFF))
      prval () = LCD_addback_struct(pfat | lcd)
      val () = lcd_display lcd
      // clear it off
      val () = lcd_clear lcd
      // Initialize to default text direction (for romance languages)
      val LCD_ENTRYLEFT           = $UN.cast 0x02
      val LCD_ENTRYSHIFTDECREMENT = $UN.cast 0x00
      val (pfat | p) = LCD_takeout_struct (lcd)
      val () = p->displaymode := uint8_bit_or (LCD_ENTRYLEFT, LCD_ENTRYSHIFTDECREMENT)
      val displaymode = p->displaymode
      prval () = LCD_addback_struct(pfat | lcd)
      // set the entry mode
      val LCD_ENTRYMODESET = $UN.cast 0x04
      val () = lcd_command (lcd, uint8_bit_or (LCD_ENTRYMODESET, displaymode))
    }
    val () = lcd_begin (lcd, $UN.cast 2)
  in
    lcd
  end
end

implement lcd_close (lcd) = {
  val () = $UN.castvwtp0(lcd) (* Consume lcd *)
}

implement lcd_clear (lcd) = {
  val LCD_CLEARDISPLAY = $UN.cast 0x01
  val () = lcd_command (lcd, LCD_CLEARDISPLAY) // clear display, set cursor position to zero
  val () = _delay_us 2000.0 // this command takes a long time!
}

implement lcd_setCursor (lcd, col, row) = {
  val LCD_SETDDRAMADDR = $UN.cast 0x80
  val row_ofs = if row > 0 then 0x40 else 0x00
  val () = lcd_command(lcd,  uint8_bit_or (LCD_SETDDRAMADDR, col + $UN.cast row_ofs))
}

implement lcd_write (lcd, value) = {
  val () = lcd_send (lcd, value, HIGH)
}

implement lcd_display (lcd) = {
  val LCD_DISPLAYON = $UN.cast 0x04
  val (pfat | p) = LCD_takeout_struct (lcd)
  val () = p->displaycontrol := LCD_DISPLAYON
  val displaycontrol = p->displaycontrol
  prval () = LCD_addback_struct(pfat | lcd)
  val LCD_DISPLAYCONTROL = $UN.cast 0x08
  val () = lcd_command (lcd, uint8_bit_or (LCD_DISPLAYCONTROL, displaycontrol))
}

implement lcd_command (lcd, value) = {
  val () = lcd_send (lcd, value, LOW)
}

implement lcd_send (lcd, value, mode) = {
  val (pfat | p) = LCD_takeout_struct (lcd)
  val () = digitalWrite (p->rs_pin, mode)
  val () = digitalWrite (p->rw_pin, LOW)
  prval () = LCD_addback_struct(pfat | lcd)
  val () = lcd_write4bits (lcd, value >> 4)
  val () = lcd_write4bits (lcd, value)
}

implement lcd_pulseEnable (lcd) = {
  val (pfat | p) = LCD_takeout_struct (lcd)
  val () = digitalWrite (p->enable_pin, LOW)
  val () = _delay_us 1.0
  val () = digitalWrite (p->enable_pin, HIGH)
  val () = _delay_us 1.0 // enable pulse must be >450ns
  val () = digitalWrite (p->enable_pin, LOW)
  val () = _delay_us 100.0 // commands need > 37us to settle
  prval () = LCD_addback_struct(pfat | lcd)
}

implement lcd_write4bits (lcd, value) = {
  fun uint8_to_highlow (v: uint8): HIGHLOW = $UN.cast (uint8_bit_and (v, $UN.cast 0x01))
  val (pfat | p) = LCD_takeout_struct (lcd)
  val () = pinMode (p->data_pins.0, OUTPUT)
  val () = digitalWrite (p->data_pins.0, uint8_to_highlow (value >> 0))
  val () = pinMode (p->data_pins.1, OUTPUT)
  val () = digitalWrite (p->data_pins.1, uint8_to_highlow (value >> 1))
  val () = pinMode (p->data_pins.2, OUTPUT)
  val () = digitalWrite (p->data_pins.2, uint8_to_highlow (value >> 2))
  val () = pinMode (p->data_pins.3, OUTPUT)
  val () = digitalWrite (p->data_pins.3, uint8_to_highlow (value >> 3))
  prval () = LCD_addback_struct(pfat | lcd)
  val () = lcd_pulseEnable lcd
}
