%{^
#include "hardware_serial.h"
%}

abst@ype hardware_serial = $extype"struct hardware_serial"

macdef hserial   = $extval(cPtr0(hardware_serial), "(&Serial)")

fun hardware_serial_begin: (cPtr0(hardware_serial), ulint) -> void   = "mac#"
fun hardware_serial_write: (cPtr0(hardware_serial), char)  -> size_t = "mac#"
fun hardware_serial_flush: (cPtr0(hardware_serial))        -> void   = "mac#"
