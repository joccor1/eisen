<# Source-preserving Inbox Markdown cleaner. Use -All or -SourcePath. #>
[CmdletBinding()]
param([string]$SourcePath, [switch]$All, [switch]$WhatIf)

$ErrorActionPreference = 'Stop'
$vault = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
$inbox = Join-Path $vault '00-Inbox\Downloaded'
$research = Join-Path $vault '04-Research'

function Get-Field($text, $name) {
  $pattern = '(?ms)^---\s*\r?\n.*?^' + [regex]::Escape($name) + ':\s*["'']?([^\r\n"'']+)'
  if ($text -match $pattern) { return $Matches[1].Trim() }
  return ''
}
function Get-CleanTitle([string]$Title) {
  $clean = $Title.Trim()
  # Strip common capture prefixes without changing the source title itself.
  $clean = $clean -replace '^(?:\d{4}[-_.]?\d{1,2}[-_.]?\d{1,2})(?:[ T_.-]+\d{1,2}[:._-]\d{2}(?::\d{2})?)?\s*[-_.:|]+\s*', ''
  $clean = $clean -replace '^\s*(?:\[?\d{1,4}\]?|No\.\s*\d+)\s*[-_.:|]+\s*', ''
  return ($clean -replace '^[\s_.:|\-]+|[\s_.:|\-]+$', '')
}
function Get-Topic($text) {
  if ($text -match '(?i)\b(obsidian|knowledge base|markdown vault)\b') { return @{Folder='AI\Workflows';Tags=@('topic/obsidian','topic/workflow');Hubs=@('Obsidian Hub','Workflow Hub')} }
  if ($text -match '(?i)\b(codex|openai codex)\b') { return @{Folder='AI\Vibe-Coding';Tags=@('topic/codex','topic/agent');Hubs=@('Codex Hub','Agent Hub')} }
  if ($text -match '(?i)\b(claude code|claude)\b') { return @{Folder='AI\Vibe-Coding';Tags=@('topic/claude-code','topic/agent');Hubs=@('Claude Code Hub','Agent Hub')} }
  if ($text -match '(?i)\b(mcp|model context protocol)\b') { return @{Folder='AI\MCP';Tags=@('topic/mcp','topic/agent');Hubs=@('MCP Hub','Agent Hub')} }
  if ($text -match '(?i)\b(agent|agents|agentic)\b') { return @{Folder='AI\Agents';Tags=@('topic/agent');Hubs=@('Agent Hub')} }
  if ($text -match '(?i)\b(jenkins|devops|ci/cd|continuous integration|docker|kubernetes)\b') { return @{Folder='Software-Engineering\DevOps';Tags=@('topic/workflow');Hubs=@('Workflow Hub')} }
  if ($text -match '(?i)\b(github|git)\b') { return @{Folder='Software-Engineering\GitHub';Tags=@('topic/github');Hubs=@('GitHub Hub')} }
  if ($text -match '(?i)\b(crypto|onchain|defi|protocol)\b') { return @{Folder='AI-Crypto\Market-Research';Tags=@('topic/ai-crypto');Hubs=@('AI Crypto Hub')} }
  if ($text -match '(?i)\b(stock|stocks|valuation|macro)\b') { return @{Folder='Finance\US-Stocks';Tags=@('topic/us-stocks');Hubs=@('US Stocks Hub')} }
  if ($text -match '(?i)\b(tiktok|douyin|newsletter|video script)\b') { return @{Folder='Business\Marketing';Tags=@('topic/content-creation');Hubs=@('Content Creation Hub')} }
  return @{Folder='Information-Sources';Tags=@('topic/research');Hubs=@()}
}

if ($All) { $files = Get-ChildItem -LiteralPath $inbox -Filter '*.md' -File }
elseif ($SourcePath) { $files = Get-Item -LiteralPath (Resolve-Path -LiteralPath $SourcePath) }
else { throw 'Specify -SourcePath <file> or -All.' }

foreach ($file in $files) {
  $raw = [IO.File]::ReadAllText($file.FullName, [Text.UTF8Encoding]::new($false))
  $title = Get-Field $raw 'title'
  if (-not $title -and $raw -match '(?m)^#\s+(.+?)\s*$') { $title = $Matches[1].Trim() }
  if (-not $title) { $title = $file.BaseName }
  $title = Get-CleanTitle $title
  $topic = Get-Topic ($title + "`n" + $raw)
  $safe = ($title -replace '[\\/:*?"<>|]', '-' -replace '\s+', ' ').Trim(' ','.')
  $targetDir = Join-Path $research $topic.Folder
  $target = Join-Path $targetDir ($safe + '.md')
  $sourceUrl = Get-Field $raw 'source'
  if ($sourceUrl) {
    $existing = Get-ChildItem -LiteralPath $research -Recurse -File -Filter '*.md' | Where-Object {
      ([IO.File]::ReadAllText($_.FullName, [Text.UTF8Encoding]::new($false))) -match ('(?m)^source:\s*["'']?' + [regex]::Escape($sourceUrl))
    } | Select-Object -First 1
    if ($existing) { Write-Host "Already collected: $($existing.FullName)"; continue }
  }
  $n = 2; while (Test-Path -LiteralPath $target) { $target = Join-Path $targetDir ($safe + " ($n).md"); $n++ }
  $tags = ($topic.Tags | ForEach-Object { "  - $_" }) -join "`n"
  $hubs = ($topic.Hubs | ForEach-Object { "- [[04-Research/Topic-Hubs/$_]]" }) -join "`n"
  $links = ([regex]::Matches($raw, 'https?://[^\s\]\)<>]+') | ForEach-Object Value | Sort-Object -Unique | ForEach-Object { "- $_" }) -join "`n"
  $normalized = [regex]::Replace(($raw -replace "\r\n", "`n"), "\n{3,}", "`n`n").Trim()
  $headings = ([regex]::Matches($normalized, '(?m)^(#{1,6})\s+(.+)$') | ForEach-Object { '- ' + ('  ' * ($_.Groups[1].Value.Length - 1)) + $_.Groups[2].Value.Trim() }) -join "`n"
  $numberedCount = [regex]::Matches($normalized, '(?m)^\s*\d+[.)]\s+').Count
  $out = "---`ntype: research`nstatus: cleaned`nsource: `"$(Get-Field $raw 'source')`"`nauthor: `"$(Get-Field $raw 'author')`ncaptured: `"$(Get-Date -Format 'yyyy-MM-dd HH:mm')`"`nprimary_area: `"$($topic.Folder.Replace('\','/'))`"`ntags:`n  - type/research`n$tags`n---`n`n# $title`n`n## Source metadata`n- Raw import: [[00-Inbox/Downloaded/$($file.BaseName)]]`n`n## Topic hubs`n$hubs`n`n## Extracted links`n$links`n`n## Detected structure`n### Headings`n$headings`n`n### Numbered list items`n- $numberedCount`n`n## Original content`n`n$normalized`n"
  if ($WhatIf) { Write-Host "Would create: $target" } else { New-Item -ItemType Directory -Force -Path $targetDir | Out-Null; Set-Content -LiteralPath $target -Value $out -Encoding UTF8; Write-Host "Created: $target" }
}
