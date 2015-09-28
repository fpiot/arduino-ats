datatype smbus_status =
  | SMBusOk of ()
  | SMBusBadLen of ()
  | SMBusNack of ()
  | SMBusOther of ()

fun send_byte (address: uint8, command: uint8): smbus_status
fun write_byte (address: uint8, command: uint8, data: uint8): smbus_status
fun write_word (address: uint8, command: uint8, data: uint16): smbus_status

fun read_byte (address: uint8, command: uint8): (smbus_status, uint8)
fun read_word (address: uint8, command: uint8): (smbus_status, uint16)

fun show_smbus_status (status: smbus_status): void