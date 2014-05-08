%{^
#include <avr/io.h>
#include <util/delay.h>
%}

%{
enum {
	BLINK_DELAY_MS = 500,
};

void c_set_ddrb(char val)
{
	DDRB = val;
}

void c_set_portb(char val)
{
	PORTB = val;
}

void c_blink(void)
{
	while(1) {
		/* set PORTB high to turn led on */
		PORTB = 0xFF;
		_delay_ms(BLINK_DELAY_MS);
		/* set PORTB low to turn led off */
		PORTB = 0x00;
		_delay_ms(BLINK_DELAY_MS * 2);
	}
}
%}

#define DDRB_OUT       int2char0 0xff
#define PORTB_LEDON    int2char0 0xff
#define PORTB_LEDOFF   int2char0 0x00
#define BLINK_DELAY_MS 500.0

extern fun c_set_ddrb (v: char): void = "mac#"
extern fun c_delay_ms (ms: double): void = "mac#_delay_ms"
extern fun c_blink (): void = "mac#"


implement main0 () = () where {
  val () = c_set_ddrb (DDRB_OUT)
  val () = c_delay_ms (BLINK_DELAY_MS)
  val () = c_blink ()
}
