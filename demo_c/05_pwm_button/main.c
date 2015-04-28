#include <Arduino.h>

#define LED 9
#define BUTTON 7
#define DELAY_MS 10

struct state_dat {
	int state;
	int brightness;
	int start_time;
};
#define STATE_LEDOFF 0
#define STATE_LEDON  1

void do_state(int button, int button_old, struct state_dat *state) {
	if ((HIGH == button) && (LOW == button_old)) {
		state->state = 1 - state->state;
		state->start_time = millis();
	} else if ((HIGH == button) && (HIGH == button_old)) {
		if (STATE_LEDON == state->state && (millis() - state->start_time) > 500) {
			state->brightness++;
		}
		if (state->brightness > 255) {
			state->brightness = 0;
		}
	}
}

void do_action(struct state_dat *state) {
	if (STATE_LEDON == state) {
		analogWrite(LED, state->brightness);
	} else {
		analogWrite(LED, 0);
	}
}

int main() {
	struct state_dat state = { STATE_LEDOFF, 128, 0 };
	int button = LOW;
	int button_old = LOW;

	init();

	pinMode(LED, OUTPUT);
	pinMode(BUTTON, INPUT);

	while (1) {
		button = digitalRead(BUTTON);
		do_state(button, button_old, &state);
		button_old = button;
		delay(DELAY_MS);
		do_action(&state);
	}

	return 0;
}
