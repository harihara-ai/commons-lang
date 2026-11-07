# CL-2: BitField.getValue(long) returns -1 for fields that include bit 63

Type: bug

## Why
Found in the pilot bug hunt (2026-11-07) in API new in 3.21.0 (unreleased). `new BitField(0xF000000000000000L)
.getValue(-1L)` returns -1, not 15, and `getValue(setValue(0L, 15L))` returns -1. Cause: `getValue(long)` uses `>>`,
which copies bit 63 into the shifted value.

## What done looks like
- `new BitField(0xF000000000000000L).getValue(-1L)` is 15; a 1-bit field at bit 63 gives 1.

## Not included
- The int methods (`getValue(int)` with mask bit 31 set), unchanged since 2.0.
