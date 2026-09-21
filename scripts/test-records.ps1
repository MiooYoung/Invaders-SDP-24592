[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'
$taskRepoRoot = Split-Path -Parent $PSScriptRoot
$taskWorkspaceRoot = Split-Path -Parent $taskRepoRoot
$taskSourceRoot = Join-Path $taskRepoRoot 'src'
$taskTestFile = Join-Path $taskRepoRoot 'tests\records\RecordsSmokeTest.java'
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
$taskCompilerOnPath = Get-Command javac.exe -CommandType Application -ErrorAction SilentlyContinue |
	Select-Object -First 1
if ($taskCompilerOnPath) {
	$taskJdkCandidates += Split-Path -Parent (Split-Path -Parent $taskCompilerOnPath.Source)
}

$taskJdkRoot = $taskJdkCandidates | Where-Object {
	(Test-Path -LiteralPath (Join-Path $_ 'bin\javac.exe') -PathType Leaf) -and
	(Test-Path -LiteralPath (Join-Path $_ 'bin\java.exe') -PathType Leaf)
} | Select-Object -First 1
if (-not $taskJdkRoot) {
	throw 'No JDK found. Configure JAVA_HOME, PATH, or the workspace .tools\jdk-21 folder.'
}

$taskSourcePaths = @(Get-ChildItem -LiteralPath $taskSourceRoot -Filter '*.java' -File -Recurse |
	Sort-Object FullName | Select-Object -ExpandProperty FullName)
if (-not (Test-Path -LiteralPath $taskTestFile -PathType Leaf)) {
	throw "Records smoke test not found: $taskTestFile"
}

New-Item -ItemType Directory -Path $taskOutputRoot -Force | Out-Null
$taskCompiler = Join-Path $taskJdkRoot 'bin\javac.exe'
$taskJava = Join-Path $taskJdkRoot 'bin\java.exe'

Write-Host "Compiling game and records checks with: $taskJdkRoot"
& $taskCompiler -encoding UTF-8 -d $taskOutputRoot @taskSourcePaths $taskTestFile
if ($LASTEXITCODE -ne 0) {
	throw "Java compilation failed (exit code $LASTEXITCODE)."
}

& $taskJava -ea -cp $taskOutputRoot records.RecordsSmokeTest
if ($LASTEXITCODE -ne 0) {
	throw "Records smoke test failed (exit code $LASTEXITCODE)."
}
