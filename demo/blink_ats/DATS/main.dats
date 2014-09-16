#include "share/atspre_staload.hats"
#include "config.hats"

staload "{$TOP}/SATS/arduino.sats"

#define BLINK_DELAY_MS 500.0

implement main0 () = {
  fun loop () = {
    val () = digitalWrite (LED_BUILTIN, HIGH)
    val () = _delay_ms (BLINK_DELAY_MS)
    val () = digitalWrite (LED_BUILTIN, LOW)
    val () = _delay_ms (BLINK_DELAY_MS)
    val () = loop ()
  }
  val () = pinMode (LED_BUILTIN, OUTPUT)
  val () = loop ()
}
