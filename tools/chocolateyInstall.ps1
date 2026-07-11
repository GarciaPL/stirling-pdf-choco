$ErrorActionPreference = 'Stop'

# NOTE: filename says .exe but `file` identifies it as a raw MSI (Composite
# Document, "Windows Installer XML Toolset"). It's an MSI, just served with
# an .exe extension. fileType 'msi' below makes Install-ChocolateyPackage
# invoke msiexec regardless of the downloaded file's extension.
$packageName = 'stirling-pdf'
$url         = 'https://files.stirlingpdf.com/win-installer.exe'
$checksum    = '7bcf4073213bb5c6d30d29317383a86aa3282c9e3d733ad876c375bc04d5498e'
$checksumType = 'sha256'

$packageArgs = @{
  packageName    = $packageName
  fileType       = 'msi'
  url            = $url
  checksum       = $checksum
  checksumType   = $checksumType
  silentArgs     = "$($env:chocolateyPackageParameters) /qn /norestart"
  validExitCodes = @(0, 3010, 1605, 1614, 1641)
}

Install-ChocolateyPackage @packageArgs
