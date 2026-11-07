purpose: characterization, measures and the refactor for CL-3 (written by /implement).

## S0 characterization
Two `CHAR:` tests in `CharUtilsTest` check all 65536 char values of `isAsciiNumeric(char)` and `isHex(char)`.
On the unchanged `CharUtils.java`: `mvn-tests.sh CharUtilsTest.java` -> exit 0 (commit `CHAR:`).

## Measure before / after (`CharUtils.java`)
| Measure | Before | After |
| --- | --- | --- |
| `ch >= '0' && ch <= '9'` bodies | 2 | 1 |
| `ch >= 'a' && ch <= 'f'` bodies | 2 | 1 |
| Duplicated method bodies (char vs int overload) | 2 | 0 |
| Lines | unchanged (2 changed, 0 added) | |

## S1 refactor
`CharUtilsTest` green after the change. Full suite with checkstyle: exit 0; 88217 tests, 0 failures, 17 skipped
(CL-Q1 quarantined).

## Out of scope noticed
- `isOctal(char)` and `isOctal(byte)` repeat the same body (different parameter types; left as planned).
