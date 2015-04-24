(*
 * For LinkSprite 16X2 LCD Keypad Shield for Arduino
 * http://store.linksprite.com/linksprite-16x2-lcd-keypad-shield-for-arduino-version-b/
 * http://www.linksprite.com/wiki/index.php5?title=16_X_2_LCD_Keypad_Shield_for_Arduino
 *)
#include "config.hats"
#include "{$TOP}/avr_prelude/kernel_staload.hats"

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
vtypedef lcd_t_struct = @{
  rs_pin          = pin_t // LOW: command.  HIGH: character.
, rw_pin          = pin_t // LOW: write to lcd_t.  HIGH: read from lcd_t.
, enable_pin      = pin_t // activated by a HIGH pulse.
, data_pins       = @(pin_t, pin_t, pin_t, pin_t)
, displayfunction = uint8
, displaycontrol  = uint8
, displaymode     = uint8
, numlines        = uint8
, currline        = uint8
}
absvtype lcd_t_minus_struct (l:addr)
extern castfn
lcd_t_takeout_struct (* xxx Should lock *)
(
  tcp: !lcd_t >> lcd_t_minus_struct l
) : #[l:addr] (lcd_t_struct @ l | ptr l)
extern praxi
lcd_t_addback_struct (* xxx Should unlock *)
  {l:addr}
(
  pfat: lcd_t_struct @ l
| tcp: !lcd_t_minus_struct l >> lcd_t
) : void

(* Low level functions *)
extern fun lcd_display: {l:addr} (!lcd_t_struct @ l | ptr l) -> void
extern fun lcd_command: {l:addr} (!lcd_t_struct @ l | ptr l, uint8) -> void
extern fun lcd_send: {l:addr} (!lcd_t_struct @ l | ptr l, uint8, natLt(2)) -> void
extern fun lcd_pulseEnable: {l:addr} (!lcd_t_struct @ l | ptr l) -> void
extern fun lcd_write4bits: {l:addr} (!lcd_t_struct @ l | ptr l, uint8) -> void
extern fun lcd_write: (!lcd_t, uint8) -> void

local
  var _global_lcd_struct: lcd_t_struct
in
  implement lcd_open (rs, rw, enable, d0, d1, d2, d3) = let
    val lcd = $UN.castvwtp0 (addr@_global_lcd_struct)
    val (pfat | p) = lcd_t_takeout_struct (lcd)
    val () = p->rs_pin     := $UN.cast{pin_t}(rs)
    val () = p->rw_pin     := $UN.cast{pin_t}(rw)
    val () = p->enable_pin := $UN.cast{pin_t}(enable)
    val () = p->data_pins.0 := $UN.cast{pin_t}(d0)
    val () = p->data_pins.1 := $UN.cast{pin_t}(d1)
    val () = p->data_pins.2 := $UN.cast{pin_t}(d2)
    val () = p->data_pins.3 := $UN.cast{pin_t}(d3)
    val () = pinMode (p->rs_pin, OUTPUT)
    val () = pinMode (p->rw_pin, OUTPUT)
    val () = pinMode (p->enable_pin, OUTPUT)
    val LCD_4BITMODE = $UN.cast{uint8}(0x00)
    val LCD_2LINE    = $UN.cast{uint8}(0x08)
    val LCD_5x8DOTS  = $UN.cast{uint8}(0x00)
    val () = p->displayfunction := uint8_bit_or (LCD_4BITMODE, uint8_bit_or (LCD_2LINE, LCD_5x8DOTS))
    prval () = lcd_t_addback_struct(pfat | lcd)
    fun lcd_begin (lcd: !lcd_t, lines: uint8): void = {
      val (pfat | p) = lcd_t_takeout_struct (lcd)
      val () = p->numlines := lines
      val () = p->currline := $UN.cast{uint8}(0)
      val () = delay_us 50000.0
      val () = digitalWrite (p->rs_pin, LOW)
      val () = digitalWrite (p->enable_pin, LOW)
      val () = digitalWrite (p->rw_pin, LOW)
      val displayfunction = p->displayfunction
      // this is according to the hitachi HD44780 datasheet / figure 24, pg 46
      // we start in 8bit mode, try to set 4 bit mode
      val () = lcd_write4bits (pfat | p, $UN.cast{uint8}(0x03))
      val () = delay_us 4500.0
      val () = lcd_write4bits (pfat | p, $UN.cast{uint8}(0x03)) // second try
      val () = delay_us 4500.0
      val () = lcd_write4bits (pfat | p, $UN.cast{uint8}(0x03)) // third go!
      val () = delay_us 150.0
      val () = lcd_write4bits (pfat | p, $UN.cast{uint8}(0x02)) // finally, set to 4-bit interface
      // finally, set # lines, font size, etc.
      val LCD_FUNCTIONSET = $UN.cast{uint8}(0x20)
      val () = lcd_command (pfat | p, uint8_bit_or (LCD_FUNCTIONSET, displayfunction))
      // turn the display on with no cursor or blinking default
      val LCD_DISPLAYON = $UN.cast{uint8}(0x04)
      val LCD_CURSOROFF = $UN.cast{uint8}(0x00)
      val LCD_BLINKOFF  = $UN.cast{uint8}(0x00)
      val () = p->displaycontrol := uint8_bit_or (LCD_DISPLAYON, uint8_bit_or (LCD_CURSOROFF, LCD_BLINKOFF))
      val () = lcd_display (pfat | p)
      // Initialize to default text direction (for romance languages)
      val LCD_ENTRYLEFT           = $UN.cast{uint8}(0x02)
      val LCD_ENTRYSHIFTDECREMENT = $UN.cast{uint8}(0x00)
      val () = p->displaymode := uint8_bit_or (LCD_ENTRYLEFT, LCD_ENTRYSHIFTDECREMENT)
      val displaymode = p->displaymode
      // set the entry mode
      val LCD_ENTRYMODESET = $UN.cast{uint8}(0x04)
      val () = lcd_command (pfat | p, uint8_bit_or (LCD_ENTRYMODESET, displaymode))
      prval () = lcd_t_addback_struct(pfat | lcd)
      // clear it off
      val () = lcd_clear lcd
    }
    val () = lcd_begin (lcd, $UN.cast{uint8}(2))
  in
    lcd
  end
end

implement lcd_close (lcd) = {
  val () = $UN.castvwtp0(lcd) (* Consume lcd *)
}

implement lcd_clear (lcd) = {
  val LCD_CLEARDISPLAY = $UN.cast{uint8}(0x01)
  val (pfat | p) = lcd_t_takeout_struct (lcd)
  val () = lcd_command (pfat | p, LCD_CLEARDISPLAY) // clear display, set cursor position to zero
  prval () = lcd_t_addback_struct(pfat | lcd)
  val () = delay_us 2000.0 // this command takes a long time!
}

implement lcd_setCursor (lcd, col, row) = {
  val LCD_SETDDRAMADDR = $UN.cast{uint8}(0x80)
  val row_ofs = if row > 0 then 0x40 else 0x00:int
  val v = (col:int) + (row_ofs:int)
  val (pfat | p) = lcd_t_takeout_struct (lcd)
  val () = lcd_command(pfat | p,  uint8_bit_or (LCD_SETDDRAMADDR, $UN.cast{uint8}(v)))
  prval () = lcd_t_addback_struct(pfat | lcd)
}

implement lcd_print (lcd, str, start, len) = {
  fun w (lcd: !lcd_t, p: ptr): void = {
    val c = $UN.ptr0_get<uint8> (p)
    val () = lcd_write (lcd, c)
  }
  fun loop (lcd: !lcd_t, p: ptr, r: size_t): void = {
    val () = if r > 0 then (w (lcd, p); loop (lcd, ptr_succ<char> (p), r - i2sz 1))
  }
  val p0 = string2ptr (str)
  val p0 = ptr_add<char> (p0, start)
  val () = loop (lcd, p0, len)
}

implement lcd_write (lcd, value) = {
  val (pfat | p) = lcd_t_takeout_struct (lcd)
  val () = lcd_send (pfat | p, value, HIGH)
  prval () = lcd_t_addback_struct(pfat | lcd)
}

implement lcd_display (pfat | p) = {
  val LCD_DISPLAYON = $UN.cast{uint8}(0x04)
  val () = p->displaycontrol := LCD_DISPLAYON
  val displaycontrol = p->displaycontrol
  val LCD_DISPLAYCONTROL = $UN.cast{uint8}(0x08)
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
  val () = delay_us 1.0
  val () = digitalWrite (p->enable_pin, HIGH)
  val () = delay_us 1.0 // enable pulse must be >450ns
  val () = digitalWrite (p->enable_pin, LOW)
  val () = delay_us 100.0 // commands need > 37us to settle
}

implement lcd_write4bits (pfat | p, value) = {
  fun uint8_to_highlow (v: uint8): natLt(2) = $UN.cast{natLt(2)}(uint8_bit_and (v, $UN.cast{uint8}(0x01)))
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
