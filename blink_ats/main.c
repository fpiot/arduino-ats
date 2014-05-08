#include <avr/io.h>
#include <util/delay.h>
 
enum {
	BLINK_DELAY_MS = 500,
};
 
int main (void)
{
	/* set PORTB for output*/
	DDRB = 0xFF;
 
	while(1) {
		/* set PORTB high to turn led on */
		PORTB = 0xFF;
		_delay_ms(BLINK_DELAY_MS);
		/* set PORTB low to turn led off */
		PORTB = 0x00;
		_delay_ms(BLINK_DELAY_MS * 2);
	}

	return 0;
}
