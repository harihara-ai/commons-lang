purpose: RED then GREEN for CL-1 (written by /implement).

## S1 REQ-CHAR-001
RED: `bash .github/northstar/mvn-tests.sh src/test/java/org/apache/commons/lang3/CharUtilsTest.java` -> exit 1,
test compile error "cannot find symbol" (`CharUtils.isAsciiWhitespace`) at the three new tests.
GREEN: after `isAsciiWhitespace(char)` in `CharUtils.java` (`ch == ' ' || ch >= '\t' && ch <= '\r'`) -> exit 0.
Full suite with checkstyle: `mvn ... checkstyle:check test jacoco:report` -> exit 0; 88215 tests, 0 failures,
17 skipped (CL-Q1 quarantined); JaCoCo total 96.57%.

## Out of scope noticed
- `src/changes/changes.xml` has no entry for the new method (release notes were out of scope).
