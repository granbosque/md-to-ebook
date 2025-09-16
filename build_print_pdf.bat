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
set "html_file=%md_dir%%base_name%_print.html"
set "output_file=%md_dir%%base_name%_print.pdf"

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
pandoc "%input_file%" -s --template="%~dp0print_template.html" -c "%~dp0print_pdf.css" --section-divs --embed-resources --resource-path="%~dp1;." -o "%html_file%"

if %errorlevel% neq 0 (
    echo Error al generar el HTML
    pause
    exit /b 1
)

echo HTML generado exitosamente: %html_file%
echo.
echo ===============================================
echo INSTRUCCIONES PARA GENERAR PDF:
echo ===============================================
echo 1. Abre Chrome y navega a: file:///%html_file%
echo 2. Presiona Ctrl+P para imprimir
echo 3. Selecciona "Guardar como PDF" como destino
echo 4. Configura los márgenes como "Mínimos"
echo 5. Desactiva "Encabezados y pies de página"
echo 6. Haz clic en "Guardar"
echo.
echo Archivo HTML: %html_file%
echo ===============================================

pause
