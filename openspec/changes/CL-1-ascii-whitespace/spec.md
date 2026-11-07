# Change: CL-1-ascii-whitespace
Ticket: CL-1
Type: story

## Problem
`CharUtils` has no ASCII whitespace check. `Character.isWhitespace(' ')` is true, so a caller that wants only
ASCII whitespace must list the characters by hand.

## Outcome
`CharUtils.isAsciiWhitespace(char)` returns true for exactly 6 characters: space (32), tab (9), line feed (10),
vertical tab (11), form feed (12) and carriage return (13); false for the other 65530 char values.

## Requirements

### REQ-CHAR-001: isAsciiWhitespace accepts the 6 ASCII whitespace characters only
Errors: none
Scenario: happy - each ASCII whitespace character
  Given the characters ' ', '\t', '\n', '\u000B', '\f' and '\r'
  When CharUtils.isAsciiWhitespace is called on each
  Then each call returns true
  Level: unit
Scenario: happy - Unicode whitespace is not ASCII whitespace
  Given the characters ' ', ' ' and '\u001C'
  When CharUtils.isAsciiWhitespace is called on each
  Then each call returns false
  Level: unit
Scenario: happy - every other char value is rejected
  Given every char value from 0 to 65535 except the 6 above
  When CharUtils.isAsciiWhitespace is called on each
  Then each call returns false
  Level: unit

## Non-functional
none

## Out of scope
An `int` code point overload, `StringUtils` whitespace methods, release notes in `src/changes/changes.xml`.

## Assumptions
The method is `public static`, `@since 3.21.0` (the current SNAPSHOT version in `pom.xml`).

## Open questions
none
