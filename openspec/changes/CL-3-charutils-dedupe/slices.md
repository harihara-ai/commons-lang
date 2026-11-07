purpose: slice plan for CL-3 (G1: a human merging the plan PR approves it).

Impact scan (ctags, grep): `CharUtils.isAsciiNumeric(char)`, `CharUtils.isHex(char)`; both tested in `CharUtilsTest`
by examples. S0 pins every char value exhaustively before S1 changes the bodies.

| Slice | Kind | What | Files | Est. lines |
| --- | --- | --- | --- | --- |
| S0 | characterization | for all 65536 chars: isAsciiNumeric(char) is true exactly for '0'-'9'; isHex(char) exactly for '0'-'9', 'a'-'f', 'A'-'F' | `CharUtilsTest.java` | 25 (estimate) |
| S1 | refactor | char overloads return the int overloads; S0 green after the change | `CharUtils.java` | 4 (estimate) |
