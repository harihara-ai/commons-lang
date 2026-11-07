purpose: RED then GREEN for CL-2 (written by /implement).

## S1 REQ-BIT-001
RED: `bash .github/northstar/mvn-tests.sh .../BitFieldLongTest.java` -> exit 1; 16 run, 3 failures:
expected 1 but was -1 (bit 63), expected 8 but was -8 and expected 15 but was -1 (round trip, top 4 bits).
Root cause: `getValue(long)` returned `getRawValue(holder) >> shiftCount`; `>>` copies bit 63 into the result.
Fix: `>>>` (zero fill) in `getValue(long)` only.
GREEN: `BitFieldLongTest` and `BitFieldTest` -> exit 0. Full suite with checkstyle: exit 0; 88215 tests, 0 failures,
17 skipped (CL-Q1 quarantined).

## Out of scope noticed
- `getValue(int)` with a mask that has bit 31 set returns -1 for that bit (`new BitField(0x80000000).getValue(0x80000000)`),
  behaviour since 2.0; a separate ticket if wanted.
