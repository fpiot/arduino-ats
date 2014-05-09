#include "share/atspre_staload.hats"

%{^
// #include <avr/io.h>
#include <util/delay.h>
%}

staload UN = "prelude/SATS/unsafe.sats"

#define DDRB_OUT       int2char0 0xff
#define PORTB_LEDON    int2char0 0xff
#define PORTB_LEDOFF   int2char0 0x00
#define BLINK_DELAY_MS 500.0

macdef DDRB_PTR  = $extval(ptr, "(0x04 + 0x20)") (* Only for Arduino Mega 2560 *)
macdef PORTB_PTR = $extval(ptr, "(0x05 + 0x20)") (* Only for Arduino Mega 2560 *)

(*
xxx Hongwei comment xxx

https://github.com/githwxi/ATS-Postiats/issues/3#issuecomment-42682765

Maybe it makes sense to introduce an abstract type here:

abstype PORTBval_t = int8
macdef PORTB_LEDON = $extval(PORTBval_t, "0xff")
macdef PORTB_LEDOFF = $extval(PORTBval_t, "0xff")

PORTB_get and PORTB_set can be implemented as templates:

extern
fun{} PORTB_get (): PORTBval_t
extern
fun{} PORTB_set (v: PORTBval_t): void

This will allow you to re-implement them for different chip models.
*)

extern fun c_delay_ms (ms: double): void = "mac#_delay_ms"

implement main0 () = {
  fun loop (): void = {
    val () = $UN.ptr0_set<char> (PORTB_PTR, PORTB_LEDON)
    val () = c_delay_ms (BLINK_DELAY_MS)
    val () = $UN.ptr0_set<char> (PORTB_PTR, PORTB_LEDOFF)
    val () = c_delay_ms (BLINK_DELAY_MS)
    val () = loop ()
  }
  val () = $UN.ptr0_set<char> (DDRB_PTR, DDRB_OUT)
  val () = loop ()
}
