#!/usr/bin/env bash
# purpose: run Maven test files (paths under src/test/java) as Surefire classes; the gate's red_check calls it.
# High-risk (CI): runs from the approved worktree, never the PR. Usage: mvn-tests.sh FILE...
set -eu
cls=""
for f in "$@"; do
  c=${f#src/test/java/}
  c=${c%.java}
  cls="${cls:+$cls,}${c//\//.}"
done
[ -n "$cls" ] || { echo "mvn-tests.sh: no test files" >&2; exit 5; }
echo "mvn-tests.sh: -Dtest=$cls" >&2
exec mvn -B -q -Drat.skip -Danimal.sniffer.skip -Djapicmp.skip -Dcheckstyle.skip -Dpmd.skip -Dspotbugs.skip \
  -Dmaven.javadoc.skip -Djacoco.skip -Dtest="$cls" -Dsurefire.failIfNoSpecifiedTests=false test
