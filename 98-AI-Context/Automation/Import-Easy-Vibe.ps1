<# Imports Easy Vibe course Markdown as source-preserving research notes. #>
[CmdletBinding()]
param([string]$SourceRoot = 'C:\Users\13075\Desktop\easy-vibe-main\easy-vibe-md', [switch]$WhatIf)

$ErrorActionPreference = 'Stop'
$vault = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
$researchRoot = Join-Path $vault '04-Research'
function Get-Title($text, $fallback) { if ($text -match '(?m)^#\s+(.+?)\s*$') { return $Matches[1].Trim() }; return ($fallback -replace '^\d+(?:-\d+)?-', '') }
function Get-Category($name) {
  if ($name -eq '目录.md') { return 'AI\Vibe-Coding\Easy-Vibe-Course' }
  if ($name -match '^(001|002|014|015|017|018|019)|vibe-coding|ai-ide|building-prototype|complete-project|integrating-ai') { return 'AI\Vibe-Coding\Easy-Vibe-Course' }
  if ($name -match '^00[3-9]|^010|^011|^012|^013|finding-great-idea|personal-brand') { return 'Business\Product-Management' }
  if ($name -match '^02[1-9]|^03[0-6]|assignments') { return 'Software-Engineering\Project-Examples' }
  if ($name -match '^02[0-4]|^052|^053|^054|^159|^16[0-9]|^17[0-4]|ai-advanced|ai-capabilities|artificial-intelligence') { return 'AI\Applied-AI' }
  if ($name -match '^05[5-9]|^06[0-4]|core-skills') { return 'AI\Agents\Developer-Agents' }
  if ($name -match '^04[3-9]|^050') { return 'Design\UI-UX' }
  if ($name -match '^06[5-9]|^07[0-5]|cross-platform') { return 'Software-Engineering\Cross-Platform' }
  if ($name -match '^07[8-9]|^08[0-9]|computer-fundamentals') { return 'Software-Engineering\Computer-Fundamentals' }
  if ($name -match '^09[0-9]|development-tools') { return 'Software-Engineering\Development-Tools' }
  if ($name -match '^10[0-9]|^11[0-4]|browser-and-frontend|frontend') { return 'Software-Engineering\Frontend' }
  if ($name -match '^11[5-9]|^12[0-9]|^13[0-4]|server-and-backend|backend') { return 'Software-Engineering\Backend' }
  if ($name -match '^13[5-9]|^140|^141|^033|^034|data-') { return 'Software-Engineering\Data' }
  if ($name -match '^142|^143|^144|^145|architecture-and-system-design') { return 'Software-Engineering\Architecture' }
  if ($name -match '^146|^147|^148|^149|^150|^151|^152|^153|^154|^155|^156|^157|^158|infrastructure-and-operations|zeabur|stripe') { return 'Software-Engineering\Infrastructure' }
  if ($name -match '^175|^176|^177|^178|^179|^180|^181|engineering-excellence') { return 'Software-Engineering\Engineering-Excellence' }
  return 'Information-Sources\Easy-Vibe'
}
function Get-Tags($category) {
  $tags = @('type/research','collection/easy-vibe')
  if ($category -match '^AI\\Agents') { $tags += 'topic/agent','topic/claude-code','topic/mcp','topic/workflow' }
  elseif ($category -match '^AI') { $tags += 'topic/ai','topic/vibe-coding' }
  elseif ($category -match '^Business') { $tags += 'topic/product-management' }
  elseif ($category -match '^Design') { $tags += 'topic/design' }
  else { $tags += 'topic/software-engineering' }
  return $tags | Sort-Object -Unique
}
function Get-Hub($category) {
  if ($category -match '^AI\\Agents') { return 'Agent Hub' }
  if ($category -match '^AI\\Vibe-Coding') { return 'Workflow Hub' }
  if ($category -match '^AI\\Applied-AI') { return 'Agent Hub' }
  if ($category -match '^Business\\Product-Management') { return 'Product Management Hub' }
  if ($category -match '^Design\\UI-UX') { return 'Design Hub' }
  if ($category -match '^Software-Engineering') { return 'Software Engineering Hub' }
  return ''
}
if (-not (Test-Path -LiteralPath $SourceRoot)) { throw "Source directory not found: $SourceRoot" }
$files = Get-ChildItem -LiteralPath $SourceRoot -File -Filter '*.md' | Sort-Object Name
$rows = [System.Collections.Generic.List[string]]::new()
foreach ($file in $files) {
  $raw = [IO.File]::ReadAllText($file.FullName, [Text.UTF8Encoding]::new($false))
  $title = Get-Title $raw $file.BaseName
  $category = Get-Category $file.Name
  $safe = (($title -replace '[\\/:*?"<>|]', '-') -replace '\s+', ' ').Trim(' ','.','-')
  $targetDir = Join-Path $researchRoot $category
  $target = Join-Path $targetDir ($safe + '.md')
  $sourcePath = $file.FullName.Replace('\', '/')
  $tagLines = (Get-Tags $category | ForEach-Object { "  - $_" }) -join "`n"
  $hub = Get-Hub $category
  $hubLink = if ($hub) { "- [[04-Research/Topic-Hubs/$hub]]" } else { '' }
  $metadata = "---`ntype: research`nstatus: imported`ncollection: easy-vibe`nsource: `"easy-vibe`"`nsource_path: `"$sourcePath`"`nsource_file: `"$($file.Name)`"`nprimary_area: `"$($category.Replace('\','/'))`"`ntags:`n$tagLines`n---`n`n# $title`n`n## Import metadata`n- Collection: Easy Vibe Chinese course`n- Original file: $($file.Name)`n- Original path: $sourcePath`n`n## Topic hubs`n$hubLink`n`n## Original content`n`n$raw`n"
  if ($WhatIf) { Write-Host "Would import [$category]: $title" } else { New-Item -ItemType Directory -Force -Path $targetDir | Out-Null; Set-Content -LiteralPath $target -Value $metadata -Encoding UTF8 }
  $rows.Add("| $($file.Name) | $title | $($category.Replace('\','/')) |")
}
$indexPath = Join-Path $researchRoot 'AI\Vibe-Coding\Easy-Vibe-Course\Easy Vibe Course Index.md'
$index = "---`ntype: collection-index`ncollection: easy-vibe`nimported: $(Get-Date -Format 'yyyy-MM-dd HH:mm')`ntags: [collection/easy-vibe, topic/vibe-coding]`n---`n# Easy Vibe Course Index`n`n| Source file | Title | Primary area |`n| --- | --- | --- |`n$($rows -join "`n")`n"
if (-not $WhatIf) { New-Item -ItemType Directory -Force -Path (Split-Path -Parent $indexPath) | Out-Null; Set-Content -LiteralPath $indexPath -Value $index -Encoding UTF8 }
Write-Host "Processed $($files.Count) Easy Vibe Markdown files."
