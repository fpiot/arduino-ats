#include "config.hats"
#include "{$TOP}/avr_prelude/kernel_staload.hats"

staload "{$TOP}/SATS/arduino.sats"
staload "{$TOP}/SATS/hardware_serial.sats"
staload UN = "prelude/SATS/unsafe.sats"

#define SENSOR 0
#define DELAY_MS 100.0

implement main () = {
  fun loop () = {
    val v = analogRead (SENSOR)
    val () = println! v
    val () = delay_ms (DELAY_MS)
    val () = loop ()
  }
  val () = serial_begin (9600UL)
  val () = loop ()
}
