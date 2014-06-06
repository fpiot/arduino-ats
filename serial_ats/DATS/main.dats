#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"

staload "SATS/arduino.sats"
staload "SATS/hardware_serial.sats"
dynload "DATS/hardware_serial.dats"

#define BLINK_DELAY_MS 50.0

implement main0 () = {
  val ledPin = int2uchar0 13

  fun printchar (c) = {
    val _ = hardware_serial_write (hserial, int2char0 c)
    val _ = hardware_serial_write (hserial, '\r')
    val _ = hardware_serial_write (hserial, '\n')
  }

  fun readprint () =
    if (hardware_serial_available (hserial) > 0) then let
      val c = hardware_serial_read (hserial)
    in
      if (c <> ~1) then printchar (c)
    end

  fun blink () = {
    val () = digitalWrite (ledPin, HIGH)
    val () = _delay_ms (BLINK_DELAY_MS)
    val () = digitalWrite (ledPin, LOW)
    val () = _delay_ms (BLINK_DELAY_MS)
  }

  fun loop () = {
    val () = blink ()
    val () = readprint ()
    val () = loop ()
  }

  val () = pinMode (ledPin, OUTPUT)
  val () = interrupts ()
  val () = hardware_serial_begin (hserial, 9600UL)
  val () = loop ()
}
