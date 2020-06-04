# test script just to see how it runs

$stepSeconds = 15
$continue = $true
$scriptversion = "0.0.1"

while ($continue) {

    Write-Output "Start of loop: $(Get-Date)"
    Write-Output "Script version: $scriptversion"
    Write-Output "Hostname: $(hostname)"
    Write-Output "Wait: $stepSeconds sec"
    Write-Output "End loop $(Get-Date)"
    Start-Sleep -Seconds $stepSeconds

}