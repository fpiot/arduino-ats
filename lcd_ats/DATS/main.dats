#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"

staload "SATS/arduino.sats"
staload "SATS/lcd.sats"
staload UN = "prelude/SATS/unsafe.sats"

#define BLINK_DELAY_MS 100.0

implement main0 () = {
  val ledPin = LED_BUILTIN
  fun blink () = {
    val () = digitalWrite (ledPin, HIGH)
    val () = _delay_ms (BLINK_DELAY_MS)
    val () = digitalWrite (ledPin, LOW)
    val () = _delay_ms (BLINK_DELAY_MS)
  }
  fun loop () = {
    val () = blink ()
    val () = loop ()
  }

  val lcd = lcd_open ($UN.cast 8, $UN.cast 13, $UN.cast 9, $UN.cast 4, $UN.cast 5, $UN.cast 6, $UN.cast 7)
  val () = lcd_close lcd
  val () = pinMode (ledPin, OUTPUT)
  val () = loop ()
}
