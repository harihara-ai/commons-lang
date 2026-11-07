purpose: how this repo works today, detected by /bootstrap; each line cites its source.

- Tickets: Apache Jira, key `LANG-nnn`; branch names like `LANG-123-InputStream` (`CONTRIBUTING.md`). The fork uses the
  file tracker (`docs/ai/toolchain.md`).
- PR template: Apache checklist incl. AI disclosure and "tests fail without the change" (`.github/pull_request_template.md`).
- Review: code owners for kit, CI and build files (`.github/CODEOWNERS`); master ruleset needs a PR, code-owner review
  and the `tests` and `gate` checks (`rules/branches/master`).
- Build: Maven, Java 8 source and target (`pom.xml` `maven.compiler.source`), parent `commons-parent`; default goal
  runs rat, checkstyle, pmd, spotbugs, japicmp, javadoc (`pom.xml`, `.github/workflows/maven.yml`).
- Tests: JUnit 5 (`junit-jupiter`), easymock and mockito-inline (`pom.xml`); `src/test/java` mirrors
  `src/main/java`, one `<Class>Test` per class, base class `AbstractLangTest` (`src/test/java/.../lang3/`).
- Coverage: JaCoCo via commons-parent (`src/site/resources/profile.jacoco`), ratios line 0.96, branch 0.92 (`pom.xml`).
- Style: checkstyle and PMD rules in `src/conf/` (`pom.xml`).
- Quarantine: `docs/ai/quarantine.md` (CL-Q1, `FastDatePrinterTimeZonesTest`).
