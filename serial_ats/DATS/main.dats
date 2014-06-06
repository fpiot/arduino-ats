#include "share/atspre_staload.hats"

staload "SATS/arduino.sats"
staload "SATS/hardware_serial.sats"

#define BLINK_DELAY_MS 500.0

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
