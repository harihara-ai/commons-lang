purpose: test and coverage baseline at bootstrap (45c5c21).

- Command: `mvn $MVN_FLAGS test jacoco:report` (flags in `.github/workflows/northstar-ci.yml`: rat, animal-sniffer,
  japicmp, checkstyle, pmd, spotbugs, javadoc skipped; JaCoCo ratios not enforced).
- Counts (local, before CL-Q1): 89127 tests, 0 failures, 16 skipped, 204 s; JaCoCo total 96.57% (line-based, 216 files).
- CI: first baseline run 42386280045 failed 9 tests in `FastDatePrinterTimeZonesTest` (runner JDK); quarantined
  (CL-Q1); baseline run 42387375318 on `45c5c21` passed, artifact `coverage-baseline` (jacoco.xml).
