#include "config.hats"
#include "{$TOP}/avr_prelude/kernel_staload.hats"

staload "{$TOP}/SATS/arduino.sats"

#define BUTTON 7

implement main () = {
  fun loop () = {
    val b = digitalRead (BUTTON)
    val () = digitalWrite (LED_BUILTIN, b)
    val () = loop ()
  }
  val () = pinMode (LED_BUILTIN, OUTPUT)
  val () = pinMode (BUTTON, INPUT)
  val () = loop ()
}
