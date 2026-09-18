#!/usr/bin/env bash
# SKILL.md = skill-head.md + NO-SANDWICH.md without its title line.
# Edit those two, never SKILL.md. Run this after either changes.
set -euo pipefail
cd "$(dirname "$0")"
head -1 NO-SANDWICH.md | grep -q '^# ' || { echo "NO-SANDWICH.md must start with its title line" >&2; exit 1; }
{ cat skill-head.md; tail -n +3 NO-SANDWICH.md; } > SKILL.md
echo "SKILL.md rebuilt: $(wc -l < SKILL.md | tr -d ' ') lines"
