#include <Arduino.h>

#define LED 9
#define DELAY_MS 10

int main() {
	int i;

	init();

	pinMode(LED, OUTPUT);

	while (1) {
		for (i = 0; i < 255; i++) {
			analogWrite(LED, i);
			delay(DELAY_MS);
		}
		for (i = 255; i > 0; i--) {
			analogWrite(LED, i);
			delay(DELAY_MS);
		}
	}

	return 0;
}
