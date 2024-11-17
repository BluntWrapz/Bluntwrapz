# Define the project folder and subfolders
$projectFolder = "GameProject"
$subfolders = @("css", "js", "images", "tests", "docs", "assets", "config")

# Create the main project folder if it doesn't exist
if (-Not (Test-Path -Path $projectFolder)) {
    New-Item -ItemType Directory -Path $projectFolder
}

# Create subfolders
foreach ($folder in $subfolders) {
    $folderPath = "$projectFolder\$folder"
    if (-Not (Test-Path -Path $folderPath)) {
        New-Item -ItemType Directory -Path $folderPath
    }
}

# Move index.html to the main project folder
if (Test-Path -Path "index.html") {
    Move-Item -Path "index.html" -Destination "$projectFolder\index.html"
}

# Move style.css to the css subfolder
if (Test-Path -Path "style.css") {
    Move-Item -Path "style.css" -Destination "$projectFolder\css\style.css"
}

# Create a placeholder script.js file in the js subfolder if it doesn't exist
$scriptFilePath = "$projectFolder\js\script.js"
if (-Not (Test-Path -Path $scriptFilePath)) {
    New-Item -ItemType File -Path $scriptFilePath
}

# Create a placeholder image in the images subfolder if it doesn't exist
$imageFilePath = "$projectFolder\images\placeholder.png"
if (-Not (Test-Path -Path $imageFilePath)) {
    New-Item -ItemType File -Path $imageFilePath
}

# Create a README.md file in the main project folder if it doesn't exist
$readmeFilePath = "$projectFolder\README.md"
if (-Not (Test-Path -Path $readmeFilePath)) {
    New-Item -ItemType File -Path $readmeFilePath -Value "# Project Title`n`n## Description`n`n## Installation`n`n## Usage"
}

# Move .test.js files to the tests subfolder
$testFiles = Get-ChildItem -Path . -Filter *.test.js
foreach ($file in $testFiles) {
    Move-Item -Path $file.FullName -Destination "$projectFolder\tests\$($file.Name)"
}

# Move documentation.md to the docs subfolder
$documentationFilePath = "documentation.md"
if (Test-Path -Path $documentationFilePath) {
    Move-Item -Path $documentationFilePath -Destination "$projectFolder\docs\documentation.md"
}

# Move logo.png to the assets subfolder
$logoFilePath = "logo.png"
if (Test-Path -Path $logoFilePath) {
    Move-Item -Path $logoFilePath -Destination "$projectFolder\assets\logo.png"
}

# Move config.json to the config subfolder
$configFilePath = "config.json"
if (Test-Path -Path $configFilePath) {
    Move-Item -Path $configFilePath -Destination "$projectFolder\config\config.json"
}

Write-Output "Project structure created, files moved, and test files organized successfully."