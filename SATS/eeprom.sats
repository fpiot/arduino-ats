%{#
#include <avr/eeprom.h>
%}
fun eeprom_read_byte {n:nat} (address: int n): uint8 = "mac#"
fun eeprom_write_byte {n:nat} (address: int n, value: uint8): void = "mac#"
