#include "config.hats"
#include "{$TOP}/avr_prelude/kernel_staload.hats"

staload "{$TOP}/SATS/arduino.sats"

#define LED 13
#define BUTTON 7

implement main () = {
  fun loop () = {
    val b = digitalRead (BUTTON)
    val () = digitalWrite (LED, b)
    val () = loop ()
  }
  val () = pinMode (LED, OUTPUT)
  val () = pinMode (BUTTON, INPUT)
  val () = loop ()
}
