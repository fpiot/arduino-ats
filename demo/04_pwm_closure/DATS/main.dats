#include "config.hats"
#include "{$TOP}/avr_prelude/kernel_staload.hats"

staload "{$TOP}/SATS/arduino.sats"
staload UN = "prelude/SATS/unsafe.sats"

#define LED 9
#define DELAY_MS 10.0

fun int_foreach_clo
  (n: int, f: &int -<clo1> void): void = {
  val () = f n
  val () = int_foreach_clo (n - 1, f)
}

implement main () = {
  fun fadein() = let
    var fwork = lam@ (n: int) => {
      val () = analogWrite (LED, $UN.cast n)
      val () = delay_ms(DELAY_MS)
    }
  in
    int_foreach_clo(256, fwork)
  end // end of [fadein]
  val () = pinMode (LED, OUTPUT)
  val () = (fix f(): void => (fadein(); f()))()
}
