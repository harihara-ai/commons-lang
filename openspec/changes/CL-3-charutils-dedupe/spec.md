# Change: CL-3-charutils-dedupe
Ticket: CL-3
Type: refactor

## Problem
`isAsciiNumeric(char)` (`ch >= '0' && ch <= '9'`) and `isHex(char)` (digits, `a`-`f`, `A`-`F`) have the same bodies
as their `int` overloads: 2 duplicated expressions in `CharUtils.java`.

## Outcome
Goal: `isAsciiNumeric(char)` returns `isAsciiNumeric((int) ch)` and `isHex(char)` returns `isHex((int) ch)`;
duplicated range expressions go from 2 to 0; results for every char value (0 to 65535) are unchanged.
Non-goal: any change in which characters match, or in the int overloads.

## Requirements
none (refactor: behaviour is pinned by characterization tests)

## Non-functional
none

## Out of scope
`isOctal`, the other `CharUtils` methods, javadoc.

## Assumptions
A char widens to the same int value, so delegation cannot change results; the characterization tests check it.

## Open questions
none
