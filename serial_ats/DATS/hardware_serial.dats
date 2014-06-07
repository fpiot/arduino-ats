#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"

staload "SATS/arduino.sats"
staload "SATS/hardware_serial.sats"

abst@ype ring_buffer = $extype"struct ring_buffer"

typedef hardware_serial_rec = @{
  rx_buffer= cPtr0(ring_buffer)
, tx_buffer= cPtr0(ring_buffer)
, p_ubrrh=   ptr
, p_ubrrl=   ptr
, p_ucsra=   ptr
, p_ucsrb=   ptr
, p_ucsrc=   ptr
, p_udr=     ptr
, b_rxen=    char
, b_txen=    char
, b_rxcie=   char
, b_udrie=   char
, b_u2x=     char
, transmitting= bool
}

abst@ype hardware_serial = $extype"struct hardware_serial"

macdef hserial   = $extval(cPtr0(hardware_serial), "(&Serial)")

extern fun c_hardware_serial_begin: (cPtr0(hardware_serial), ulint) -> void   = "mac#hardware_serial_begin"
extern fun c_hardware_serial_write: (cPtr0(hardware_serial), char)  -> size_t = "mac#hardware_serial_write"
extern fun c_hardware_serial_flush: (cPtr0(hardware_serial))        -> void   = "mac#hardware_serial_flush"
extern fun c_hardware_serial_available: (cPtr0(hardware_serial))    -> int    = "mac#hardware_serial_available"
extern fun c_hardware_serial_read:  (cPtr0(hardware_serial))        -> int    = "mac#hardware_serial_read"

implement serial_begin (baud) =
  c_hardware_serial_begin (hserial, baud)
implement serial_write (c) =
  c_hardware_serial_write (hserial, c)
implement serial_flush () =
  c_hardware_serial_flush (hserial)
implement serial_available () =
  c_hardware_serial_available (hserial)
implement serial_read () =
  c_hardware_serial_read (hserial)
