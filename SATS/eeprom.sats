%{#
#include <avr/eeprom.h>
%}
fun eeprom_read_byte (address: int): uint8 = "mac#"
fun eeprom_write_byte (address: int, value: uint8): void = "mac#"
