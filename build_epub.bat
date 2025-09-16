@echo off
setlocal enabledelayedexpansion

REM Verificar si se arrastró un archivo
if "%~1"=="" (
    echo Uso: Arrastra un archivo .md sobre este archivo bat
    echo O ejecuta: build_epub.bat archivo.md
    pause
    exit /b 1
)

REM Obtener el nombre del archivo sin extensión
set "input_file=%~1"
set "base_name=%~n1"
set "md_dir=%~dp1"
set "output_file=%md_dir%%base_name%.epub"

REM Verificar que el archivo existe
if not exist "%input_file%" (
    echo Error: El archivo "%input_file%" no existe
    pause
    exit /b 1
)

REM Verificar que es un archivo .md
if not "%input_file:~-3%"==".md" (
    echo Error: El archivo debe tener extensión .md
    pause
    exit /b 1
)

echo Generando EPUB: %output_file%
echo Archivo fuente: %input_file%

REM Generar EPUB con pandoc (recursos desde la carpeta del .md; CSS desde la carpeta del BAT)
pandoc "%input_file%" --resource-path="%~dp1;." -c "%~dp0epub.css" -o "%output_file%"

if %errorlevel% equ 0 (
    echo ¡EPUB generado exitosamente: %output_file%!
) else (
    echo Error al generar el EPUB
)

pause
