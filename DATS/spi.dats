%{^
#include "SPI.h"
%}

#include "config.hats"
#include "{$TOP}/avr_prelude/kernel_staload.hats"

staload "{$TOP}/SATS/arduino.sats"
staload "{$TOP}/SATS/spi.sats"
staload UN = "prelude/SATS/unsafe.sats"

macdef SPCR_PTR  = $extval(ptr, "(&SPCR)")
macdef SPDR_PTR  = $extval(ptr, "(&SPDR)")
macdef SPSR_PTR  = $extval(ptr, "(&SPSR)")
macdef SS        = $extval(uint8, "SS")
macdef SCK       = $extval(uint8, "SCK")
macdef MOSI      = $extval(uint8, "MOSI")
macdef MSTR_BIT  = $extval(uint8, "_BV(MSTR)")
macdef SPE_BIT   = $extval(uint8, "_BV(SPE)")
macdef SPIF_BIT  = $extval(uint8, "_BV(SPIF)")
macdef SPI_MODE_MASK = $extval(uint8, "SPI_MODE_MASK")
macdef SPI_CLOCK_MASK = $extval(uint8, "SPI_CLOCK_MASK")
macdef SPI_2XCLOCK_MASK = $extval(uint8, "SPI_2XCLOCK_MASK")

implement spi_begin () = {
  // Set SS to high so a connected chip will be "deselected" by default
  val () = digitalWrite (SS, HIGH)
  // When the SS pin is set as OUTPUT, it can be used as
  // a general purpose output port (it doesn't influence
  // SPI operations).
  val () = pinMode (SS, OUTPUT)
  // Warning: if the SS pin ever becomes a LOW INPUT then SPI
  // automatically switches to Slave, so the data direction of
  // the SS pin MUST be kept as OUTPUT.
  val spcr = $UN.ptr0_get<uint8> (SPCR_PTR)
  val spcr = g0uint_lor (g0uint_lor (spcr, MSTR_BIT), SPE_BIT)
  val () = $UN.ptr0_set<uint8> (SPCR_PTR, spcr)
  // Set direction register for SCK and MOSI pin.
  // MISO pin automatically overrides to INPUT.
  // By doing this AFTER enabling SPI, we avoid accidentally
  // clocking in a single bit since the lines go directly
  // from "input" to SPI control.  
  // http://code.google.com/p/arduino/issues/detail?id=888
  val () = pinMode (SCK, OUTPUT)
  val () = pinMode (MOSI, OUTPUT)
}

implement spi_setClockDivider (rate) = {
  val spcr = $UN.ptr0_get<uint8> (SPCR_PTR)
  val a = g0uint_land (spcr, g0uint_lnot SPI_CLOCK_MASK)
  val b = g0uint_land (rate, SPI_CLOCK_MASK)
  val () = $UN.ptr0_set<uint8> (SPCR_PTR, g0uint_lor (a, b))
  val spsr = $UN.ptr0_get<uint8> (SPSR_PTR)
  val a = g0uint_land (spsr, g0uint_lnot SPI_2XCLOCK_MASK)
  val b = g0uint_land (g0uint_lsr (rate, 2), SPI_2XCLOCK_MASK)
  val () = $UN.ptr0_set<uint8> (SPSR_PTR, g0uint_lor (a, b))
}

implement spi_setDataMode (mode) = {
  val spcr = $UN.ptr0_get<uint8> (SPCR_PTR)
  val spcr = g0uint_lor (g0uint_land (spcr, g0uint_lnot SPI_MODE_MASK), mode)
  val () = $UN.ptr0_set<uint8> (SPCR_PTR, spcr)
}

implement spi_transfer (data) = let
  fun loop ():void = {
    val spsr = $UN.ptr0_get<uint8> (SPSR_PTR)
    val b = g0uint_land (spsr, SPIF_BIT)
    val () = if iseqz b then loop ()
  }
  val () = $UN.ptr0_set<uint8> (SPDR_PTR, data)
  val () = loop ()
in
  $UN.ptr0_get<uint8> (SPDR_PTR)
end

implement spi_end () = {
  val spcr = $UN.ptr0_get<uint8> (SPCR_PTR)
  val spcr = g0uint_land (spcr, g0uint_lnot SPE_BIT)
  val () = $UN.ptr0_set<uint8> (SPCR_PTR, spcr)
}
