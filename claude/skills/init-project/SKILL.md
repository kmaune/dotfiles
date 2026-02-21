---
name: init-project
description: Generate a project-specific .claude/CLAUDE.md for the current repository. Scans the codebase to produce grounded, factual project context that extends the global CLAUDE.md.
disable-model-invocation: true
---

Generate a `.claude/CLAUDE.md` for the current project. This file extends the global `~/.claude/CLAUDE.md` with project-specific facts. It should be committed to the repo so any Claude Code session in this project starts with full context.

## What to Scan

1. **Repository overview**
   ```bash
   git worktree list
   git log --oneline -10
   git remote -v
   ```

2. **Directory structure** — understand the layout at a meaningful depth
   ```bash
   tree -L 3 -I '.git|node_modules|build|__pycache__|target|.cache|*.pyc'
   ```

3. **Language and build system detection** — check for:
   - `CMakeLists.txt`, `Makefile` → C/C++
   - `package.json` → Node/JS/TS
   - `pyproject.toml`, `setup.py`, `requirements.txt` → Python
   - `Cargo.toml` → Rust
   - `go.mod` → Go
   - `*.gradle`, `pom.xml` → Java/JVM
   Read the root-level build file to extract: build commands, test commands, key dependencies

4. **README** — read it in full if present. It often contains the best high-level description of the project.

5. **Existing conventions** — look for:
   - `.editorconfig`, `.clang-format`, `pyproject.toml` formatting config → coding style
   - Test directory structure → testing patterns
   - CI config (`.github/workflows/`, `.gitlab-ci.yml`) → how the project is built and tested
   - Any existing `CONTRIBUTING.md` or `ARCHITECTURE.md`

6. **Check for existing project CLAUDE.md**
   ```bash
   cat .claude/CLAUDE.md 2>/dev/null
   ```
   If one exists, read it and ask the user whether to overwrite or update it.

## What to Generate

Produce `.claude/CLAUDE.md` with only factual, project-specific content. Do not repeat anything from the global `~/.claude/CLAUDE.md` — that content is already in context every session.

The file should contain:

```markdown
# Project Context: <project-name>

## What This Is
<1-3 sentences: what the project does, who uses it, what problem it solves>

## Key Directories
<directory tree with one-line descriptions of what each major directory contains>

## Build & Test
<exact commands to build, run tests, run a single test, clean>

## Conventions
<anything non-obvious: naming patterns, error handling approach, patterns used consistently, things to avoid>

## Architecture Notes
<only if there's meaningful non-obvious structure worth knowing: key abstractions, data flow, critical paths>
```

Keep it factual and short. If you're unsure about something, omit it rather than guess — wrong context is worse than missing context.

## Output

1. Show the user the generated content before writing
2. Ask for confirmation or corrections
3. Write to `.claude/CLAUDE.md` (create `.claude/` directory if needed)
4. Remind the user to commit it: `git add .claude/CLAUDE.md && git commit -m "chore: add Claude Code project context"`
