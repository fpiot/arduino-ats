#include "config.hats"
#include "{$TOP}/avr_prelude/kernel_staload.hats"

staload "{$TOP}/SATS/arduino.sats"

#define LED 13
#define BLINK_DELAY_MS 500.0

implement main () = {
  fun loop () = {
    val () = digitalWrite (LED, HIGH)
    val () = delay_ms (BLINK_DELAY_MS)
    val () = digitalWrite (LED, LOW)
    val () = delay_ms (BLINK_DELAY_MS)
    val () = loop ()
  }
  val () = pinMode (LED, OUTPUT)
  val () = loop ()
}
