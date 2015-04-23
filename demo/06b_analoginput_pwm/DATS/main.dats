#include "config.hats"
#include "{$TOP}/avr_prelude/kernel_staload.hats"

staload "{$TOP}/SATS/arduino.sats"
staload UN = "prelude/SATS/unsafe.sats"

#define LED 9
#define SENSOR 0
#define DELAY_MS 10.0

implement main () = {
  fun loop () = {
    val v = analogRead (SENSOR)
    val () = analogWrite (LED, $UN.cast{natLt(256)}(v / 4))
    val () = delay_ms (DELAY_MS)
    val () = loop ()
  }
  val () = pinMode (LED, OUTPUT)
  val () = loop ()
}
