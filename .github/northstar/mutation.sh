#!/usr/bin/env bash
# purpose: diff-scoped mutation testing (fix plan item 2): PIT on the classes a PR changed, scored on changed lines.
# Report only, never a gate. Run from the PR checkout after test-compile; this file comes from ../approved.
# Usage: mutation.sh BASE_SHA OUT_DIR. Writes OUT_DIR/summary.md; exit 0 unless PIT itself fails.
set -eu
base=$1; out=$(mkdir -p "$2" && cd "$2" && pwd); here=$(cd "$(dirname "$0")" && pwd)
git diff -U0 "$base" HEAD -- 'src/main/java/*.java' | python3 -I -c '
import json, re, sys
f, lines = None, {}
for line in sys.stdin:
    if line.startswith("+++ "):
        f = line[6:].strip() if line.startswith("+++ b/") else None
    m = re.match(r"@@ -\S+ \+(\d+)(?:,(\d+))? @@", line)
    if m and f:
        start, n = int(m.group(1)), int(m.group(2) or 1)
        lines.setdefault(f, []).extend(range(start, start + n))
json.dump(lines, open(sys.argv[1], "w"))' "$out/changed.json"
classes=$(python3 -I -c 'import json,sys; print(",".join(p[len("src/main/java/"):-5].replace("/", ".") for p in json.load(open(sys.argv[1]))))' "$out/changed.json")
if [ -z "$classes" ]; then
  echo "Mutation testing: no changed lines in src/main/java (nothing to mutate)." > "$out/summary.md"
  exit 0
fi
tests=$(echo "$classes" | sed 's/\([^,]*\)/\1*Test/g')
mvn -B -q -f "$here/pit-tools.xml" dependency:build-classpath -Dmdep.outputFile="$out/pit.cp"
mvn -B -q -Drat.skip -Djacoco.skip dependency:build-classpath -Dmdep.outputFile="$out/proj.cp" -Dmdep.includeScope=test
cp="$PWD/target/classes,$PWD/target/test-classes,$(tr ':' ',' < "$out/proj.cp"),$(tr ':' ',' < "$out/pit.cp")"
java -cp "$(cat "$out/pit.cp")" org.pitest.mutationtest.commandline.MutationCoverageReport --reportDir "$out/rep" \
  --targetClasses "$classes" --targetTests "$tests" --sourceDirs src/main/java --classPath "$cp" \
  --includeLaunchClasspath=false --outputFormats XML --timestampedReports=false --threads 2 > "$out/pit.log" 2>&1
python3 -I -c '
import json, sys, xml.etree.ElementTree as ET
changed = {p: set(v) for p, v in json.load(open(sys.argv[1])).items()}
rows, k, n = [], 0, 0
for m in ET.parse(sys.argv[2]).getroot():
    cls = m.findtext("mutatedClass").split("$")[0]
    path = "src/main/java/%s/%s" % ("/".join(cls.split(".")[:-1]), m.findtext("sourceFile"))
    line = int(m.findtext("lineNumber"))
    if line not in changed.get(path, ()):
        continue
    n += 1
    if m.get("status") in ("KILLED", "TIMED_OUT", "MEMORY_ERROR"):
        k += 1
    else:
        rows.append("| %s:%d | %s | %s |" % (path.split("/")[-1], line, m.findtext("description"), m.get("status")))
score = 100.0 * k / n if n else 100.0
print("### Mutation testing (changed lines, report only)\n")
print("Score **%.1f%%**: %d of %d mutants on changed lines killed. Classes: `%s`\n" % (score, k, n, sys.argv[3]))
if rows:
    print("| Line | Mutation | Status |\n| --- | --- | --- |\n" + "\n".join(rows))
' "$out/changed.json" "$out/rep/mutations.xml" "$classes" > "$out/summary.md"
cat "$out/summary.md"
