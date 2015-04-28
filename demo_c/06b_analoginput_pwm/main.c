#include <Arduino.h>

#define LED 9
#define SENSOR 0
#define DELAY_MS 10

int main() {
	int v;

	init();

	pinMode(LED, OUTPUT);

	while (1) {
		v = analogRead(SENSOR);
		analogWrite(LED, v/4);
		delay(DELAY_MS);
	}

	return 0;
}
