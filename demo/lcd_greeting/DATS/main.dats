#include "config.hats"
#include "{$TOP}/avr_prelude/kernel_staload.hats"

staload "{$TOP}/SATS/arduino.sats"
staload "{$TOP}/SATS/lcd.sats"

#define MY_DELAY_MS 400.0
#define LCD_WIDTH 16

val g_str_atsrun = "<ATS running!>"
val g_str_message = "                 ATS is a statically typed programming language that unifies implementation with formal specification. It is equipped with a highly expressive type system rooted in the framework Applied Type System, which gives the language its name. In particular, both dependent types and linear types are available in ATS.                 "

implement main () = {
  fun loop {n:int}{i:nat | i < n} .<n-i>.
           (lcd: !lcd_t, str: string (n), pos: size_t (i)): void = {
    val () = if pos + i2sz LCD_WIDTH <= length str then {
      val () = (lcd_setCursor (lcd, 1, 0); lcd_print (lcd, g_str_atsrun, i2sz 0, length g_str_atsrun))
      val () = (lcd_setCursor (lcd, 0, 1); lcd_print (lcd, str, pos, i2sz LCD_WIDTH))
      val () = delay_ms (MY_DELAY_MS)
      val () = loop (lcd, str, pos + 1)
    }
  }
  fun forever {n:int}{i:nat | i < n}
              (lcd: !lcd_t, str: string (n), pos: size_t (i)): void = {
    val () = loop (lcd, str, pos)
    val () = forever (lcd, str, pos)
  }
  val lcd = lcd_open (8, 13, 9, 4, 5, 6, 7)
  val () = forever (lcd, g_str_message, i2sz 0)
  val () = lcd_close lcd
}
