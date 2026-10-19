#!/usr/bin/env bash
# Behavior test for bin/skills-sync against a synthetic two-skill library. No network, no model.
# Usage: tests/skills-sync-test.sh [workdir]   (CI runs it on every push and pull request)
set -uo pipefail
SYNC="$(cd "$(dirname "$0")/.." && pwd)/bin/skills-sync"
W=${1:-$(mktemp -d)}; rm -rf "$W" && mkdir -p "$W"
g() { git -c user.email=t@example.invalid -c user.name=t "$@"; }
skill() { # skill <name> <marker>
  mkdir -p "plugins/$1/skills/$1/references"
  printf -- '---\nname: %s\ndescription: Test skill %s.\nmetadata:\n  version: "%s"\n---\n\nMarker: %s\n' "$1" "$1" "$2" "$2" > "plugins/$1/skills/$1/SKILL.md"
  echo "reference" > "plugins/$1/skills/$1/references/notes.md"
}

LIB=$W/lib; mkdir -p "$LIB" && cd "$LIB" && git init -q
skill alpha 1.0.0; skill beta 1.0.0; g add -A && g commit -qm v1 && git branch stable
skill alpha 1.1.0; g commit -qam "alpha 1.1.0"
URL="file://$LIB"

new_consumer() { rm -rf "$W/$1" && mkdir -p "$W/$1" && cd "$W/$1" && git init -q && echo x > README.md && g add -A && g commit -qm init; }
commit() { g add -A && g commit -qm "$1"; }
marker() { sed -n 's/^Marker: //p' .claude/skills/alpha/SKILL.md; }
FAILED=0; pass() { echo "PASS $*"; }; fail() { echo "FAIL $*"; FAILED=1; }

new_consumer a
"$SYNC" sync --lib "$URL" alpha beta >/dev/null && commit "skills: sync stable"
[ -f .claude/skills/alpha/SKILL.md ] && [ -f .claude/skills/alpha/references/notes.md ] && pass "files land in .claude/skills/<skill>/" || fail layout
[ "$(awk '!/^#/' .claude/skills.lock | wc -l | tr -d ' ')" = 2 ] && pass "lock has one line per skill" || fail lock
"$SYNC" check >/dev/null && pass "check is clean after sync" || fail "check after sync"
[ "$(marker)" = 1.0.0 ] && pass "sync takes stable, not the branch tip" || fail "pinned: $(marker)"
"$SYNC" status >/dev/null && pass "status: up to date before a release" || fail "status before release"

git -C "$LIB" branch -f stable HEAD   # release: stable moves to alpha 1.1.0
[ "$(marker)" = 1.0.0 ] && pass "consumer unchanged until it re-syncs" || fail unchanged
out=$("$SYNC" status); [ $? = 1 ] && echo "$out" | grep -q "^BEHIND  alpha 1.0.0 -> 1.1.0" && echo "$out" | grep -q "^ok      beta" \
  && pass "status: alpha BEHIND, beta ok after stable moves" || fail "status after release: $out"
"$SYNC" sync >/dev/null && commit "skills: sync stable"
[ "$(marker)" = 1.1.0 ] && pass "re-sync with no arguments upgrades every locked skill" || fail "upgrade: $(marker)"
g revert --no-edit HEAD >/dev/null; [ "$(marker)" = 1.0.0 ] && "$SYNC" check >/dev/null && pass "rollback by git revert leaves check clean" || fail rollback

echo "hand edit" >> .claude/skills/alpha/SKILL.md
"$SYNC" check >/dev/null; [ $? = 1 ] && pass "check fails on an uncommitted hand edit" || fail "uncommitted edit"
commit "hand edit"; "$SYNC" check >/dev/null; [ $? = 1 ] && pass "check fails on a committed hand edit" || fail "committed edit"
"$SYNC" sync >/dev/null 2>&1; [ $? != 0 ] && pass "sync refuses to overwrite a hand edit" || fail "sync overwrote edit"
"$SYNC" sync --force >/dev/null && commit resync && "$SYNC" check >/dev/null && pass "sync --force restores the copy" || fail force

"$SYNC" sync --ref "$(git -C "$LIB" rev-parse stable~1)" alpha >/dev/null && commit pin
[ "$(marker)" = 1.0.0 ] && [ "$(awk '$1=="beta"' .claude/skills.lock | wc -l | tr -d ' ')" = 1 ] && pass "pin one skill to an older commit; other lock lines kept" || fail pin
"$SYNC" remove beta >/dev/null && commit rm
[ ! -e .claude/skills/beta ] && ! grep -q beta .claude/skills.lock && "$SYNC" check >/dev/null && pass "remove deletes folder and lock line" || fail remove
"$SYNC" sync nope >/dev/null 2>&1; [ $? = 2 ] && pass "an unknown skill is an error" || fail unknown

"$SYNC" sync --ref stable alpha >/dev/null && commit "track stable again"
git -C "$LIB" rm -rq plugins/alpha && g -C "$LIB" commit -qm "drop alpha" && git -C "$LIB" branch -f stable HEAD
out=$("$SYNC" status); [ $? = 1 ] && echo "$out" | grep -q "^GONE    alpha" && pass "status: GONE when the library drops a skill" || fail "status gone: $out"
mkdir -p sub/dir && cd sub/dir && "$SYNC" check >/dev/null && pass "works from a subdirectory" || fail subdir

echo "bash $BASH_VERSION"; exit $FAILED
