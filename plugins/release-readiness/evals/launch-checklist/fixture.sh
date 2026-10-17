#!/usr/bin/env bash
# Copy this case's fixture app into the empty run workspace as a committed git repo.
set -euo pipefail
cp -R "$(dirname "$0")/project/." .
git init -q && git add -A
git -c user.name=eval -c user.email=eval@example.invalid commit -qm "fixture"
