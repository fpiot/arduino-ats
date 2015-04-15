#define ATS_DYNLOADFLAG 0
#include "config.hats"
#include "{$TOP}/avr_prelude/kernel_staload.hats"

staload "{$TOP}/SATS/arduino.sats"

#define BLINK_DELAY_MS 500.0

implement main () = {
  fun loop () = {
    val () = digitalWrite (LED_BUILTIN, HIGH)
    val () = delay_ms (BLINK_DELAY_MS)
    val () = digitalWrite (LED_BUILTIN, LOW)
    val () = delay_ms (BLINK_DELAY_MS)
    val () = loop ()
  }
  val () = pinMode (LED_BUILTIN, OUTPUT)
  val () = loop ()
}
