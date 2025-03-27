$ErrorActionPreference = 'Stop'

$packageName = 'batik'
$url = 'https://dlcdn.apache.org/xmlgraphics/batik/binaries/batik-bin-1.18.zip'
$checksum = '654958530EA16576A9B44FCACE848439C53753ECCF238A4A37E33D606149EE1E085ABDB6F828E65BEAF2E68327660CDAAB993EE3E44515FDC2C0986F9834E8B9'
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

# Add shims for common Batik tools
$batikPath = Join-Path $installDir "batik-1.18"
Install-BinFile -Name "batik-rasterizer" -Path "$batikPath\batik-rasterizer.bat"
Install-BinFile -Name "batik-svgpp" -Path "$batikPath\batik-svgpp.bat"
Install-BinFile -Name "batik-ttf2svg" -Path "$batikPath\batik-ttf2svg.bat"
Install-BinFile -Name "batik-squiggle" -Path "$batikPath\batik-squiggle.bat"

Write-Host "Apache Batik has been installed to $installDir"