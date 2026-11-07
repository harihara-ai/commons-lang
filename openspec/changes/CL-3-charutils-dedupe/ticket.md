# CL-3: CharUtils char overloads delegate to the int overloads

Type: refactor

## Why
`CharUtils.isAsciiNumeric(char)` and `isHex(char)` repeat the bodies of `isAsciiNumeric(int)` and `isHex(int)`
(added in 3.21.0). Two copies of each range check can drift. Pilot chore.

## What done looks like
- The char overloads call the int overloads; 2 duplicated bodies become 0.
- Results for all 65536 char values are unchanged (characterization tests).

## Not included
- `isOctal(char)` and `isOctal(byte)` (different input range); javadoc changes.
