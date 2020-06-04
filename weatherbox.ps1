# test script just to see how it runs

$stepSeconds = 15
$continue = $true

while ($continue) {

    Write-Output "Start of loop: $(Get-Date)"
    Write-Output "Hostname: $(hostname)"
    Write-Output "Wait: $stepSeconds sec"
    Write-Output "End loop $(Get-Date)"
    Start-Sleep -Seconds $stepSeconds
    
}