# Change: CL-2-bitfield-top-bit
Ticket: CL-2
Type: bug

## Problem
`new BitField(0xF000000000000000L).getValue(-1L)` returns -1 instead of 15, because `getValue(long)` shifts the raw
bits with `>>` (sign-extending). Any field whose mask includes bit 63 reads back negative.

## Outcome
`getValue(long)` returns the field's bits shifted right with zero fill (`>>>`), so values are 0 to 2^n - 1 for an
n-bit field, including fields that end at bit 63.

## Requirements

### REQ-BIT-001: getValue(long) returns the unsigned field value
Errors: none
Scenario: happy - top 4 bits
  Given a BitField with mask 0xF000000000000000L
  When getValue(-1L) is called
  Then the result is 15
  Level: unit
Scenario: happy - bit 63 alone
  Given a BitField with mask 0x8000000000000000L
  When getValue(0x8000000000000000L) is called
  Then the result is 1
  Level: unit
Scenario: happy - setValue then getValue round trip
  Given a BitField with mask 0xF000000000000000L
  When getValue(setValue(0L, v)) is called for each v from 0 to 15
  Then each result is v
  Level: unit

## Non-functional
none

## Out of scope
The int and short methods (`getValue(int)`, `getShortValue`), which keep their behaviour since 2.0.

## Assumptions
`getValue(long)` is unreleased (`@since 3.21.0`), so changing its result for bit-63 fields breaks no released API.
A fix spike passed `BitFieldTest` and `BitFieldLongTest` unchanged; no main code calls `BitField`.

## Open questions
none
