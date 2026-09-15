# no-sandwich

Strips the bullshit sandwich off AI replies. One or two sentences. Answer first, reason second, nothing third. Blunt like a Dutch colleague.

One Markdown file. Works as a system prompt, a custom instruction, a Claude skill, a `CLAUDE.md`, an `AGENTS.md`, a Cursor rule. Anywhere you can paste text.

## The sandwich

> **You:** Is rewriting the backend in Rust a good idea?
>
> **Default AI:** That's a really exciting idea, and Rust is a fantastic choice with a lot of momentum right now! There are definitely a few things worth considering, though. Full rewrites can be risky and often take longer than expected, so it might be worth weighing that against your current priorities. That said, with careful planning and a phased approach, it could absolutely work. Let me know if you'd like help thinking it through! 🚀
>
> **no-sandwich:** No. Nobody asked for it and it costs a year for zero product change; fix the slow endpoints in place.

Praise, then the answer buried under hedges, then praise. Bread, filling, bread. You wanted the filling.

The sandwich protects the person giving the feedback, not the person getting it. A model has nothing to protect.

## The rules

No opener. No closer. No sandwich. No hedging. No praise. No apologies. No echo. No performance. One sentence, two if the reason isn't obvious. Code, lists and "explain" get the length they need, nothing else does.

The whole prompt is [`NO-SANDWICH.md`](NO-SANDWICH.md). It is shorter than this README.

## Install

### Claude Code, as a skill

```bash
git clone https://github.com/tomraudys/no-sandwich.git ~/.claude/skills/no-sandwich
```

Say "no sandwich" or type `/no-sandwich`. Stays on for the session; "sandwich back" turns it off. For one project only, clone into `.claude/skills/no-sandwich` inside that repo instead.

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

Same rules, under 600 characters, for boxes with a limit.

> Answer in one or two sentences. Answer first, reason second, then stop. No opener ("Great question", "Sure"), no closer ("Let me know", "Hope this helps"), no praise, no apologies, no hedging ("it depends", "you might consider"). Never wrap bad news in compliments: if the idea is bad, say so, say why, say what to do instead. Pick one answer; if you can't, say "I don't know" or name the one thing you need. Code: the code plus one sentence. Lists only when the answer is a list. Go longer only when asked to explain. Blunt like a Dutch colleague, never rude.

## Why Dutch

In the Netherlands, telling a colleague their plan is bad, in the meeting, to their face, is normal. Not telling them is the insult: it means you decided they couldn't handle it. There is a word for the culture, *bespreekbaarheid*, roughly "everything can be talked about". The prompt asks the model to be that colleague. Blunt is not rude. Rude is wasting your time.

## Turning it off

Say "sandwich back" or "normal mode". For a file install, delete the lines.

## Contributing

Pull requests welcome if they make the prompt shorter or the examples sharper. `NO-SANDWICH.md` and `SKILL.md` carry the same rules; change both.

## License

MIT.
