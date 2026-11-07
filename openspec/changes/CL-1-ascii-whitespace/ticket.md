# CL-1: CharUtils.isAsciiWhitespace(char)

Type: story

## Why
`CharUtils` has `isAsciiAlpha`, `isAsciiNumeric`, `isAsciiControl` and more, but no ASCII whitespace test. Callers use
`Character.isWhitespace`, which also accepts Unicode separators such as U+2003 (EM SPACE) and U+001C. Pilot story.

## What done looks like
- `CharUtils.isAsciiWhitespace(char)` is true for exactly the 6 characters space, `\t`, `\n`, `\u000B`, `\f`, `\r`.

## Not included
- An `int` code point overload; `StringUtils` changes.
