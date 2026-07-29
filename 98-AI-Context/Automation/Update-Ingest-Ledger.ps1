<# .SYNOPSIS Records an evidence note's ingest history without restricting re-ingest. #>
[CmdletBinding()]
param(
  [Parameter(Mandatory)] [string]$EvidencePath,
  [string[]]$ConceptPaths = @()
)

$ErrorActionPreference = 'Stop'
$vault = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
$ledgerPath = Join-Path $vault '07-Knowledge\.ingested.json'
$resolvedEvidence = (Resolve-Path -LiteralPath $EvidencePath).Path
$relativeEvidence = $resolvedEvidence.Substring($vault.Length + 1).Replace('\', '/')
$relativeConcepts = $ConceptPaths | ForEach-Object {
  $resolved = (Resolve-Path -LiteralPath $_).Path
  $resolved.Substring($vault.Length + 1).Replace('\', '/')
}
if (Test-Path -LiteralPath $ledgerPath) { $ledger = Get-Content -LiteralPath $ledgerPath -Raw -Encoding UTF8 | ConvertFrom-Json }
else { $ledger = [pscustomobject]@{ version = 1; notes = [pscustomobject]@{} } }
if (-not $ledger.notes) { $ledger | Add-Member -NotePropertyName notes -NotePropertyValue ([pscustomobject]@{}) }
$existing = $ledger.notes.PSObject.Properties[$relativeEvidence]
$times = if ($existing) { [int]$existing.Value.times_ingested + 1 } else { 1 }
$record = [pscustomobject]@{
  last_ingested = Get-Date -Format 'yyyy-MM-dd'
  times_ingested = $times
  concepts = @($relativeConcepts)
}
if ($existing) { $existing.Value = $record } else { $ledger.notes | Add-Member -NotePropertyName $relativeEvidence -NotePropertyValue $record }
$ledger | ConvertTo-Json -Depth 6 | Set-Content -LiteralPath $ledgerPath -Encoding UTF8
Write-Host "Recorded ingest $times for $relativeEvidence"
