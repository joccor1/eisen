<#
.SYNOPSIS Pulls remote updates, commits local vault changes, and pushes when credentials permit.
.DESCRIPTION
This script never stores credentials. Git Credential Manager or SSH handles authentication.
#>
[CmdletBinding()]
param([switch]$NoPush)

$ErrorActionPreference = 'Stop'
$Vault = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
Set-Location $Vault
if (-not (Test-Path '.git')) { throw 'Git is not initialized. Initialize the vault before syncing.' }
git fetch origin
git pull --rebase origin main
if (git status --porcelain) {
    git add --all
    git commit -m "vault: sync $(Get-Date -Format 'yyyy-MM-dd HH:mm')"
}
if (-not $NoPush) { git push origin main }
