<# .SYNOPSIS Creates a review queue for stale or low-confidence compiled knowledge. #>
[CmdletBinding()]
param([int]$ReviewAfterDays = 30)

$ErrorActionPreference = 'Stop'
$vault = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
$concepts = Get-ChildItem -LiteralPath (Join-Path $vault '07-Knowledge\Concepts') -File -Filter '*.md'
$today = Get-Date
$items = foreach ($concept in $concepts) {
  $text = Get-Content -LiteralPath $concept.FullName -Raw -Encoding UTF8
  $reviewedText = if ($text -match '(?m)^last_reviewed:\s*(\d{4}-\d{2}-\d{2})') { $Matches[1] } else { '' }
  $confidence = if ($text -match '(?m)^confidence:\s*(\w+)') { $Matches[1] } else { 'low' }
  $reviewed = if ($reviewedText) { [datetime]::ParseExact($reviewedText, 'yyyy-MM-dd', $null) } else { [datetime]::MinValue }
  $age = [math]::Floor(($today - $reviewed).TotalDays)
  if ($age -ge $ReviewAfterDays -or $confidence -eq 'low') {
    [pscustomobject]@{ File=$concept; Age=$age; Confidence=$confidence; Due=($age -ge $ReviewAfterDays) }
  }
}
$ordered = $items | Sort-Object @{Expression='Due';Descending=$true}, @{Expression='Age';Descending=$true}, @{Expression='Confidence'}
$lines = $ordered | ForEach-Object { "| [[07-Knowledge/Concepts/$($_.File.BaseName)]] | $($_.Age) | $($_.Confidence) | $($_.Due) |" }
if (-not $lines) { $lines = '| None | 0 | n/a | false |' }
$output = "---`ntype: knowledge-review-queue`ngenerated: $(Get-Date -Format 'yyyy-MM-dd HH:mm')`n---`n# Knowledge Review Queue`n`n| Concept | Days since review | Confidence | Due |`n| --- | --- | --- | --- |`n$($lines -join "`n")`n`nReview source evidence, update the concept's working model and review log, then set last_reviewed and review_after."
$path = Join-Path $vault '07-Knowledge\Reviews\Review Queue.md'
Set-Content -LiteralPath $path -Value $output -Encoding UTF8
Write-Host "Review queue: $path"
