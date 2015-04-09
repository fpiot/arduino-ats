#include "config.hats"
#include "{$TOP}/avr_prelude/kernel_staload.hats"

staload "{$TOP}/SATS/arduino.sats"
staload "{$TOP}/SATS/hardware_serial.sats"
staload "{$TOP}/SATS/eeprom.sats"
staload UN = "prelude/SATS/unsafe.sats"

#define ADDR 7
#define VAL 111
#define BLINK_DELAY_MS 1000.0

implement main0 () = {
  fun loop (value: uint8) = {
    val () = println! ("Adddress ",  ADDR, " = ", value)
    val () = delay_ms (BLINK_DELAY_MS)
    val () = loop (value)
  }

  val () = interrupts ()
  val () = serial_begin (9600UL)
  val () = eeprom_write_byte (ADDR, $UN.cast (VAL))
  val v  = eeprom_read_byte (ADDR)
  val () = loop (v)
}
