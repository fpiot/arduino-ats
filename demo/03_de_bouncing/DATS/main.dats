#include "config.hats"
#include "{$TOP}/avr_prelude/kernel_staload.hats"

staload "{$TOP}/SATS/arduino.sats"

#define LED 13
#define BUTTON 7
#define STATE_LEDOFF 0
#define STATE_LEDON  1
#define DELAY_MS 10.0

fun do_state (b: natLt(2), old_b: natLt(2), state: natLt(2)): natLt(2) =
  case+ (b, old_b) of
  | (HIGH, LOW) => if state = STATE_LEDON then STATE_LEDOFF else STATE_LEDON
  | (_, _) => state

fun do_action (state:natLt(2)): void =
  case+ state of
  | STATE_LEDON  => digitalWrite (LED, HIGH)
  | STATE_LEDOFF => digitalWrite (LED, LOW)

implement main () = {
  fun loop (old_b:natLt(2), state:natLt(2)) = {
    val b = digitalRead (BUTTON)
    val nstate = do_state (b, old_b, state)
    val () = delay_ms (DELAY_MS)
    val () = do_action nstate
    val () = loop (b, nstate)
  }
  val () = pinMode (LED, OUTPUT)
  val () = pinMode (BUTTON, INPUT)
  val () = loop (LOW, STATE_LEDOFF)
}
