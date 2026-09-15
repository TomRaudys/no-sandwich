# no-sandwich

> Living wiki for this project. Keep current. Update sections whenever something significant changes.

## What this is

A prompt, shipped as Markdown, that strips the compliment sandwich off AI replies: one or two sentences, answer first, blunt like a Dutch colleague. One canonical file (`NO-SANDWICH.md`) plus a Claude Code skill wrapper (`SKILL.md`) and a README that tells each AI where to paste it. Done means the file works pasted into any AI and the skill triggers in Claude Code.

## Status

v1 written 2026-09-15. Public at github.com/tomraudys/no-sandwich.

## Architecture

- `NO-SANDWICH.md`: the canonical rules, length table and examples. Pasteable anywhere. No frontmatter, so it appends cleanly to any rules file.
- `SKILL.md`: Claude Code skill. Frontmatter (name, description with trigger phrases), a persistence block, a "still written normally" block for code and commits, then the same rules inlined. Lives at the repo root so `git clone` straight into `~/.claude/skills/no-sandwich` works as is.
- `README.md`: the sandwich shown, the rules in one line, per AI install, the short version for boxes with a character limit, why Dutch.

No code, no build, no dependencies.

## Stack

Markdown.

## How to run

Nothing to run. To try the skill locally: `ln -s "$PWD" ~/.claude/skills/no-sandwich`, open a fresh Claude Code session, say "no sandwich".

## Decisions

- Rules are inlined in `SKILL.md` rather than referenced from `NO-SANDWICH.md`, so the skill loads with no extra file read. Cost: two copies. Change both.
- The short version lives only in the README, not in `NO-SANDWICH.md`. People curl the prompt into `CLAUDE.md` and would get the rules twice.
- Short version stays under 600 characters so it fits ChatGPT's custom instructions box (1,500 limit).
- Public repo, on Tom's instruction. The default scaffold is private.
- No em dashes or dash punctuation anywhere in the copy. A prompt about plain speech should read plainly.

## Gotchas

- Two copies of the rules exist (`NO-SANDWICH.md`, `SKILL.md`). Drift between them is the only bug this repo can really have; diff them before pushing.
- The README must obey the rules it describes. A README that sandwiches is a bug.
- `SKILL.md` frontmatter `name` must match the directory name Claude Code sees, so the clone target directory must be `no-sandwich`.

## TODO / Next

-
