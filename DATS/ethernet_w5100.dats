#define ATS_DYNLOADFLAG 0 // no dynloading at run-time
#include "config.hats"
#include "{$TOP}/avr_prelude/kernel_staload.hats"

staload "{$TOP}/SATS/arduino.sats"
staload "{$TOP}/SATS/spi.sats"
staload "{$TOP}/SATS/ethernet_w5100.sats"

implement ethernet_w5100_init () = {
  val () = _delay_ms 300.0
  val () = spi_begin ()
  // xxx
}
