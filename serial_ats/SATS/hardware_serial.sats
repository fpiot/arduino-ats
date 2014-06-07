%{^
#include "hardware_serial.h"
%}

abst@ype hardware_serial = $extype"struct hardware_serial"

macdef hserial   = $extval(cPtr0(hardware_serial), "(&Serial)")

fun serial_begin:     (ulint) -> void
fun serial_write:     (char)  -> size_t
fun serial_flush:     ()      -> void
fun serial_available: ()      -> int
fun serial_read:      ()      -> int
