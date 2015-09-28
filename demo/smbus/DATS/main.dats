#include "config.hats"
#include "{$TOP}/avr_prelude/kernel_staload.hats"

staload "{$TOP}/SATS/arduino.sats"
staload "{$TOP}/SATS/hardware_serial.sats"
staload "{$TOP}/SATS/twi.sats"
staload "{$TOP}/SATS/smbus.sats"
staload "{$TOP}/SATS/pmbus.sats"

staload "prelude/SATS/unsafe.sats"
staload "prelude/SATS/list.sats"


#define BLINK_DELAY_MS 50.0

extern fun malloc (s: size_t): [l:addr | l > null] ptr l = "mac#malloc"
extern fun free {l:addr | l > null} (p: ptr l):void = "mac#free"

implement main () = {

  fun test_bus () = {
    val s = write_byte (cast{uint8}(0x30), cast{uint8}(0x00), cast{uint8}(0x01))
    val () = show_smbus_status s

    val s = write_word (cast{uint8}(0x30), cast{uint8}(0x79), cast{uint16}(0x55AA))
    val () = show_smbus_status s

    val (s,r) = read_byte (cast{uint8}(0x30), cast{uint8}(0x00))
    val () = show_smbus_status s
    val () = println! (cast{int}(r))

    val (s,r) = read_word (cast{uint8}(0x30), cast{uint8}(0x79))
    val () = show_smbus_status s
    val () = println! (cast{int}(r))

    val (s,r) = read_word (cast{uint8}(0x30), cast{uint8}(0x8B))
    val () = show_smbus_status s
    val () = println! (cast{int}(r))
  }

  fun readprint () =
    if (serial_available () > 0) then let
      val c = serial_read ()
    in
      if (c <> ~1) then test_bus ()
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

  val () = serial_begin (115200UL)
  val () = twi_init ()
  val () = loop ()
//  val () = twi_releaseBus ()

}