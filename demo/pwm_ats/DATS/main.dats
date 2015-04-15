#include "config.hats"
#include "{$TOP}/avr_prelude/kernel_staload.hats"

staload "{$TOP}/SATS/arduino.sats"
staload UN = "prelude/SATS/unsafe.sats"

#define LED 9
#define BLINK_DELAY_MS 10.0

implement main () = {
  fun loop_fadein {n:nat | n <= 255} .<255 - n>. (i: int n): void = {
    val () = analogWrite ($UN.cast LED, i)
    val () = delay_ms (BLINK_DELAY_MS)
    val () = if i < 255 then loop_fadein (i + 1)
  }
  fun loop_fadeout {n:nat | n <= 255} .<n>. (i: int n): void = {
    val () = analogWrite ($UN.cast LED, i)
    val () = delay_ms (BLINK_DELAY_MS)
    val () = if i > 0 then loop_fadeout (i - 1)
  }
  fun forever () = {
    val () = loop_fadein 0
    val () = loop_fadeout 255
    val () = forever ()
  }
  val () = pinMode ($UN.cast LED, OUTPUT)
  val () = forever ()
}
