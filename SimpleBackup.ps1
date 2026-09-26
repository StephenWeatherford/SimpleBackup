param(
    [string]$sourceDir,
    [string]$extensionsCsv
)

write-warning "sourceDir = $sourceDir"    
write-warning "extensionsCsv = $extensionsCsv"

# Convert comma-separated extensions into an array
$extensions = $extensionsCsv -split ','

# Backup folder (inside the source directory)
$backupDir = Join-Path $sourceDir "Backup"
if (!(Test-Path $backupDir)) {
    New-Item -ItemType Directory -Path $backupDir | Out-Null
}

# Timestamp prefix
$timestamp = (Get-Date).ToString("yyyy-MM-dd-HHmmss")

Write-Host "Copying files from:"
Write-Host "  $sourceDir" -ForegroundColor Cyan
Write-Host "Extensions:"
Write-Host "  $extensionsCsv"
Write-Host ""

# Gather all matching files across all extensions
$files = foreach ($ext in $extensions) {
    Get-ChildItem -Path $sourceDir -Filter $ext
}

# Automatically ignore the batch file itself
$files = $files | Where-Object { $_.Name -ne "RunBackup.bat" }

foreach ($file in $files) {
    $newName = "$timestamp-$($file.Name)"
    $destPath = Join-Path $backupDir $newName
    Copy-Item $file.FullName $destPath
    Write-Host "  $destPath"
}

Write-Host ""
Write-Host "Press any key to exit..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
