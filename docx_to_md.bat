@echo off
setlocal enabledelayedexpansion

REM Verificar si se arrastró un archivo
if "%~1"=="" (
    echo Uso: Arrastra un archivo .docx o .odt sobre este archivo bat
    echo O ejecuta: docx_to_md.bat archivo.docx
    pause
    exit /b 1
)

REM Obtener el nombre del archivo, carpeta y extensión
set "input_file=%~1"
set "base_name=%~n1"
set "file_ext=%~x1"
set "input_dir=%~dp1"
set "output_file=%input_dir%%base_name%.md"

REM Verificar que el archivo existe
if not exist "%input_file%" (
    echo Error: El archivo "%input_file%" no existe
    pause
    exit /b 1
)

REM Verificar que es un archivo soportado
if not "%file_ext%"==".docx" if not "%file_ext%"==".odt" (
    echo Error: El archivo debe tener extensión .docx o .odt
    pause
    exit /b 1
)

echo Convirtiendo a Markdown: %output_file%
echo Archivo fuente: %input_file%

REM Convertir a Markdown con pandoc
pandoc "%input_file%" -t gfm -o "%output_file%"

if %errorlevel% equ 0 (
    echo ¡Markdown generado exitosamente: %output_file%!
    echo Ejecutando limpieza posterior...
    powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0post_md_cleanup.ps1" "%output_file%"
    if %errorlevel% equ 0 (
        echo Limpieza completada.
    ) else (
        echo Ocurrio un problema durante la limpieza.
    )
) else (
    echo Error al convertir el archivo
)

pause
