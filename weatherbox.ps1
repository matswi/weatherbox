# test script just to see how it runs

Set-Location $PSScriptRoot

Import-Module ./Microsoft.PowerShell.IoT/
Import-Module ./Microsoft.PowerShell.IoT.BME280/


$stepSeconds = 15
$continue = $true
$scriptversion = "0.0.12"

$startTime = Get-Date

$pswhVersion = $PSVersionTable.psversion.ToString()

$sensor = Get-BME280Device

$VerbosePreference = "Continue"

$settings = Get-Content ./weatherBoxConfig.json | ConvertFrom-Json

$uri = $settings.insertUri
$apiKey = $settings.insertKey

$headers = @{
    "x-functions-key" = $apiKey
}

while ($continue) {

    $sensorData = Get-BME280Data -Device $sensor

    $humidity    = $sensorData.Humidity
    $temperature = $sensorData.Temperature
    $pressure    = $sensorData.Pressure

    $dataObject = [pscustomobject]@{
        Name        = $(hostname)
        Humidity    = $humidity
        Temperature = $temperature
        Pressure    = $pressure
    }

    try {
        $body = $dataObject | ConvertTo-Json
        $result = Invoke-WebRequest -Uri $uri -UseBasicParsing -Method Post -Body $body -Headers $headers
    }
    catch {
        Write-Verbose $_
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