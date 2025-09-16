param(
    [Parameter(Mandatory = $true, Position = 0)]
    [string]$Path
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

if (-not (Test-Path -LiteralPath $Path)) {
    Write-Error "Archivo no encontrado: $Path"
}

$text = Get-Content -LiteralPath $Path -Raw -Encoding UTF8

# 1) Asegurar bloque YAML al inicio. Si ya existe (--- ... ---), no tocar.
$hasYaml = $false
if ($text -match "(?s)\A\s*---\r?\n.*?\r?\n---\s*(?:\r?\n|\z)") {
    $hasYaml = $true
}

if (-not $hasYaml) {
    # Generar YAML mínimo
    $fileName = [System.IO.Path]::GetFileNameWithoutExtension($Path)
    $today = (Get-Date).ToString('yyyy-MM-dd')
    $yaml = "---`n" +
            "title: '$fileName'`n" +
            "author: ''`n" +
            "date: '$today'`n" +
            "lang: es`n" +
            "---`n`n"
    $text = $yaml + $text
}

# 2) Eliminar encabezados vacíos: líneas que son solo #, ##, etc con opcional espacio
$text = $text -replace "(?m)^(#{1,6})\s*$\r?\n?", ""

# 3) Eliminar anchors vacíos del estilo []{#id} o {#id} solos en línea
#    - líneas completas con solo []{#...} o {#...}
$text = $text -replace "(?m)^\s*\[\]\{#[-A-Za-z0-9_]+\}\s*$\r?\n?", ""
$text = $text -replace "(?m)^\s*\{#[-A-Za-z0-9_]+\}\s*$\r?\n?", ""

#    - anchors incrustados justo antes del texto del encabezado: []{#id}Título → Título
$text = $text -replace "(?m)^\s*\[\]\{#[-A-Za-z0-9_]+\}(\S)", '$1'

# 4) Quitar blockquotes vacíos: líneas que son solo '>' o '>' con espacios
$text = $text -replace "(?m)^>\s*$\r?\n?", ""

# 5) Normalizar múltiples saltos en blanco consecutivos a como máximo dos
$text = $text -replace "\n{3,}", "`n`n"

# 6) Podar espacios en blanco al final de líneas
$text = ($text -split "\r?\n") | ForEach-Object { $_ -replace "\s+$", "" } | Out-String

Set-Content -LiteralPath $Path -Value $text -Encoding UTF8 -NoNewline:$false
Write-Output "Limpieza aplicada a $Path"


