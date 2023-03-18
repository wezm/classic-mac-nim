from std/strutils import formatFloat, ffDecimal
from std/parseutils import parseFloat

# TODO: Ideally this would be immutable
var msg = "\x03Nim" # Pascal string

proc hello_nim(): ptr byte {.exportc.} =
  return cast[ptr byte](addr msg[0])

# Convert Pascal string to Nim String
proc pascalToString(bytes: ptr byte): string =
  let len = bytes[];
  result = newString(len)
  if len > 0:
    let startPtr = cast[ptr byte](cast[ByteAddress](bytes) + 1)
    copyMem(result[0].addr, startPtr, len)

# Convert Nim String to Pascal String
proc stringToPascal(s: string, bytes: ptr byte) =
  var len: byte
  if s.len < 256:
    len = cast[byte](s.len)
  else:
    len = 255

  bytes[] = len
  if len > 0:
    let startPtr = cast[ptr byte](cast[ByteAddress](bytes) + 1)
    # unsafeAddr because s is not a var/is immutable and
    # we can't be sure it won't be mutated through the pointer
    copyMem(startPtr, s[0].unsafeAddr, len)

proc parseTemp(s: string): float =
  if parseutils.parseFloat(s, result) == 0:
    result = 0

proc convertCtoF(celciusStr: ptr byte, farenStr: ptr byte) {.exportc: "ConvertCtoF".} =
  # Convert the strings to floats
  let c = parseTemp(pascalToString(celciusStr))

  # Perform the conversion
  let f = c * 1.8f + 32.0f

  # Convert back to string
  let fStr = f.formatFloat(ffDecimal, 2)

  # Update farenStr
  stringToPascal(fStr, farenStr)

proc convertFtoC(farenStr: ptr byte, celciusStr: ptr byte) {.exportc: "ConvertFtoC".} =
  let f = parseTemp(pascalToString(farenStr))
  let c = (f - 32.0f) / 1.8f
  let cStr = c.formatFloat(ffDecimal, 2)
  stringToPascal(cStr, celciusStr)
