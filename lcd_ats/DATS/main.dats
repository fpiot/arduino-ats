#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"

staload "SATS/arduino.sats"

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

  val () = pinMode (ledPin, OUTPUT)
  val () = loop ()
}
