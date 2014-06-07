#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"

staload "SATS/arduino.sats"
staload "SATS/hardware_serial.sats"
dynload "DATS/hardware_serial.dats"

#define BLINK_DELAY_MS 50.0

implement main0 () = {
  val ledPin = int2uchar0 13

  fun printchar (c) = {
    val _ = serial_write (int2char0 c)
    val _ = serial_write ('\r')
    val _ = serial_write ('\n')
    val () = serial_flush ()
  }

  fun readprint () =
    if (serial_available () > 0) then let
      val c = serial_read ()
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
  val () = serial_begin (9600UL)
  val () = loop ()
}
