#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"

staload "SATS/arduino.sats"
staload "SATS/lcd.sats"
staload UN = "prelude/SATS/unsafe.sats"

#define MY_DELAY_MS 100.0

val g_string = "ATS is a statically typed programming language that unifies implementation with formal specification. It is equipped with a highly expressive type system rooted in the framework Applied Type System, which gives the language its name. In particular, both dependent types and linear types are available in ATS.                                          "

implement main0 () = {
  fun loop {n:int}{i:nat | i < n}{j:nat | i + j <= n}
           (lcd: !LCD, str: string (n), pos: int (i), len: int (j)): void = {
    val () = lcd_setCursor (lcd, $UN.cast 1, 0)
    val () = lcd_print (lcd, "<ATS running!>", 0, 14)
    val () = lcd_setCursor (lcd, $UN.cast 0, 1)
    val () = lcd_print (lcd, str, pos, len)
    val () = _delay_ms (MY_DELAY_MS)
    val () = loop (lcd, str, pos, len)
  }
  val lcd = lcd_open ($UN.cast 8, $UN.cast 13, $UN.cast 9, $UN.cast 4, $UN.cast 5, $UN.cast 6, $UN.cast 7)
  val () = loop (lcd, g_string, 0, 16)
  val () = lcd_close lcd
}
