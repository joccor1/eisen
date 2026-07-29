<# .SYNOPSIS Generates a non-destructive Markdown health report. #>
[CmdletBinding()]
param([string]$OutputPath)

$ErrorActionPreference = 'Stop'
$vault = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
if (-not $OutputPath) { $OutputPath = Join-Path $vault ('99-Archive\Audits\Knowledge-Base-Audit-' + (Get-Date -Format 'yyyy-MM-dd-HHmmss') + '.md') }
$notes = Get-ChildItem -LiteralPath $vault -Recurse -File -Filter '*.md' | Where-Object { $_.FullName -notmatch '[\\/]\.obsidian[\\/]' }
$duplicates = $notes | Group-Object BaseName | Where-Object Count -gt 1
$badNames = $notes | Where-Object { $_.BaseName -match '^Untitled|^New Note|^New File' }
$emptyDirs = Get-ChildItem -LiteralPath $vault -Recurse -Directory | Where-Object { -not (Get-ChildItem -LiteralPath $_.FullName -Force | Select-Object -First 1) }
$junk = Get-ChildItem -LiteralPath $vault -Recurse -File | Where-Object { $_.Name -match '^(Thumbs\.db|Desktop\.ini)$|~\$|\.tmp$|\.bak$' }
$orphaned = foreach ($note in $notes) {
  $content = Get-Content -LiteralPath $note.FullName -Raw -Encoding UTF8
  $stem = [regex]::Escape($note.BaseName)
  $mentioned = $notes | Where-Object { $_.FullName -ne $note.FullName } | ForEach-Object { Get-Content -LiteralPath $_.FullName -Raw -Encoding UTF8 } | Where-Object { $_ -match "\[\[([^\]]*/)?$stem(\|[^\]]+)?\]\]" } | Select-Object -First 1
  if (-not $mentioned -and $content -notmatch '\[\[' -and $note.DirectoryName -notmatch 'Topic-Hubs|90-Templates|97-AI-Memory|98-AI-Context|99-Archive') { $note }
}
function Format-List($items, $property) { if (@($items).Count -eq 0) { return '- None' }; return (($items | ForEach-Object { '- ' + $_.$property }) -join "`n") }
$report = @"
---
type: knowledge-base-audit
generated: $(Get-Date -Format 'yyyy-MM-dd HH:mm')
---
# Knowledge Base Audit

## Summary
- Markdown notes: $($notes.Count)
- Duplicate filenames: $(@($duplicates).Count)
- Suspicious filenames: $(@($badNames).Count)
- Empty directories: $(@($emptyDirs).Count)
- Junk files: $(@($junk).Count)
- Potential orphan notes: $(@($orphaned).Count)

## Duplicate filenames
$(Format-List $duplicates 'Name')

## Classification conflicts
Manual review is needed when a note has multiple primary_area values or multiple top-level homes. This audit never moves notes.

## Suspicious filenames
$(Format-List $badNames 'FullName')

## Empty directories
$(Format-List $emptyDirs 'FullName')

## Junk files
$(Format-List $junk 'FullName')

## Potential orphan notes
$(Format-List $orphaned 'FullName')
"@
New-Item -ItemType Directory -Force -Path (Split-Path -Parent $OutputPath) | Out-Null
Set-Content -LiteralPath $OutputPath -Value $report -Encoding UTF8
Write-Host "Audit report: $OutputPath"
