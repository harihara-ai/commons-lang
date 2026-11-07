purpose: slice plan for CL-2 (G1: a human merging the plan PR approves it).

Impact scan (ctags, grep): `BitField.getValue(long)`; no callers in `src/main/java`. Tests: `BitFieldTest`,
`BitFieldLongTest`. Fix spike (`>>` to `>>>`) before this plan: both test classes pass unchanged, so no existing
test pins the bug (pilot finding P04 applied).

| Slice | Requirement | Scenarios | Files | Est. lines | Depends on |
| --- | --- | --- | --- | --- | --- |
| S1 | REQ-BIT-001 | 3 | `BitField.java`, `BitFieldLongTest.java` | 30 (estimate) | - |
