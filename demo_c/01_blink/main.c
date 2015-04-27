#include <Arduino.h>

#define LED 13
#define BLINK_DELAY_MS 500

int main() {
	pinMode(LED, OUTPUT);

	while(1) {
		digitalWrite(LED, HIGH);
		delay(BLINK_DELAY_MS);
		digitalWrite(LED, HIGH);
		delay(BLINK_DELAY_MS);
	}

	return 0;
}
