#include "share/atspre_staload.hats"

%{^
#include <avr/io.h>
#include <util/delay.h>
%}

%{
void c_set_ddrb(char val)
{
	DDRB = val;
}

void c_set_portb(char val)
{
	PORTB = val;
}
%}

staload UN = "prelude/SATS/unsafe.sats"

#define DDRB_OUT       int2char0 0xff
#define PORTB_LEDON    int2char0 0xff
#define PORTB_LEDOFF   int2char0 0x00
#define BLINK_DELAY_MS 500.0

extern fun c_set_ddrb (v: char): void = "mac#"
extern fun c_set_portb (v: char): void = "mac#"
extern fun c_delay_ms (ms: double): void = "mac#_delay_ms"

fun loop (): void = begin
  c_set_portb (PORTB_LEDON);
  c_delay_ms (BLINK_DELAY_MS);
  c_set_portb (PORTB_LEDOFF);
  c_delay_ms (BLINK_DELAY_MS);
  loop ();
end

implement main0 () = begin
  c_set_ddrb (DDRB_OUT);
  loop ();
end
