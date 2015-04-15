#define ATS_DYNLOADFLAG 0 // no dynloading at run-time
#include "config.hats"
#include "{$TOP}/avr_prelude/kernel_staload.hats"

staload "{$TOP}/SATS/arduino.sats"

implement main0 () = {
  val () = init ()
  val () = main ()
}
