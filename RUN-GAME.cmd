@echo off
chcp 65001 >nul
cd /d "%~dp0"
echo.
echo Chinese can fly - 第一次提交游戏演示
echo 将先编译，再打开游戏。关闭游戏窗口后，本窗口会结束。
echo.
powershell.exe -NoProfile -ExecutionPolicy Bypass -File ".\scripts\run-game.ps1"
set TASK_EXIT_CODE=%ERRORLEVEL%
echo.
if not "%TASK_EXIT_CODE%"=="0" (
  echo [FAIL] 游戏没有正常启动或运行。请截图整个窗口，发到内部 PR。
  pause
  exit /b %TASK_EXIT_CODE%
)
echo 游戏已正常关闭。
pause
