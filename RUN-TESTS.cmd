@echo off
chcp 65001 >nul
cd /d "%~dp0"
echo.
echo Chinese can fly - 第一次提交自动检查
echo 正在编译并运行 3.1 的 36 项检查，请不要关闭窗口。
echo.
powershell.exe -NoProfile -ExecutionPolicy Bypass -File ".\scripts\test-records.ps1"
set TASK_EXIT_CODE=%ERRORLEVEL%
echo.
if not "%TASK_EXIT_CODE%"=="0" (
  echo [FAIL] 检查没有通过。请截图整个窗口，发到内部 PR，不要写 PASS。
  pause
  exit /b %TASK_EXIT_CODE%
)
echo [PASS] 编译和 36 项检查均已通过。请把这句话和当前 commit SHA 写到内部 PR。
pause
