[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'
$taskRepoRoot = Split-Path -Parent $PSScriptRoot
$taskWorkspaceRoot = Split-Path -Parent $taskRepoRoot
$taskSourceRoot = Join-Path $taskRepoRoot 'src'
$taskResourceRoot = Join-Path $taskRepoRoot 'res'
$taskOutputRoot = Join-Path $taskRepoRoot 'out'

$taskJdkCandidates = @()
$taskPortableRoot = Join-Path $taskWorkspaceRoot '.tools\jdk-21'
if (Test-Path -LiteralPath $taskPortableRoot -PathType Container) {
    $taskJdkCandidates += @(Get-ChildItem -LiteralPath $taskPortableRoot -Directory |
        Sort-Object Name -Descending | Select-Object -ExpandProperty FullName)
}
if ($env:JAVA_HOME) {
    $taskJdkCandidates += $env:JAVA_HOME
}
$taskJavaOnPath = Get-Command java.exe -CommandType Application -ErrorAction SilentlyContinue |
    Select-Object -First 1
if ($taskJavaOnPath) {
    $taskJdkCandidates += Split-Path -Parent (Split-Path -Parent $taskJavaOnPath.Source)
}

$taskJdkRoot = $taskJdkCandidates | Where-Object {
    (Test-Path -LiteralPath (Join-Path $_ 'bin\javac.exe') -PathType Leaf) -and
    (Test-Path -LiteralPath (Join-Path $_ 'bin\java.exe') -PathType Leaf)
} | Select-Object -First 1
if (-not $taskJdkRoot) {
    throw 'No JDK found. Install JDK 21 and make sure java and javac are available in PATH.'
}

$taskSourcePaths = @(Get-ChildItem -LiteralPath $taskSourceRoot -Filter '*.java' -File -Recurse |
    Sort-Object FullName | Select-Object -ExpandProperty FullName)
if ($taskSourcePaths.Count -eq 0) {
    throw "No Java source files found in $taskSourceRoot"
}
foreach ($taskResourceName in @('graphics', 'scores', 'font.ttf')) {
    if (-not (Test-Path -LiteralPath (Join-Path $taskResourceRoot $taskResourceName) -PathType Leaf)) {
        throw "Required game resource missing: $taskResourceName"
    }
}

New-Item -ItemType Directory -Path $taskOutputRoot -Force | Out-Null
$taskCompiler = Join-Path $taskJdkRoot 'bin\javac.exe'
$taskJava = Join-Path $taskJdkRoot 'bin\java.exe'

Write-Host "JDK: $taskJdkRoot"
& $taskCompiler -encoding UTF-8 -d $taskOutputRoot @taskSourcePaths
if ($LASTEXITCODE -ne 0) {
    throw "Java compilation failed (exit code $LASTEXITCODE)."
}
Write-Host "Build succeeded: $($taskSourcePaths.Count) Java source files."

$taskClasspath = $taskOutputRoot + [IO.Path]::PathSeparator + $taskResourceRoot
Push-Location -LiteralPath $taskRepoRoot
try {
    Write-Host 'Starting Invaders. Close the game window to stop.'
    & $taskJava -cp $taskClasspath engine.Core
    if ($LASTEXITCODE -ne 0) {
        throw "Game exited with code $LASTEXITCODE."
    }
}
finally {
    Pop-Location
}
