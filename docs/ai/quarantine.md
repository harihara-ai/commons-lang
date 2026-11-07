purpose: tests taken out of the suite until fixed (kit/playbooks/safety-net.md); each has a ticket and a reason.

| Test | Ticket | Reason | Since |
| --- | --- | --- | --- |
| `org.apache.commons.lang3.time.FastDatePrinterTimeZonesTest` (class, `@Disabled`) | CL-Q1 | 9 cases fail on the GitHub runner (Temurin 21): SimpleDateFormat says MDT/CDT/PDT, FastDateFormat MST/CST/PST, for US zones on 2026-11-07. Passed locally (OpenJDK 21.0.12). Machine-dependent (JDK zone data), not a kit change. Baseline run 42386280045 | 2026-11-07 |

Exit: find the zones and JDK cause, fix or pin the JDK, remove `@Disabled`, and see the class pass in CI.
