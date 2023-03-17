
Transpile Nim Code
------------------

```
nim c -c --cpu:powerpc --os:any --mm:arc -d:useMalloc --skipCfg -d:release --noMain:on --nimcache:src hello.nim
```
