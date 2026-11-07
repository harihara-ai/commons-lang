purpose: slice plan for CL-1 (G1: a human merging the plan PR approves it).

Impact scan (ctags): new `isAsciiWhitespace(char)` in `CharUtils`, next to `isAsciiControl`; no callers yet.
`CharUtils` is tested by `CharUtilsTest` (no Slice 0).

| Slice | Requirement | Scenarios | Files | Est. lines | Depends on |
| --- | --- | --- | --- | --- | --- |
| S1 | REQ-CHAR-001 | 3 | `CharUtils.java`, `CharUtilsTest.java` | 40 (estimate) | - |
