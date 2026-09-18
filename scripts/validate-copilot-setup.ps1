$requiredPaths = @(
  ".github/copilot-instructions.md",
  ".github/agents/orchestrator.agent.md",
  ".github/agents/requirements.agent.md",
  ".github/agents/architecture.agent.md",
  ".github/agents/design-review.agent.md",
  ".github/agents/implementation-planner.agent.md",
  ".github/agents/implementation.agent.md",
  ".github/agents/review.agent.md",
  ".github/agents/verify.agent.md",
  ".github/agents/pr-readiness.agent.md",
  ".github/prompts/run-capstone-stage.prompt.md",
  ".github/prompts/request-approval.prompt.md",
  ".github/instructions/capstone-artifacts.instructions.md",
  ".github/hooks/manual-gates.json",
  ".github/ai-state.json",
  ".github/skills/documentation-sync/SKILL.md",
  "workflow/workflow.json",
  "stories/index.json",
  "stories/README.md",
  "stories/_template/story-metadata.json",
  "stories/_template/requirements.md",
  "stories/_template/architecture.md",
  "stories/_template/design-review.md",
  "stories/_template/impl-plan.md",
  "stories/_template/implementation-notes.md",
  "stories/_template/review.md",
  "stories/_template/verify.md",
  "stories/_template/pr-description.md"
)

$missing = $requiredPaths | Where-Object { -not (Test-Path $_) }

if ($missing.Count -gt 0) {
  Write-Host "Missing required setup assets:" -ForegroundColor Red
  $missing | ForEach-Object { Write-Host "- $_" -ForegroundColor Red }
  exit 1
}

$storyIndex = Get-Content "stories/index.json" | ConvertFrom-Json

if (-not $storyIndex.active_story) {
  Write-Host "stories/index.json must define active_story" -ForegroundColor Red
  exit 1
}

$activeStoryFolder = ($storyIndex.stories | Where-Object { $_.id -eq $storyIndex.active_story } | Select-Object -First 1).folder

if (-not $activeStoryFolder) {
  Write-Host "Active story in stories/index.json must map to a story folder" -ForegroundColor Red
  exit 1
}

$activeStoryRequired = @(
  "$activeStoryFolder/story-metadata.json",
  "$activeStoryFolder/requirements.md",
  "$activeStoryFolder/architecture.md",
  "$activeStoryFolder/design-review.md",
  "$activeStoryFolder/impl-plan.md",
  "$activeStoryFolder/implementation-notes.md",
  "$activeStoryFolder/review.md",
  "$activeStoryFolder/verify.md",
  "$activeStoryFolder/pr-description.md"
)

$activeStoryMissing = $activeStoryRequired | Where-Object { -not (Test-Path $_) }

if ($activeStoryMissing.Count -gt 0) {
  Write-Host "Missing active story assets:" -ForegroundColor Red
  $activeStoryMissing | ForEach-Object { Write-Host "- $_" -ForegroundColor Red }
  exit 1
}

Write-Host "Copilot-native capstone setup validation passed" -ForegroundColor Green


