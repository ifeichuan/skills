---
name: refine
description: >-
  Analyze a draft prompt for gaps (goal, scope, context, constraints, edge
  cases, acceptance criteria) and output an optimized version ready to paste.
  Advisory only — never executes the task itself. Use whenever user wants to
  improve, sharpen, or clarify a prompt before running it. Triggers: "refine",
  "优化prompt", "improve my prompt", "帮我把话说清楚", "我的需求怎么说更好",
  "polish this prompt", "make this clearer", "rewrite my instruction",
  "sharpen this", or any variant where user shares a draft and asks for a
  better version. Also use when user pastes a prompt and says "看看怎么改" or
  "这样说对不对". Do NOT use when user wants direct execution.
argument-hint: "[draft prompt or topic]"
---

# Refine

Diagnose gaps in a draft prompt, output an optimized version. **Advisory only — never execute the task.**

## Pipeline

### 1. Diagnose

Check for missing elements:

| Element | Question |
|---------|----------|
| **Goal** | End result clear? |
| **Scope** | What to do AND what NOT to do? |
| **Context** | Relevant files, modules, patterns mentioned? |
| **Constraints** | Tech limits, perf, compat? |
| **Edge cases** | Empty state, errors, boundaries? |
| **Acceptance** | How to know it's done? |

If 3+ critical gaps exist, ask up to 3 questions. Otherwise fill with reasonable assumptions.

### 2. Output

```
## 缺失

- (1-3 bullets, critical gaps only)

## 优化后

<optimized prompt, single block, ready to paste>

## 改动

- (one line per change, with reason)
```

### Guidelines

- Inject project context (tech stack, conventions) detected from the environment into the optimized prompt
- Add explicit scope boundaries (what NOT to do) if missing
- Keep the optimized prompt in the same language as the original
- If the original is already solid, say so — don't change for change's sake
