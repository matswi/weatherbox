# test script just to see how it runs
Import-Module ./Microsoft.PowerShell.IoT/
Import-Module ./Microsoft.PowerShell.IoT.BME280/


$stepSeconds = 15
$continue = $true
$scriptversion = "0.0.8"

$pswhVersion = $PSVersionTable.psversion.ToString()

$sensor = Get-BME280Device

$VerbosePreference = "Continue"

while ($continue) {

    $sensorData = Get-BME280Data -Device $sensor

    $dataObject = [pscustomobject]@{
        Name        = $(hostname) #"HomePS"
        Humidity    = $sensorData.Humidity
        Temperature = $sensorData.Temperature
        Pressure    = $sensorData.Pressure
    }

    Write-Verbose $dataObject
    
    Write-Output "Start of loop: $(Get-Date)"
    Write-Output "Powershell version: $pswhVersion"
    Write-Output "Script version: $scriptversion"
    Write-Output "Hostname: $(hostname)"
    Write-Output "Wait: $stepSeconds sec"
    Write-Output "End loop $(Get-Date)"
    Start-Sleep -Seconds $stepSeconds

}