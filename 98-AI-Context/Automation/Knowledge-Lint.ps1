<#
.SYNOPSIS
Checks compiled knowledge pages for required provenance and review metadata.
#>
[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'
$vault = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
$knowledgeRoot = Join-Path $vault '07-Knowledge'
$reportPath = Join-Path $knowledgeRoot 'Reviews\Knowledge Lint Report.md'
$notes = @(
  Get-ChildItem -LiteralPath (Join-Path $knowledgeRoot 'Concepts') -File -Filter '*.md'
  Get-ChildItem -LiteralPath (Join-Path $knowledgeRoot 'Syntheses') -File -Filter '*.md'
)

$findings = foreach ($note in $notes) {
  $text = Get-Content -LiteralPath $note.FullName -Raw -Encoding UTF8
  $relative = $note.FullName.Substring($vault.Length + 1).Replace('\', '/')
  $issues = @()
  if ($text -notmatch '(?m)^type:\s*(concept|synthesis)\s*$') { $issues += 'missing or invalid type' }
  if ($text -notmatch '(?m)^confidence:\s*(low|medium|high)\s*$') { $issues += 'missing confidence' }
  if ($text -notmatch '(?m)^last_reviewed:\s*\d{4}-\d{2}-\d{2}\s*$') { $issues += 'missing last_reviewed' }
  if ($text -notmatch '(?ms)^evidence:\s*\r?\n\s+- \[\[') { $issues += 'missing evidence links' }
  if ($text -notmatch '(?m)^## Scope\s*$') { $issues += 'missing scope' }
  if ($text -notmatch '\[\[') { $issues += 'missing internal link' }
  foreach ($issue in $issues) {
    [pscustomobject]@{ Note = $relative; Issue = $issue }
  }
}

$lines = @($findings | ForEach-Object { "| $($_.Note) | $($_.Issue) |" })
if ($lines.Count -eq 0) { $lines = @('| None | No structural issues found |') }
$status = if ($findings) { 'attention' } else { 'pass' }
$output = "---`ntype: knowledge-lint-report`nstatus: $status`ngenerated: $(Get-Date -Format 'yyyy-MM-dd HH:mm')`n---`n# Knowledge Lint Report`n`n| Note | Finding |`n| --- | --- |`n$($lines -join "`n")`n`nThis check validates compiled-note structure only. Review factual claims against linked research evidence before changing a conclusion."
Set-Content -LiteralPath $reportPath -Value $output -Encoding UTF8
Write-Host "Knowledge lint status: $status; findings: $($findings.Count)"
