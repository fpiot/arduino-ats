fun serial_begin:     (ulint) -> void
fun serial_write:     (char)  -> size_t
fun serial_flush:     ()      -> void
fun serial_available: ()      -> uint
fun serial_peek:      ()      -> int
fun serial_read:      ()      -> int
fun serial_end:       ()      -> void
