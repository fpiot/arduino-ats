#include "config.hats"
#include "{$TOP}/avr_prelude/kernel_staload.hats"

staload "{$TOP}/SATS/arduino.sats"

implement main0 () = {
  val () = init ()
  val () = main ()
}
