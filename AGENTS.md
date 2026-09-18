# Capstone Workflow

Use GitHub Copilot custom agents in `.github/agents/` as the orchestration layer for this repository.

## Rules

- Use `workflow/workflow.json` as the source of truth for stage order.
- Keep work scoped to the current stage artifact inside the active story folder.
- Stop at every `manual` gate and wait for a human decision.
- Capture the approval decision in the stage artifact before advancing.
- Do not invent missing requirements, reviewer decisions, or test evidence.

## Story selection

- Treat `stories/index.json` as the index of available stories.
- Work in one `stories/<story-id>/` folder at a time.
- Reuse the shared `.github/` agents and prompts across all stories.

## Persistent state

- Use `.github/ai-state.json` to keep compact cross-session workflow state.
- Store active story, current stage, latest approval decision, blockers, and evidence summary.
- Keep story-specific long-form content inside the relevant story folder, not in `.github/ai-state.json`.

## Stage ownership

- Requirements: `stories/<story-id>/requirements.md`
- Architecture: `stories/<story-id>/architecture.md`
- Design Review: `stories/<story-id>/design-review.md`
- Implementation Planning: `stories/<story-id>/impl-plan.md`
- Implementation evidence: `stories/<story-id>/implementation-notes.md`
- Review: `stories/<story-id>/review.md`
- Verify: `stories/<story-id>/verify.md`
- PR readiness: `stories/<story-id>/pr-description.md`

## Specialist expectations

- Review must use the capstone checklist for correctness, security, error handling, test coverage, clarity, DRY, and dependency safety.
- Verify must cover unit tests, integration tests, and final output quality checks.
- PR readiness must own the final PR description sections required by the capstone brief.
