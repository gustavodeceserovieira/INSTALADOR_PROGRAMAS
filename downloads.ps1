param(
    [string]$baseUrl,
    [string]$pasta
)
$arquivos = @(
    "AnyDesk.exe",
    "Visualizador_fotos.reg",
    "Kaspersky.exe",
    "Ntfs_reader.exe",
    "office.zip"
)

foreach ($arquivo in $arquivos) {
    Write-Host "Baixando $arquivo..."
    Invoke-WebRequest `
        -Uri "$baseUrl/$arquivo" `
        -OutFile "$pasta\$arquivo"
}