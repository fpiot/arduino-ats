#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"
#include "config.hats"

staload "{$TOP}/SATS/arduino.sats"
staload "{$TOP}/SATS/lcd.sats"
staload UN = "prelude/SATS/unsafe.sats"

#define MY_DELAY_MS 400.0
#define LCD_WIDTH 16

val g_string = "                 ATS is a statically typed programming language that unifies implementation with formal specification. It is equipped with a highly expressive type system rooted in the framework Applied Type System, which gives the language its name. In particular, both dependent types and linear types are available in ATS.                 "

implement main0 () = {
  fun loop {n:int}{i:nat | i < n}
           (lcd: !LCD, str: string (n), pos: size_t (i)): void = {
    val () = lcd_setCursor (lcd, $UN.cast 1, 0)
    val () = lcd_print (lcd, "<ATS running!>", i2sz 0, 14)
    val () = lcd_setCursor (lcd, $UN.cast 0, 1)
    val () = lcd_print (lcd, str, pos, LCD_WIDTH)
    val () = _delay_ms (MY_DELAY_MS)
    val () = if pos + LCD_WIDTH < length str then loop (lcd, str, pos + 1)
  }
  fun forever {n:int}{i:nat | i < n}
           (lcd: !LCD, str: string (n), pos: size_t (i)): void = {
    val () = loop (lcd, str, pos)
    val () = forever (lcd, str, pos)
  }
  val lcd = lcd_open ($UN.cast 8, $UN.cast 13, $UN.cast 9, $UN.cast 4, $UN.cast 5, $UN.cast 6, $UN.cast 7)
  val () = forever (lcd, g_string, i2sz 0)
  val () = lcd_close lcd
}
