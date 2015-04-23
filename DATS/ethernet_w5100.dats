%{^
#include "w5100.h"
%}

#include "config.hats"
#include "{$TOP}/avr_prelude/kernel_staload.hats"

staload "{$TOP}/SATS/arduino.sats"
staload "{$TOP}/SATS/spi.sats"
staload "{$TOP}/SATS/ethernet_w5100.sats"
staload UN = "prelude/SATS/unsafe.sats"

macdef DDRB_PTR  = $extval(ptr, "(&DDRB)")
macdef PORTB_PTR  = $extval(ptr, "(&PORTB)")

extern fun initSS (): void = "mac#"
extern fun setSS (): void = "mac#"
extern fun resetSS (): void = "mac#"

fun _write (addr: uint16, data: uint8): void = {
  val () = setSS ()
  val _ = spi_transfer ($UN.cast 0xf0)
  val _ = spi_transfer ($UN.cast (addr >> 8))
  val v = g0uint_land_uint16 (addr, ($UN.cast 0xff))
  val _ = spi_transfer ($UN.cast v)
  val _ = spi_transfer data
  val () = resetSS ()
}

fun _read (addr: uint16): uint8 = r where {
  val () = setSS ()
  val _ = spi_transfer ($UN.cast 0xf0)
  val _ = spi_transfer ($UN.cast (addr >> 8))
  val v = g0uint_land_uint16 (addr, ($UN.cast 0xff))
  val _ = spi_transfer ($UN.cast v)
  val r = spi_transfer ($UN.cast 0)
  val () = resetSS ()
}

implement ethernet_w5100_init () = {
  val () = delay_ms 300.0
  val () = spi_begin ()
  val () = initSS ()
  // xxx
}
