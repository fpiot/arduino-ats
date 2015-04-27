#include <Arduino.h>

#define LED 13
#define BUTTON 7
#define STATE_LEDOFF 0
#define STATE_LEDON  1
#define DELAY_MS 10

int do_state(int button, int button_old, int state) {
	if ((HIGH == button) && (LOW == button_old)) {
		state = 1 - state;
	}
	return state;
}

void do_action(int state) {
	if (STATE_LEDON == state) {
		digitalWrite(LED, HIGH);
	} else {
		digitalWrite(LED, LOW);
	}
}

int main() {
	int button = LOW;
	int button_old = LOW;
	int state = STATE_LEDOFF;

	init();

	pinMode(LED, OUTPUT);
	pinMode(BUTTON, INPUT);

	while(1) {
		button = digitalRead(BUTTON);
		state = do_state(button, button_old, state);
		button_old = button;
		delay(DELAY_MS);
		do_action(state);
	}

	return 0;
}
