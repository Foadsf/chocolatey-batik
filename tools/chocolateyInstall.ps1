$ErrorActionPreference = 'Stop'

$packageName = 'batik'
$url = 'https://dlcdn.apache.org/xmlgraphics/batik/binaries/batik-bin-1.18.zip'
$checksum = '5E05B2FBCCB0A60145A30DCC2CA0AE7DC31BB23775BF4CD4E43CF18CFF13B25D65F2B57143EAFDA5FBA53CD15B9F5E18FBFD7E5ABA65C115FD74C8BCD21CDF8D'
$checksumType = 'sha512'

# Determine installation directory
function Get-ProgramFilesDirectory {
  if ($ENV:Processor_Architecture -eq "AMD64") {
    (Get-Item "Env:ProgramFiles(x86)").Value
  }
  else {
    (Get-Item "Env:ProgramFiles").Value
  }
}

$installDir = Join-Path (Get-ProgramFilesDirectory) 'Apache Batik'

# Create install directory if it doesn't exist
if (-not (Test-Path $installDir)) {
  New-Item -ItemType Directory -Path $installDir -Force | Out-Null
}

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $installDir
  url           = $url
  checksum      = $checksum
  checksumType  = $checksumType
}

Install-ChocolateyZipPackage @packageArgs

Write-Host "Apache Batik has been installed to $installDir"