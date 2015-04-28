#include <Arduino.h>

#define LED 13
#define SENSOR 0

int main() {
	int w;

	init();

	pinMode(LED, OUTPUT);

	while (1) {
		w = analogRead(SENSOR);
		digitalWrite(LED, HIGH);
		delay(w);
		digitalWrite(LED, LOW);
		delay(w);
	}

	return 0;
}
