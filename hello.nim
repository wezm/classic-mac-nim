# TODO: Ideally this would be immutable
var msg = "\x03Nim" # Pascal string

proc hello_nim(): ptr byte {.exportc.} =
  return cast[ptr byte](addr msg[0])
