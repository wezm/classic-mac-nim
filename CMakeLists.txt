add_application(Dialog
    src/@m..@s..@s..@s..@susr@slib@snim@spure@sparseutils.nim.c
    src/@m..@s..@s..@s..@susr@slib@snim@spure@sstrutils.nim.c
    src/@m..@s..@s..@s..@susr@slib@snim@sstd@sprivate@sdigitsutils.nim.c
    src/@m..@s..@s..@s..@susr@slib@snim@ssystem.nim.c
    src/@m..@s..@s..@s..@susr@slib@snim@ssystem@sdollars.nim.c
    src/@m..@s..@s..@s..@susr@slib@snim@ssystem@sio.nim.c
    src/@mhello.nim.c
    dialog.c
    dialog.r
   )

 target_include_directories(Dialog PRIVATE /usr/lib/nim)

    # make the result as small as possible
    # by removing unused code (gc-sections)
    # and by removing macsbug function names on 68K
    # (don't do this when debugging...)
    set_target_properties(Dialog PROPERTIES COMPILE_OPTIONS "-ffunction-sections;-Werror-implicit-function-declaration")
if(CMAKE_SYSTEM_NAME MATCHES Retro68)
  set_target_properties(Dialog PROPERTIES LINK_FLAGS "-Wl,-gc-sections -Wl,--mac-strip-macsbug")
else()
  set_target_properties(Dialog PROPERTIES LINK_FLAGS "-Wl,-gc-sections")
endif()
