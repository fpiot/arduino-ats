#include "config.hats"
#include "{$TOP}/avr_prelude/kernel_staload.hats"

staload "{$TOP}/SATS/arduino.sats"
staload UN = "prelude/SATS/unsafe.sats"

#define LED 9
#define DELAY_MS 10.0

typedef analog_w_t = natLt(256)

fun int_foreach_clo
  (n: analog_w_t, fwork: &analog_w_t -<clo1> void): void = {
  fun loop (l: analog_w_t, r: analog_w_t, fwork: &analog_w_t -<clo1> void):void =
    if l < r then (fwork l; loop (succ l, r, fwork))
  val () = loop (0, n, fwork)
}

implement main () = {
  fun fadein() = let
    var fwork = lam@ (n: analog_w_t) =>
      (analogWrite (LED, n); delay_ms(DELAY_MS))
  in
    int_foreach_clo(255, fwork)
  end // end of [fadein]
  (* val () = init () *)
  val () = pinMode (LED, OUTPUT)
  val () = (fix f(): void => (fadein(); f()))()
}
