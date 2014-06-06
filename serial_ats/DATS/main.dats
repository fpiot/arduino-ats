#include "share/atspre_staload.hats"

%{^
#include "hardware_serial.h"
%}

staload "SATS/arduino.sats"

#define BLINK_DELAY_MS 500.0

abst@ype hardware_serial = $extype"struct hardware_serial"

macdef hserial   = $extval(cPtr0(hardware_serial), "(&Serial)")

extern fun hardware_serial_begin: (cPtr0(hardware_serial), ulint) -> void   = "mac#"
extern fun hardware_serial_write: (cPtr0(hardware_serial), char)  -> size_t = "mac#"
extern fun hardware_serial_flush: (cPtr0(hardware_serial))        -> void   = "mac#"

implement main0 () = {
  val ledPin = int2uchar0 13
  fun loop () = {
    val () = digitalWrite (ledPin, HIGH)
    val () = _delay_ms (BLINK_DELAY_MS)
    val () = digitalWrite (ledPin, LOW)
    val () = _delay_ms (BLINK_DELAY_MS)
    val _  = hardware_serial_write (hserial, 'Q')
    val _  = hardware_serial_write (hserial, '\n')
    val () = loop ()
  }
  val () = pinMode (ledPin, OUTPUT)
  val () = interrupts ()
  val () = hardware_serial_begin (hserial, 9600UL)
  val () = loop ()
}
