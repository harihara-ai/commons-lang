purpose: one-screen map of the repo for slicing and impact scans (bootstrap, at 45c5c21).

| Path | What |
| --- | --- |
| `src/main/java/org/apache/commons/lang3/*.java` | core utilities: StringUtils, ArrayUtils, CharUtils, ObjectUtils, ClassUtils, ... (63 entries) |
| `.../lang3/{builder,text,time,math,reflect,concurrent,function,stream,tuple,mutable,exception,event,compare,arch,util}` | sub-packages |
| `src/test/java/...` | JUnit 5 tests, one `<Class>Test` per class (89127 tests incl. parameterized) |
| `src/conf/` | checkstyle and PMD config |
| `src/site/`, `src/changes/changes.xml` | site and release notes |
| `pom.xml` | Maven build (human-owned) |
| `kit/`, `.claude/commands/`, `kit.manifest.yml`, `.github/` | North Star kit 1.0.4 and CI (human-owned) |
