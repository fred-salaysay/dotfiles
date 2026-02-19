---
name: update-documentation
description: Use when code changes may have created documentation drift, such as requests to sync docs, update README files, or verify branch documentation. Reviews nearest markdown files up each changed file path and then validates related pages in docs/.
---

# Update Documentation

## Goal

Keep documentation accurate after code changes by checking both local markdown files near changed code and centralized documentation in `docs/`.

## When to Use

- User asks to update docs after implementation
- Branch includes behavior, API, routing, configuration, or UX changes
- User asks to verify whether docs are still accurate

## Workflow

### 1) Build the changed-file set

Create the list of changed files for the current branch and working tree.

- Include tracked changes and newly added files
- Exclude deleted files
- Keep markdown files in the list if they are part of the implementation context

### 2) Local-doc pass (non-`docs/`)

For each changed file outside `docs/`:

1. Start in the file's directory.
2. Look for markdown files in that directory (`*.md`, including `README.md`).
3. Read the nearest markdown file(s) and check whether they describe the changed file, feature, route, config, or behavior.
4. If related and inaccurate, update only the affected sections.
5. Move one directory up and repeat.
6. Continue until repository root.
7. Do not edit files inside `docs/` during this pass.

Rules:

- Prefer minimal, surgical edits over broad rewrites.
- Preserve existing structure, headings, and intent.
- Do not add speculative statements; verify against current branch changes.

### 3) Central-doc pass (`docs/`)

After finishing all non-`docs/` updates:

1. Review file names and top-level titles under `docs/` to identify likely related pages.
2. Open candidate documents whose titles suggest relevance to the changed features.
3. Validate accuracy against current branch behavior.
4. Update outdated sections.
5. Leave unrelated docs unchanged.

## Coverage Rules

- Repeat the local-doc pass for **every** changed file so no area is skipped.
- If multiple changed files map to the same markdown file, merge updates in one coherent edit.
- Treat "no update needed" as an explicit outcome after verification.

## Response Format

When reporting back, include:

1. `Updated docs` - list of files changed and what was corrected
2. `Verified, no change needed` - files reviewed and confirmed accurate
3. `Gaps or follow-ups` - anything that could not be verified confidently

## Example Triggers

- "Update documentation for this branch"
- "Make sure README files are still accurate"
- "Sync docs with current changes"
- "Review docs/ and update anything affected"
