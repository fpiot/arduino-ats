#define ATS_DYNLOADFLAG 0
#include "config.hats"
#include "{$TOP}/avr_prelude/kernel_staload.hats"

staload "{$TOP}/SATS/arduino.sats"
staload "{$TOP}/SATS/hardware_serial.sats"

#define BLINK_DELAY_MS 50.0

implement main () = {
  fun printchar (c) = {
    val () = println! ("Inputed: ", int2char0 c)
  }

  fun readprint () =
    if (serial_available () > 0) then let
      val c = serial_read ()
    in
      if (c <> ~1) then printchar (c)
    end

  fun blink () = {
    val () = digitalWrite (LED_BUILTIN, HIGH)
    val () = delay_ms (BLINK_DELAY_MS)
    val () = digitalWrite (LED_BUILTIN, LOW)
    val () = delay_ms (BLINK_DELAY_MS)
  }

  fun loop () = {
    val () = blink ()
    val () = readprint ()
    val () = loop ()
  }

  val () = pinMode (LED_BUILTIN, OUTPUT)
  val () = interrupts ()
  val () = serial_begin (9600UL)
  val () = loop ()
}
