#include "config.hats"
#include "{$TOP}/avr_prelude/kernel_staload.hats"

staload "{$TOP}/SATS/arduino.sats"
staload "{$TOP}/SATS/hardware_serial.sats"
staload "{$TOP}/SATS/twi.sats"
staload "{$TOP}/SATS/smbus.sats"

staload "prelude/SATS/unsafe.sats"
staload "prelude/SATS/list.sats"


#define BLINK_DELAY_MS 50.0

extern fun malloc (s: size_t): [l:addr | l > null] ptr l = "mac#malloc"
extern fun free {l:addr | l > null} (p: ptr l):void = "mac#free"

implement main () = {

  fun test_bus () = {
    val o = malloc(sizeof<uint8> * 2)
    val i = malloc(sizeof<uint8> * 2)

    val () = ptr0_set_at<char> (o, 0, '\00')
    val () = ptr0_set_at<char> (o, 1, '\00')
    val r1 = twi_writeTo (cast{uint8}(0x30), ptr2cptr (o), cast{uint8}(2), cast{uint8}(1), cast{uint8}(1))

    val r1 = twi_writeTo (cast{uint8}(0x30), ptr2cptr (o), cast{uint8}(1), cast{uint8}(1), cast{uint8}(0))
    val r2 = twi_readFrom (cast{uint8}(0x30), ptr2cptr (i), cast{uint8}(1), cast{uint8}(1))

    val v = ptr0_get_at<char> (i, 1)
    val () = println! v

    val () = ptr0_set_at<char> (o, 0, '\00')
    val () = ptr0_set_at<char> (o, 1, '\01')
    val r1 = twi_writeTo (cast{uint8}(0x30), ptr2cptr (o), cast{uint8}(2), cast{uint8}(1), cast{uint8}(1))

    val r1 = twi_writeTo (cast{uint8}(0x30), ptr2cptr (o), cast{uint8}(1), cast{uint8}(1), cast{uint8}(0))
    val r2 = twi_readFrom (cast{uint8}(0x30), ptr2cptr (i), cast{uint8}(1), cast{uint8}(1))

    val v = ptr0_get_at<char> (i, 1)
    val () = println! v

    val () = free (o)
    val () = free (i)
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
