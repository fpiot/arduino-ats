#include "share/atspre_staload.hats"

%{^
// #include <avr/io.h>
#include <util/delay.h>
#include "Arduino.h"
#include "hardware_serial.h"
%}

staload UN = "prelude/SATS/unsafe.sats"

#define DDRB_OUT       int2char0 0xff
#define PORTB_LEDON    int2char0 0xff
#define PORTB_LEDOFF   int2char0 0x00
#define BLINK_DELAY_MS 500.0

abst@ype hardware_serial = $extype"struct hardware_serial"

macdef DDRB_PTR  = $extval(ptr, "(0x04 + 0x20)") (* Only for Arduino Mega 2560 *)
macdef PORTB_PTR = $extval(ptr, "(0x05 + 0x20)") (* Only for Arduino Mega 2560 *)
macdef hserial   = $extval(cPtr0(hardware_serial), "(&Serial)")

extern fun c_delay_ms:            (double)                        -> void   = "mac#_delay_ms"
extern fun hardware_serial_begin: (cPtr0(hardware_serial), ulint) -> void   = "mac#"
extern fun hardware_serial_write: (cPtr0(hardware_serial), char)  -> size_t = "mac#"
extern fun hardware_serial_flush: (cPtr0(hardware_serial))        -> void   = "mac#"
extern fun interrupts:            ()                              -> void   = "mac#"
extern fun nointerrupts:          ()                              -> void   = "mac#"

implement main0 () = {
  fun loop () = {
    val () = $UN.ptr0_set<char> (PORTB_PTR, PORTB_LEDON)
    val () = c_delay_ms (BLINK_DELAY_MS)
    val () = $UN.ptr0_set<char> (PORTB_PTR, PORTB_LEDOFF)
    val () = c_delay_ms (BLINK_DELAY_MS)
    val _  = hardware_serial_write (hserial, 'Q')
    val _  = hardware_serial_write (hserial, '\n')
    val () = hardware_serial_flush (hserial)
    val () = loop ()
  }
  val () = $UN.ptr0_set<char> (DDRB_PTR, DDRB_OUT)
  val () = interrupts ()
  val () = hardware_serial_begin (hserial, 9600UL)
  val () = loop ()
}
