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
#define BIT_UPE    (PE)
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
#define BIT_UPE    (UPE0)
#else
#error no serial port defined  (port 0)
#endif

bool ats_serial_transmitting;
%}

#define ATS_DYNLOADFLAG 0 // no dynloading at run-time
#include "config.hats"
#include "{$TOP}/avr_prelude/kernel_staload.hats"

staload "{$TOP}/avr_prelude/SATS/string0.sats"
staload _ = "{$TOP}/avr_prelude/DATS/string0.dats"
staload "{$TOP}/SATS/arduino.sats"
staload "{$TOP}/SATS/hardware_serial.sats"
staload UN = "prelude/SATS/unsafe.sats"

abst@ype hardware_serial = $extype"struct hardware_serial"
macdef hserial   = $extval(cPtr0(hardware_serial), "(&Serial)")

macdef F_CPU = $extval(ulint, "F_CPU")

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
macdef BIT_UPE    = $extval(uint8, "BIT_UPE")
macdef VAL_U2X    = $extval(uint8, "(1 << BIT_U2X)")

macdef transmitting = $extval(ptr, "&ats_serial_transmitting")

extern fun ringbuf_insert_nowait: (uchar, cPtr0(ring_buffer)) -> void  = "mac#"
extern fun ringbuf_insert_wait:   (uchar, cPtr0(ring_buffer)) -> void  = "mac#"
extern fun ringbuf_is_empty:      (cPtr0(ring_buffer))        -> bool  = "mac#"
extern fun ringbuf_get_size:      (cPtr0(ring_buffer))        -> uint  = "mac#"
extern fun ringbuf_peek:          (cPtr0(ring_buffer))        -> uchar = "mac#"
extern fun ringbuf_remove:        (cPtr0(ring_buffer))        -> uchar = "mac#"
extern fun ringbuf_clear:         (cPtr0(ring_buffer))        -> void  = "mac#"

extern fun c_sbi:            (ptr, uint8) -> void  = "mac#"
extern fun c_cbi:            (ptr, uint8) -> void  = "mac#"
extern fun c_rbi:            (ptr, uint8) -> uint8 = "mac#"

extern fun ats_serial_rx_vect: () -> void = "ext#"
extern fun ats_serial_tx_vect: () -> void = "ext#"

fun set_transmitting (t:bool): void = $UN.ptr0_set<bool> (transmitting, t)
fun get_transmitting (): bool       = $UN.ptr0_get<bool> (transmitting)

implement ats_serial_rx_vect () = {
  val b  = c_rbi (ADDR_UCSRA, BIT_UPE)
  val c  = $UN.ptr0_get<uchar> (ADDR_UDR)
  val () = if ($UN.cast2int b) = 0 then ringbuf_insert_nowait (c, rx_buffer)
}

implement ats_serial_tx_vect () =
  if ringbuf_is_empty tx_buffer then {
    // Buffer empty, so disable interrupts
    val () = c_cbi (ADDR_UCSRB, BIT_UDRIE)
  } else {
    // There is more data in the output buffer. Send the next byte
    val c  = ringbuf_remove tx_buffer
    val () = $UN.ptr0_set<uchar> (ADDR_UDR, c)
  }

implement serial_begin (baud) = {
  fun get_baud_setting_u2x (): ulint = let
    val v = VAL_U2X // xxx 1U << BIT_U2X
    val () = $UN.ptr0_set<uint8> (ADDR_UCSRA, v)
    val setting = (F_CPU / 4UL / baud - 1UL) / 2UL
  in
    setting
  end
  fun get_baud_setting (): ulint = let
    val () = $UN.ptr0_set<uint8> (ADDR_UCSRA, $UN.cast 0)
    val setting = (F_CPU / 8UL / baud - 1UL) / 2UL
  in
    setting
  end
  // hardcoded exception for compatibility with the bootloader shipped
  // with the Duemilanove and previous boards and the firmware on the 8U2
  // on the Uno and Mega 2560.
  val use_u2x = not(F_CPU = 16000000UL andalso baud = 57600UL)
  val tmp = if use_u2x then get_baud_setting_u2x () else get_baud_setting ()
  fun test (setting:ulint): bool = setting > 4095UL
  val baud_setting = if ((test tmp) andalso use_u2x) then get_baud_setting () else tmp

  // assign the baud_setting, a.k.a. ubbr (USART Baud Rate Register)
  val () = $UN.ptr0_set<uint8> (ADDR_UBRRL, $UN.cast (g0uint_lsr (baud_setting, 8)))
  val () = $UN.ptr0_set<uint8> (ADDR_UBRRL, $UN.cast baud_setting)

  val () = set_transmitting (false)

  val () = c_sbi (ADDR_UCSRB, BIT_RXEN)
  val () = c_sbi (ADDR_UCSRB, BIT_TXEN)
  val () = c_sbi (ADDR_UCSRB, BIT_RXCIE)
  val () = c_cbi (ADDR_UCSRB, BIT_UDRIE)
}

implement serial_flush () = {
  // UDR is kept full while the buffer is not empty, so TXC triggers when EMPTY && SENT
  fun loop () = let
    val t = get_transmitting ()
    val b = c_rbi (ADDR_UCSRA, BIT_TXC0)
  in
    if (t andalso (($UN.cast2int b) = 0)) then loop ()
  end
  val () = loop ()
  val () = set_transmitting (false)
}

implement serial_available () =
  ringbuf_get_size rx_buffer

implement serial_peek () =
  if (ringbuf_is_empty (rx_buffer)) then
    ~1
  else
    $UN.cast (ringbuf_peek (rx_buffer))

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

implement serial_end () = {
  // wait for transmission of outgoing data
  fun loop () = if not(ringbuf_is_empty (tx_buffer)) then loop ()
  val () = loop ()
  val () = c_cbi (ADDR_UCSRB, BIT_RXEN)
  val () = c_cbi (ADDR_UCSRB, BIT_TXEN)
  val () = c_cbi (ADDR_UCSRB, BIT_RXCIE)
  val () = c_cbi (ADDR_UCSRB, BIT_UDRIE)
  // clear any received data
  val () = ringbuf_clear (rx_buffer)
}

// atspre_print_char
implement print_char (c) = {
  val _ = serial_write c
}

implement print_int (i) = {
  #define BSZ 32
  typedef cstring = $extype"atstype_string"
  var buf = @[byte][BSZ]()
  val bufp = $UN.cast{cstring}(addr@buf)
  val _ = $extfcall(ssize_t, "snprintf", bufp, BSZ, "%i", i)
  val () = print_string ($UN.cast bufp)
}

implement print_uint8 (i) = print_int ($UN.cast i)

// atspre_print_string
implement print_string (s) = {
  implement{env}
  string0_foreach$fwork
    (c, env) = {val _ = serial_write (c)}
  val _ = string0_foreach s
}

// atspre_print_newline
implement print_newline () = {
    val _ = serial_write ('\r')
    val _ = serial_write ('\n')
    val () = serial_flush ()
}

%{$
#if !defined(USART_RX_vect) && !defined(USART0_RX_vect) && !defined(USART_RXC_vect)
  #error "Don't know what the Data Received vector is called for the first UART"
#else
#if defined(USART_RX_vect)
ISR(USART_RX_vect)
#elif defined(USART0_RX_vect)
ISR(USART0_RX_vect)
#elif defined(USART_RXC_vect)
ISR(USART_RXC_vect) // ATmega8
#endif
{
    ats_serial_rx_vect();
}
#endif

#if !defined(UART0_UDRE_vect) && !defined(UART_UDRE_vect) && !defined(USART0_UDRE_vect) && !defined(USART_UDRE_vect)
  #error "Don't know what the Data Register Empty vector is called for the first UART"
#else
#if defined(UART0_UDRE_vect)
ISR(UART0_UDRE_vect)
#elif defined(UART_UDRE_vect)
ISR(UART_UDRE_vect)
#elif defined(USART0_UDRE_vect)
ISR(USART0_UDRE_vect)
#elif defined(USART_UDRE_vect)
ISR(USART_UDRE_vect)
#endif
{
    ats_serial_tx_vect();
}
#endif
%}
