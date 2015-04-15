#include "config.hats"
#include "{$TOP}/avr_prelude/kernel_staload.hats"

staload "{$TOP}/SATS/arduino.sats"
staload "{$TOP}/SATS/hardware_serial.sats"
staload "{$TOP}/SATS/eeprom.sats"
staload UN = "prelude/SATS/unsafe.sats"

#define ADDR 7
#define VAL 12
#define BLINK_DELAY_MS 1000.0

implement main () = {
  fun loop (value: (uint8, uint8, uint8)) = {
    val () = println! ("Adddress ",  ADDR, " = ", value.0)
    val () = println! ("Adddress ",  ADDR+1, " = ", value.1)
    val () = println! ("Adddress ",  ADDR+2, " = ", value.2)
    val () = delay_ms (BLINK_DELAY_MS)
    val () = loop (value)
  }

  val () = interrupts ()
  val () = serial_begin (9600UL)
  val () = eeprom_write_byte (ADDR, $UN.cast (VAL))
  val () = eeprom_write_byte (ADDR+1, $UN.cast (VAL*2))
  val () = eeprom_write_byte (ADDR+2, $UN.cast (VAL*3))
  val v1 = eeprom_read_byte (ADDR)
  val v2 = eeprom_read_byte (ADDR+1)
  val v3 = eeprom_read_byte (ADDR+2)
  val () = loop @(v1, v2, v3)
}
