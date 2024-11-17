# Define the project folder and subfolders
$projectFolder = "GameProject"
$subfolders = @("css", "js", "images", "tests", "docs", "assets", "config")
$ErrorActionPreference = "Stop"

function Write-Log {
    param($Message, [switch]$IsError)
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    if ($IsError) {
        Write-Error "[$timestamp] ERROR: $Message"
    } else {
        Write-Output "[$timestamp] INFO: $Message"
    }
}

try {
    # Create the main project folder
    if (-Not (Test-Path -Path $projectFolder)) {
        New-Item -ItemType Directory -Path $projectFolder
        Write-Log "Created main project folder: $projectFolder"
    }

    # Create subfolders
    foreach ($folder in $subfolders) {
        $folderPath = Join-Path $projectFolder $folder
        if (-Not (Test-Path -Path $folderPath)) {
            New-Item -ItemType Directory -Path $folderPath
            Write-Log "Created subfolder: $folder"
        }
    }

    # Define file moves
    $fileMoves = @{
        "index.html" = $projectFolder
        "style.css" = (Join-Path $projectFolder "css")
        "documentation.md" = (Join-Path $projectFolder "docs")
        "logo.png" = (Join-Path $projectFolder "assets")
        "config.json" = (Join-Path $projectFolder "config")
    }

    # Move files to their respective folders
    foreach ($file in $fileMoves.Keys) {
        if (Test-Path -Path $file) {
            Move-Item -Path $file -Destination (Join-Path $fileMoves[$file] $file) -Force
            Write-Log "Moved $file to $($fileMoves[$file])"
        }
    }

    # Create placeholder files
    $placeholders = @{
        (Join-Path $projectFolder "js\script.js") = "// Main JavaScript file"
        (Join-Path $projectFolder "images\placeholder.png") = ""
        (Join-Path $projectFolder "README.md") = "# Project Title`n`n## Description`n`n## Installation`n`n## Usage"
    }

    foreach ($file in $placeholders.Keys) {
        if (-Not (Test-Path -Path $file)) {
            New-Item -ItemType File -Path $file -Value $placeholders[$file] -Force
            Write-Log "Created placeholder file: $file"
        }
    }

    # Move test files
    Get-ChildItem -Path . -Filter "*.test.js" | ForEach-Object {
        $destination = Join-Path $projectFolder "tests\$($_.Name)"
        Move-Item -Path $_.FullName -Destination $destination -Force
        Write-Log "Moved test file: $($_.Name)"
    }

    Write-Log "Project setup completed successfully!"

} catch {
    Write-Log $_.Exception.Message -IsError
    exit 1
}