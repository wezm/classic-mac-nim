Classic Mac OS Nim Experiment
=============================

Transpile Nim Code
------------------

```
nim c -c --cpu:powerpc --os:any --mm:arc -d:useMalloc --skipCfg -d:release --noMain:on --nimcache:src hello.nim
```

Build AAPL
----------

```
mkdir build
cd build
cmake .. -DCMAKE_TOOLCHAIN_FILE=../../../Source/github.com/autc04/Retro68-build/toolchain/powerpc-apple-macos/cmake/retroppc.toolchain.cmake
make
```

