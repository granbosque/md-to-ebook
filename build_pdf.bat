@echo off
setlocal enabledelayedexpansion

REM Verificar si se arrastró un archivo
if "%~1"=="" (
    echo Uso: Arrastra un archivo .md sobre este archivo bat
    echo O ejecuta: build_pdf.bat archivo.md
    pause
    exit /b 1
)

REM Obtener el nombre del archivo sin extensión
set "input_file=%~1"
set "base_name=%~n1"
set "md_dir=%~dp1"
set "html_file=%md_dir%%base_name%.html"
set "output_file=%md_dir%%base_name%.pdf"

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

echo Generando HTML: %html_file%
echo Archivo fuente: %input_file%

REM Generar HTML con pandoc usando los estilos CSS especificados
pandoc "%input_file%" -s --template="%~dp0template.html" -c "%~dp0pdf.css" --section-divs --embed-resources --resource-path="%~dp1;." -o "%html_file%"

if %errorlevel% neq 0 (
    echo Error al generar el HTML
    pause
    exit /b 1
)

echo HTML generado exitosamente: %html_file%

echo.
echo HTML generado: "%html_file%"
echo.
echo Abre el HTML con Chrome o Edge y usa Imprimir, Guardar como PDF.
echo Asegurate de seleccionar:
echo 1. Destino: Guardar como PDF
echo 2. Margenes: Predeterminado
echo 3. Desactivar encabezados y pies de pagina
echo.
pause
