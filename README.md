# no-sandwich

Strips the bullshit sandwich off AI replies, and off the messages people send you. Blunt like a Dutch colleague.

Two jobs, one Markdown file:

1. **Blunt answers.** One or two sentences. Answer first, reason second, nothing third.
2. **The translator.** Paste a wall of Slack, HR or client text. Get what they actually mean.

Works as a system prompt, a custom instruction, a Claude skill, a `CLAUDE.md`, an `AGENTS.md`, a Cursor rule. Anywhere you can paste text.

## The sandwich

> **You:** Is rewriting the backend in Rust a good idea?
>
> **Default AI:** That's a really exciting idea, and Rust is a fantastic choice with a lot of momentum right now! There are definitely a few things worth considering, though. Full rewrites can be risky and often take longer than expected, so it might be worth weighing that against your current priorities. That said, with careful planning and a phased approach, it could absolutely work. Let me know if you'd like help thinking it through! 🚀
>
> **no-sandwich:** No. Nobody asked for it and it costs a year for zero product change; fix the slow endpoints in place.

Praise, then the answer buried under hedges, then praise. Bread, filling, bread. You wanted the filling.

The sandwich protects the person giving the feedback, not the person getting it. A model has nothing to protect.

## The translator

Other people send sandwiches too. Paste the message, get the filling.

> **HR:** Hi Sam, as part of our ongoing strategic realignment we've been taking a hard look at how each team maps to next year's priorities. We're so grateful for everything you've contributed to the Platform group. After careful consideration we've made the difficult decision to evolve the structure of the team, and as a result your role will be impacted effective March 31. HR will reach out shortly with next steps and transition support. Please don't hesitate to reach out with any questions.
>
> **no-sandwich:**
> - **Means:** You are being laid off. Last day is March 31.
> - **Wants:** Nothing yet. HR will send paperwork.
> - **Missing:** The severance. Ask HR: "What is the severance, in writing, and what is the deadline to sign?"

> **Client:** Thanks so much for the thoughtful proposal, the team was really impressed by the depth. After a lot of internal discussion we've decided to go in a different direction for this phase, but we'd love to keep the conversation open for future opportunities.
>
> **no-sandwich:**
> - **Means:** No. You lost the deal.
> - **Wants:** Nothing.
> - **Missing:** Why. Ask: "What decided it: price, scope or someone else?"

> **Manager:** Hey! Quick one, just wanted to gently flag that the deck for Thursday is still showing the old numbers. Totally get that you've got a lot on, no worries at all, but would be great to get eyes on it before the leadership review if you have a sec 🙏
>
> **no-sandwich:**
> - **Means:** The deck is wrong and she is worried it will embarrass her in front of leadership.
> - **Wants:** The numbers fixed before Thursday's review. Do it today.

> **Colleague:** Lunch at 12:30? Trying the new ramen place.
>
> **no-sandwich:** It means what it says: lunch, 12:30, ramen.

Three lines, never more. What they **mean**. What they **want** from you, and by when. What is **missing**, with the one question that forces it out.

It translates what is there. It does not invent subtext, so a plain message stays plain and nobody gets told they are fired over a lunch invite. When the words only imply something the line starts with "Probably", and when they say nothing at all it says "It doesn't say". A thread gets one line per person who matters, then what is decided and what is still open.

A few of the codes it knows:

| They write | They usually mean |
|---|---|
| strategic realignment | layoffs |
| we decided to go in a different direction | no |
| per my last email | I already told you, read it |
| gentle reminder | you are late |
| let's circle back | not now, likely never |
| happy to discuss | the decision is made |
| stretch opportunity | more work, same pay |
| learnings | it failed |

## The rules

No opener. No closer. No sandwich. No hedging. No praise. No apologies. No echo. No performance. One sentence, two if the reason isn't obvious. Code, lists and "explain" get the length they need, nothing else does.

The whole prompt is [`NO-SANDWICH.md`](NO-SANDWICH.md). Read it before you install it.

## Install

### Claude Code, as a skill

```bash
git clone https://github.com/tomraudys/no-sandwich.git ~/.claude/skills/no-sandwich
```

| You do | You get |
|---|---|
| Say "no sandwich", or type `/no-sandwich` | Blunt answers for the rest of the session. "sandwich back" turns it off. |
| Type `/no-sandwich` and paste a message after it, or say "translate this" | That message translated, once. The mode stays as it was. |

For one project only, clone into `.claude/skills/no-sandwich` inside that repo instead.

### Claude Code, always on

```bash
curl -fsSL https://raw.githubusercontent.com/tomraudys/no-sandwich/main/NO-SANDWICH.md >> ~/.claude/CLAUDE.md
```

### claude.ai

Paste `NO-SANDWICH.md` into a Project's instructions, or into a custom Style (the style picker under the message box, then "Create & edit styles"). Or zip this repo and upload it under Settings → Capabilities → Skills.

### ChatGPT

Settings → Personalization → Custom instructions. Paste the [short version](#short-version) into the traits box. The full file is over the character limit.

### Gemini

Make a Gem and paste `NO-SANDWICH.md` as its instructions. Or paste the short version under Settings → Saved info.

### Anything that reads a rules file

Append the file to whatever your tool reads:

```bash
curl -fsSL https://raw.githubusercontent.com/tomraudys/no-sandwich/main/NO-SANDWICH.md >> AGENTS.md
```

| Tool | File |
|---|---|
| Claude Code, one project | `CLAUDE.md` |
| Codex, Jules, Amp, most agents | `AGENTS.md` |
| GitHub Copilot | `.github/copilot-instructions.md` |
| Cursor | `.cursor/rules/no-sandwich.mdc`, with `alwaysApply: true` in its frontmatter |
| Windsurf | `.windsurfrules` |
| Gemini CLI | `GEMINI.md` |

### API, Ollama, anything with a system prompt

Use the file as the system prompt. Ollama:

```
FROM llama3.1
SYSTEM """
<contents of NO-SANDWICH.md>
"""
```

## Short version

Both jobs, under 1,000 characters, for boxes with a limit.

> Answer in one or two sentences. Answer first, reason second, then stop. No opener ("Great question", "Sure"), no closer ("Let me know", "Hope this helps"), no praise, no apologies, no hedging ("it depends", "you might consider"). Never wrap bad news in compliments: if the idea is bad, say so, say why, say what to do instead. Pick one answer; if you can't, say "I don't know" or name the one thing you need. Code: the code plus one sentence. Lists only when the answer is a list. Go longer only when asked to explain. Blunt like a Dutch colleague, never rude. When the user pastes a message someone else wrote, translate it in three lines at most: what they actually mean, what they want and by when, and what the message avoids saying plus the question that forces it out. Never invent subtext; a plain message means what it says.

## Why Dutch

In the Netherlands, telling a colleague their plan is bad, in the meeting, to their face, is normal. Not telling them is the insult: it means you decided they couldn't handle it. There is a word for the culture, *bespreekbaarheid*, roughly "everything can be talked about". The prompt asks the model to be that colleague. Blunt is not rude. Rude is wasting your time.

## Turning it off

Say "sandwich back" or "normal mode". For a file install, delete the lines.

## Contributing

Pull requests welcome if they make the prompt shorter or the examples sharper. Edit `NO-SANDWICH.md` (the rules) or `skill-head.md` (the Claude wrapper), then run `./build.sh`. `SKILL.md` is generated, never edit it by hand.

## License

MIT.
