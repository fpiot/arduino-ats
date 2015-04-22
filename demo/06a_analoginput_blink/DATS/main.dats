#include "config.hats"
#include "{$TOP}/avr_prelude/kernel_staload.hats"

staload "{$TOP}/SATS/arduino.sats"
staload UN = "prelude/SATS/unsafe.sats"

#define LED 13
#define SENSOR 0

implement main () = {
  fun loop () = {
    val w = analogRead (SENSOR)
    val () = digitalWrite (LED, HIGH)
    val () = delay ($UN.cast w)
    val () = digitalWrite (LED, LOW)
    val () = delay ($UN.cast w)
    val () = loop ()
  }
  val () = pinMode (LED, OUTPUT)
  val () = loop ()
}
