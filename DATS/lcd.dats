(*
 * For LinkSprite 16X2 LCD Keypad Shield for Arduino
 * http://store.linksprite.com/linksprite-16x2-lcd-keypad-shield-for-arduino-version-b/
 * http://www.linksprite.com/wiki/index.php5?title=16_X_2_LCD_Keypad_Shield_for_Arduino
 *)
#define ATS_DYNLOADFLAG 0 // no dynloading at run-time
#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"
#include "config.hats"

staload "{$TOP}/SATS/arduino.sats"
staload "{$TOP}/SATS/lcd.sats"
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
LCD_takeout_struct (* xxx Should lock *)
(
  tcp: !LCD >> LCD_minus_struct l
) : #[l:addr] (LCD_struct @ l | ptr l)
extern praxi
LCD_addback_struct (* xxx Should unlock *)
  {l:addr}
(
  pfat: LCD_struct @ l
| tcp: !LCD_minus_struct l >> LCD
) : void

(* Low level functions *)
extern fun lcd_display: {l:addr} (!LCD_struct @ l | ptr l) -> void
extern fun lcd_command: {l:addr} (!LCD_struct @ l | ptr l, uint8) -> void
extern fun lcd_send: {l:addr} (!LCD_struct @ l | ptr l, uint8, HIGHLOW) -> void
extern fun lcd_pulseEnable: {l:addr} (!LCD_struct @ l | ptr l) -> void
extern fun lcd_write4bits: {l:addr} (!LCD_struct @ l | ptr l, uint8) -> void
extern fun lcd_write: (!LCD, uint8) -> void

local
  var _global_lcd_struct: LCD_struct
in
  implement lcd_open (rs, rw, enable, d0, d1, d2, d3) = let
    val lcd = $UN.castvwtp0 (addr@_global_lcd_struct)
    val (pfat | p) = LCD_takeout_struct (lcd)
    val () = p->rs_pin     := $UN.cast rs
    val () = p->rw_pin     := $UN.cast rw
    val () = p->enable_pin := $UN.cast enable
    val () = p->data_pins.0 := $UN.cast d0
    val () = p->data_pins.1 := $UN.cast d1
    val () = p->data_pins.2 := $UN.cast d2
    val () = p->data_pins.3 := $UN.cast d3
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
      // this is according to the hitachi HD44780 datasheet / figure 24, pg 46
      // we start in 8bit mode, try to set 4 bit mode
      val () = lcd_write4bits (pfat | p, $UN.cast 0x03)
      val () = _delay_us 4500.0
      val () = lcd_write4bits (pfat | p, $UN.cast 0x03) // second try
      val () = _delay_us 4500.0
      val () = lcd_write4bits (pfat | p, $UN.cast 0x03) // third go!
      val () = _delay_us 150.0
      val () = lcd_write4bits (pfat | p, $UN.cast 0x02) // finally, set to 4-bit interface
      // finally, set # lines, font size, etc.
      val LCD_FUNCTIONSET = $UN.cast 0x20
      val () = lcd_command (pfat | p, uint8_bit_or (LCD_FUNCTIONSET, displayfunction))
      // turn the display on with no cursor or blinking default
      val LCD_DISPLAYON = $UN.cast 0x04
      val LCD_CURSOROFF = $UN.cast 0x00
      val LCD_BLINKOFF  = $UN.cast 0x00
      val () = p->displaycontrol := uint8_bit_or (LCD_DISPLAYON, uint8_bit_or (LCD_CURSOROFF, LCD_BLINKOFF))
      val () = lcd_display (pfat | p)
      // Initialize to default text direction (for romance languages)
      val LCD_ENTRYLEFT           = $UN.cast 0x02
      val LCD_ENTRYSHIFTDECREMENT = $UN.cast 0x00
      val () = p->displaymode := uint8_bit_or (LCD_ENTRYLEFT, LCD_ENTRYSHIFTDECREMENT)
      val displaymode = p->displaymode
      // set the entry mode
      val LCD_ENTRYMODESET = $UN.cast 0x04
      val () = lcd_command (pfat | p, uint8_bit_or (LCD_ENTRYMODESET, displaymode))
      prval () = LCD_addback_struct(pfat | lcd)
      // clear it off
      val () = lcd_clear lcd
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
  val (pfat | p) = LCD_takeout_struct (lcd)
  val () = lcd_command (pfat | p, LCD_CLEARDISPLAY) // clear display, set cursor position to zero
  prval () = LCD_addback_struct(pfat | lcd)
  val () = _delay_us 2000.0 // this command takes a long time!
}

implement lcd_setCursor (lcd, col, row) = {
  val LCD_SETDDRAMADDR = $UN.cast 0x80
  val row_ofs = if row > 0 then 0x40 else 0x00:int
  val v = (col:int) + (row_ofs:int)
  val (pfat | p) = LCD_takeout_struct (lcd)
  val () = lcd_command(pfat | p,  uint8_bit_or (LCD_SETDDRAMADDR, $UN.cast v))
  prval () = LCD_addback_struct(pfat | lcd)
}

implement lcd_print (lcd, str, start, len) = {
  fun w (lcd: !LCD, p: ptr): void = {
    val c = $UN.ptr0_get<uint8> (p)
    val () = lcd_write (lcd, c)
  }
  fun loop (lcd: !LCD, p: ptr, r: int): void = {
    val () = if r > 0 then (w (lcd, p); loop (lcd, ptr_succ<char> (p), r - 1))
  }
  val p0 = string2ptr (str)
  val p0 = ptr_add<char> (p0, start)
  val () = loop (lcd, p0, len)
}

implement lcd_write (lcd, value) = {
  val (pfat | p) = LCD_takeout_struct (lcd)
  val () = lcd_send (pfat | p, value, HIGH)
  prval () = LCD_addback_struct(pfat | lcd)
}

implement lcd_display (pfat | p) = {
  val LCD_DISPLAYON = $UN.cast 0x04
  val () = p->displaycontrol := LCD_DISPLAYON
  val displaycontrol = p->displaycontrol
  val LCD_DISPLAYCONTROL = $UN.cast 0x08
  val () = lcd_command (pfat | p, uint8_bit_or (LCD_DISPLAYCONTROL, displaycontrol))
}

implement lcd_command (pfat | p, value) = {
  val () = lcd_send (pfat | p, value, LOW)
}

implement lcd_send (pfat | p, value, mode) = {
  val () = digitalWrite (p->rs_pin, mode)
  val () = digitalWrite (p->rw_pin, LOW)
  val () = lcd_write4bits (pfat | p, value >> 4)
  val () = lcd_write4bits (pfat | p, value)
}

implement lcd_pulseEnable (pfat | p) = {
  val () = digitalWrite (p->enable_pin, LOW)
  val () = _delay_us 1.0
  val () = digitalWrite (p->enable_pin, HIGH)
  val () = _delay_us 1.0 // enable pulse must be >450ns
  val () = digitalWrite (p->enable_pin, LOW)
  val () = _delay_us 100.0 // commands need > 37us to settle
}

implement lcd_write4bits (pfat | p, value) = {
  fun uint8_to_highlow (v: uint8): HIGHLOW = $UN.cast (uint8_bit_and (v, $UN.cast 0x01))
  val () = pinMode (p->data_pins.0, OUTPUT)
  val () = digitalWrite (p->data_pins.0, uint8_to_highlow (value >> 0))
  val () = pinMode (p->data_pins.1, OUTPUT)
  val () = digitalWrite (p->data_pins.1, uint8_to_highlow (value >> 1))
  val () = pinMode (p->data_pins.2, OUTPUT)
  val () = digitalWrite (p->data_pins.2, uint8_to_highlow (value >> 2))
  val () = pinMode (p->data_pins.3, OUTPUT)
  val () = digitalWrite (p->data_pins.3, uint8_to_highlow (value >> 3))
  val () = lcd_pulseEnable (pfat | p)
}
