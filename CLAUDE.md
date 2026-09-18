# no-sandwich

> Living wiki for this project. Keep current. Update sections whenever something significant changes.

## What this is

A prompt, shipped as Markdown, with two jobs. (1) **Blunt answers**: strips the compliment sandwich off AI replies. One or two sentences, answer first, like a Dutch colleague. (2) **Translate**: the user pastes a wall of Slack, HR, recruiter or client text and gets what the sender actually means, in three lines at most. One canonical file (`NO-SANDWICH.md`), a generated Claude Code skill (`SKILL.md`) and a README that tells each AI where to paste it. Done means the file works pasted into any AI and the skill triggers in Claude Code.

## Status

v2 2026-09-18: Translate added, `SKILL.md` now generated. v1 2026-09-15. Public at github.com/tomraudys/no-sandwich. Installed on Tom's machine as a symlink (`~/.claude/skills/no-sandwich` points at this folder), and Claude Code hot reloads it, so a rebuilt `SKILL.md` is live in his sessions at once.

## Architecture

- `NO-SANDWICH.md`: the canonical prompt. Rules, length table, examples, then the Translate section (format, translate rules, the table of usual codes, translate examples). No frontmatter, so it appends cleanly to any rules file.
- `skill-head.md`: the Claude only wrapper. Frontmatter (name, description with trigger phrases for both uses), the "two uses" block that tells mode from translate, and the "still written normally" line for code and commits.
- `SKILL.md`: GENERATED. `skill-head.md` plus `NO-SANDWICH.md` minus its title line. Committed, because a plain `git clone` into `~/.claude/skills/no-sandwich` has to work with no build step. Never edit by hand.
- `build.sh`: the generator. Eight lines of bash.
- `README.md`: the sandwich shown, the translator shown, per AI install, the short version for boxes with a character limit, why Dutch.

No dependencies.

## Stack

Markdown and one bash script.

## How to run

`./build.sh` after editing `NO-SANDWICH.md` or `skill-head.md`.

**Testing a prompt change**: run it on a weaker model than the one you write with, against messages that are NOT in the prompt's own examples. A subagent on Haiku told to treat `NO-SANDWICH.md` as its system prompt and answer a numbered list of user messages works well. Every test set needs the four "do not invent subtext" checks: plain logistics, sincere praise, a harmless message that contains a code phrase from the table ("quick sync"), and one ordinary question to prove blunt mode still works. When a failing case gets promoted into the prompt as an example, it is burned as a test: write a fresh one for the same path.

## Decisions

- **One skill, two uses, not a second skill.** A second skill means a second install and a third copy of the rules, and on every other AI it is one pasted file anyway. The header tells the uses apart: bare `/no-sandwich` or "be blunt" turns the mode on; `/no-sandwich <pasted text>` or "translate this" translates once.
- **Translating does not switch the mode on.** Someone decoding one Slack message did not ask for a blunt session.
- **The label is "Missing", not "Dodges".** A message can omit the severance figure without anyone dodging. Neutral and accurate beats punchy.
- **Confidence markers live in the format line, not only in a rule.** "Probably" when the words only imply it, "It doesn't say" when they say nothing. The first cut had this as rule 3 alone and Haiku ignored it: it turned a vague leadership announcement into "changes were made" and stated an implied performance plan as fact. Putting the markers where the model composes the Means line fixed it.
- **Means leads with the main thing, good or bad.** A job offer with no numbers came back as "the base is likely low" and never said "you got the offer". The cause was a `competitive salary = low` row in the table, which was removed: a missing number belongs in Missing with its question, not in a cynical gloss.
- **A reading that comes from the table and not from the words starts with "Probably".** "Going forward" came back as the flat claim "you sent an email without approval", which the message never said.
- **No commentary on the sender, and never in the sender's voice.** A cost cut came back as "despite claiming to care about your growth". Rule 8 (no sneering) has to be restated inside Translate or a weaker model treats the pasted message as fair game.
- **The question in Missing is written out in quotes.** "Ask for feedback" is advice; "What decided it: price, scope or someone else?" is something the user can send.
- **The table of codes is calibration, not a lookup.** It carries its own caveat and an example of a harmless "quick sync", because the failure that matters most is telling someone they are in trouble over a lunch invite.
- `SKILL.md` is generated rather than hand synced. With Translate the shared body passed 100 lines, and drift between two copies was the one bug this repo could have.
- The short version lives only in the README, not in `NO-SANDWICH.md`. People curl the prompt into `CLAUDE.md` and would get the rules twice. It stays under 1,000 characters to fit ChatGPT's custom instructions box (1,500 limit).
- Public repo, on Tom's instruction. The default scaffold is private.
- No em dashes or dash punctuation anywhere in the copy. A prompt about plain speech should read plainly.

## Gotchas

- The skill `description` in `skill-head.md` is a YAML plain scalar: a colon followed by a space inside it breaks the frontmatter. Use full stops. It must also stay under 1,024 characters.
- Example outputs are Markdown lists with a blank line after the pasted text. Bare lines separated by single newlines collapse into one paragraph on GitHub.
- `build.sh` drops the first two lines of `NO-SANDWICH.md` (title plus blank). Keep the title on line 1.
- `SKILL.md` frontmatter `name` must match the directory name Claude Code sees, so the clone target directory must be `no-sandwich`.
- The README must obey the rules it describes. A README that sandwiches is a bug.
- The README shows a subset of the code table. The full one is in `NO-SANDWICH.md`; change it there first.

## TODO / Next

- Reverse direction (blunt draft in, sendable corporate message out), only if someone asks for it.
