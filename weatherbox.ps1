# test script just to see how it runs
Import-Module ./Microsoft.PowerShell.IoT/
Import-Module ./Microsoft.PowerShell.IoT.BME280/


$stepSeconds = 15
$continue = $true
$scriptversion = "0.0.9"

$startTime = Get-Date

$pswhVersion = $PSVersionTable.psversion.ToString()

$sensor = Get-BME280Device

$VerbosePreference = "Continue"

while ($continue) {

    $sensorData = Get-BME280Data -Device $sensor

    $humidity    = $sensorData.Humidity
    $temperature = $sensorData.Temperature
    $pressure    = $sensorData.Pressure

    $dataObject = [pscustomobject]@{
        Name        = $(hostname) #"HomePS"
        Humidity    = $humidity
        Temperature = $temperature
        Pressure    = $pressure
    }

    Write-Verbose $dataObject
    
    Write-Output "Start of loop: $(Get-Date)"
    Write-Output "Powershell version: $pswhVersion"
    Write-Output "Script version: $scriptversion"
    Write-Output "Hostname: $(hostname)"
    Write-Output "Start Time: $startTime"
    $Duration = ((get-date) - $startTime).TotalHours
    Write-Output ("Duration: {0:F2} Hours" -f $Duration)
    Write-Output "Wait: $stepSeconds sec"
    Write-Output "End loop $(Get-Date)"
    Start-Sleep -Seconds $stepSeconds

}