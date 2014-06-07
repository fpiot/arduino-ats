%{^
#include "hardware_serial.h"

#if defined(UBRRH) && defined(UBRRL)
#define ADDR_UBRRH (UBRRH)
#define ADDR_UBRRL (UBRRL)
#define ADDR_UCSRA (UCSRA)
#define ADDR_UCSRB (UCSRB)
#define ADDR_UCSRC (UCSRC)
#define ADDR_UDR   (UDR)
#define BIT_RXEN   (RXEN)
#define BIT_TXEN   (TXEN)
#define BIT_RXCIE  (RXCIE)
#define BIT_UDRIE  (UDRIE)
#define BIT_U2X    (U2X)
#elif defined(UBRR0H) && defined(UBRR0L)
#define ADDR_UBRRH (UBRR0H)
#define ADDR_UBRRL (UBRR0L)
#define ADDR_UCSRA (UCSR0A)
#define ADDR_UCSRB (UCSR0B)
#define ADDR_UCSRC (UCSR0C)
#define ADDR_UDR   (UDR0)
#define BIT_RXEN   (RXEN0)
#define BIT_TXEN   (TXEN0)
#define BIT_RXCIE  (RXCIE0)
#define BIT_UDRIE  (UDRIE0)
#define BIT_U2X    (U2X0)
#else
#error no serial port defined  (port 0)
#endif
%}

#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"
staload "SATS/arduino.sats"
staload "SATS/hardware_serial.sats"
staload UN = "prelude/SATS/unsafe.sats"

abst@ype hardware_serial = $extype"struct hardware_serial"
macdef hserial   = $extval(cPtr0(hardware_serial), "(&Serial)")

abst@ype ring_buffer = $extype"struct ring_buffer"
macdef rx_buffer = $extval(cPtr0(ring_buffer), "&rx_buffer")
macdef tx_buffer = $extval(cPtr0(ring_buffer), "&tx_buffer")

macdef ADDR_UBRRH = $extval(ptr, "&ADDR_UBRRH")
macdef ADDR_UBRRL = $extval(ptr, "&ADDR_UBRRL")
macdef ADDR_UCSRA = $extval(ptr, "&ADDR_UCSRA")
macdef ADDR_UCSRB = $extval(ptr, "&ADDR_UCSRB")
macdef ADDR_UCSRC = $extval(ptr, "&ADDR_UCSRC")
macdef ADDR_UDR   = $extval(ptr, "&ADDR_UDR")
macdef BIT_RXEN   = $extval(uint8, "BIT_RXEN")
macdef BIT_TXEN   = $extval(uint8, "BIT_TXEN")
macdef BIT_RXCIE  = $extval(uint8, "BIT_RXCIE")
macdef BIT_UDRIE  = $extval(uint8, "BIT_UDRIE")
macdef BIT_U2X    = $extval(uint8, "BIT_U2X")
macdef BIT_TXC0   = $extval(uint8, "TXC0")

extern fun ringbuf_insert_nowait: (uchar, cPtr0(ring_buffer)) -> void  = "mac#"
extern fun ringbuf_insert_wait:   (uchar, cPtr0(ring_buffer)) -> void  = "mac#"
extern fun ringbuf_is_empty:      (cPtr0(ring_buffer))        -> bool  = "mac#"
extern fun ringbuf_get_size:      (cPtr0(ring_buffer))        -> uint  = "mac#"
extern fun ringbuf_peek:          (cPtr0(ring_buffer))        -> uchar = "mac#"
extern fun ringbuf_remove:        (cPtr0(ring_buffer))        -> uchar = "mac#"
extern fun ringbuf_clear:         (cPtr0(ring_buffer))        -> void  = "mac#"

extern fun c_sbi:            (ptr, uint8) -> void = "mac#"
extern fun set_transmitting: (bool)       -> void = "mac#"

extern fun c_hardware_serial_begin: (cPtr0(hardware_serial), ulint) -> void   = "mac#hardware_serial_begin"
extern fun c_hardware_serial_flush: (cPtr0(hardware_serial))        -> void   = "mac#hardware_serial_flush"
extern fun c_hardware_serial_available: (cPtr0(hardware_serial))    -> int    = "mac#hardware_serial_available"

implement serial_begin (baud) =
  c_hardware_serial_begin (hserial, baud)
implement serial_flush () =
  c_hardware_serial_flush (hserial)
implement serial_available () =
  c_hardware_serial_available (hserial)

implement serial_read () =
  if (ringbuf_is_empty (rx_buffer)) then
    ~1
  else
    $UN.cast (ringbuf_remove (rx_buffer))

implement serial_write (c) = let
  val () = ringbuf_insert_wait ($UN.cast c, tx_buffer)
  val () = c_sbi (ADDR_UCSRB, BIT_UDRIE)
  // clear the TXC bit -- "can be cleared by writing a one to its bit location"
  val () = set_transmitting (true)
  val () = c_sbi (ADDR_UCSRA, BIT_TXC0)
in
  $UN.cast 1
end
