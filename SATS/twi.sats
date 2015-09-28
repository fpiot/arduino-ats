%{#
#include "twi.h"
%}

//macdef twi_buffer = $extval(cPtr0(ring_buffer), "&tx_buffer")

fun twi_init             ()                                         : void   = "mac#"
fun twi_setAddress       (uint8)                                    : void   = "mac#"
fun twi_readFrom         (uint8, cPtr0(uint8), uint8, uint8)        : uint8  = "mac#"
fun twi_writeTo          (uint8, cPtr0(uint8), uint8, uint8, uint8) : uint8  = "mac#"
fun twi_transmit         (cPtr0(uint8), uint8)                      : uint8  = "mac#"
fun twi_reply            (uint8)                                    : void   = "mac#"
fun twi_stop             ()                                         : void   = "mac#"
fun twi_releaseBus       ()                                         : void   = "mac#"