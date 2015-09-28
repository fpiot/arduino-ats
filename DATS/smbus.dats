#include "config.hats"
#include "{$TOP}/avr_prelude/kernel_staload.hats"

staload "{$TOP}/SATS/twi.sats"
staload "{$TOP}/SATS/smbus.sats"

staload "prelude/SATS/unsafe.sats"

implement send_byte (address, command) = let
  var cd: uint8 = cast{uint8}(command)
  val r1 = twi_writeTo (cast{uint8}(address), ptr2cptr (addr@cd), cast{uint8}(1), cast{uint8}(1), cast{uint8}(1))
in
  case+ 0 of
  | _ when r1 = cast{uint8}(0)  => SMBusOk
  | _ when r1 = cast{uint8}(1)  => SMBusBadLen
  | _ when r1 = cast{uint8}(2)  => SMBusNack
  | _ when r1 = cast{uint8}(3)  => SMBusOther
  | _                           => SMBusOther
end

implement write_byte (address, command, data) = let
  var bd: uint16 = cast{uint16}(data)
  var cd: uint16 = cast{uint16}(command)
  var dd: uint16 = cast{uint16}(cd + (bd << 8))
  val r1 = twi_writeTo (cast{uint8}(address), ptr2cptr (addr@dd), cast{uint8}(2), cast{uint8}(1), cast{uint8}(1))
in
  case+ 0 of
  | _ when r1 = cast{uint8}(0)  => SMBusOk
  | _ when r1 = cast{uint8}(1)  => SMBusBadLen
  | _ when r1 = cast{uint8}(2)  => SMBusNack
  | _ when r1 = cast{uint8}(3)  => SMBusOther
  | _                           => SMBusOther
end

implement write_word (address, command, data) = let
  var bd: uint32 = cast{uint32}(data)
  var cd: uint32 = cast{uint32}(command)
  var dd: uint32 = cast{uint32}(cd + (bd << 8))
  val r1 = twi_writeTo (cast{uint8}(address), ptr2cptr (addr@dd), cast{uint8}(3), cast{uint8}(1), cast{uint8}(1))
in
  case+ 0 of
  | _ when r1 = cast{uint8}(0)  => SMBusOk
  | _ when r1 = cast{uint8}(1)  => SMBusBadLen
  | _ when r1 = cast{uint8}(2)  => SMBusNack
  | _ when r1 = cast{uint8}(3)  => SMBusOther
  | _                           => SMBusOther
end

implement read_byte (address, command) = let
  var cd: uint8 = cast{uint8}(command)
  var dd: uint8 = cast{uint8}(0)
  val r1 = twi_writeTo (cast{uint8}(address), ptr2cptr (addr@cd), cast{uint8}(1), cast{uint8}(1), cast{uint8}(0))
  val cnt = twi_readFrom (cast{uint8}(address), ptr2cptr (addr@dd), cast{uint8}(1), cast{uint8}(1))
in
  case+ 0 of
  | _ when r1 = cast{uint8}(0)  => (SMBusOk, dd)
  | _ when r1 = cast{uint8}(1)  => (SMBusBadLen, cast{uint8}(0))
  | _ when r1 = cast{uint8}(2)  => (SMBusNack, cast{uint8}(0))
  | _ when r1 = cast{uint8}(3)  => (SMBusOther, cast{uint8}(0))
  | _                           => (SMBusOther, cast{uint8}(0))
end

implement read_word (address, command) = let
  var cd: uint8 = cast{uint8}(command)
  var dd: uint16 = cast{uint16}(0)
  val r1 = twi_writeTo (cast{uint8}(address), ptr2cptr (addr@cd), cast{uint8}(1), cast{uint8}(1), cast{uint8}(0))
  val cnt = twi_readFrom (cast{uint8}(address), ptr2cptr (addr@dd), cast{uint8}(2), cast{uint8}(1))
in
  case+ 0 of
  | _ when r1 = cast{uint8}(0)  => (SMBusOk, dd)
  | _ when r1 = cast{uint8}(1)  => (SMBusBadLen, cast{uint16}(0))
  | _ when r1 = cast{uint8}(2)  => (SMBusBadLen, cast{uint16}(0))
  | _ when r1 = cast{uint8}(3)  => (SMBusBadLen, cast{uint16}(0))
  | _                           => (SMBusBadLen, cast{uint16}(0))
end


implement show_smbus_status (status) =
  case+ status of
  | SMBusOk () => _
  | SMBusBadLen () => println! "SMBusBadLen"
  | SMBusNack () => println! "SMBusNack"
  | SMBusOther () => println! "SMBusOther"