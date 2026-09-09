@echo off
REM Caminho completo do script baseado na pasta do .bat
set scriptPath=%~dp0instalador_programas.ps1

powershell -NoProfile -ExecutionPolicy Bypass -Command "& '%scriptPath%'"
