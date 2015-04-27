#include <Arduino.h>

#define LED 13
#define BUTTON 7

int main() {
	int button;

	init();

	pinMode(LED, OUTPUT);
	pinMode(BUTTON, INPUT);

	while(1) {
		button = digitalRead(BUTTON);
		if (HIGH == button) {
			digitalWrite(LED, HIGH);
		} else {
			digitalWrite(LED, LOW);
		}
	}

	return 0;
}
