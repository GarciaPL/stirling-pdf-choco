$ErrorActionPreference = 'Stop'

$packageName = 'stirling-pdf'
$softwareName = 'Stirling*PDF*'

$uninstallKey = Get-UninstallRegistryKey -SoftwareName $softwareName

if ($uninstallKey.Count -eq 1) {
  $key = $uninstallKey[0]
  $productCode = $key.PSChildName

  $packageArgs = @{
    packageName    = $packageName
    fileType       = 'msi'
    silentArgs     = "$productCode /qn /norestart"
    validExitCodes = @(0, 3010, 1605, 1614, 1641)
    file           = $productCode
  }

  Uninstall-ChocolateyPackage @packageArgs
} elseif ($uninstallKey.Count -eq 0) {
  Write-Warning "$packageName has already been uninstalled by other means."
} elseif ($uninstallKey.Count -gt 1) {
  Write-Warning "$($uninstallKey.Count) matches found for '$softwareName'. Refine `$softwareName in tools\chocolateyUninstall.ps1."
  $uninstallKey | ForEach-Object { Write-Warning "- $($_.DisplayName)" }
}
