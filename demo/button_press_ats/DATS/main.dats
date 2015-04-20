#include "config.hats"
#include "{$TOP}/avr_prelude/kernel_staload.hats"

staload "{$TOP}/SATS/arduino.sats"

#define BUTTON 7

fun revstate (s:natLt(2)): natLt(2) = if s = 0 then 1 else 0

implement main () = {
  fun loop () = {
    val b = digitalRead (BUTTON)
    val () = digitalWrite (LED_BUILTIN, revstate (b))
    val () = loop ()
  }
  val () = pinMode (LED_BUILTIN, OUTPUT)
  val () = pinMode (BUTTON, INPUT)
  val () = loop ()
}
