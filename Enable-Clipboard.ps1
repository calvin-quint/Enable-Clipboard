# Function to enable clipboard history
function Enable-ClipboardHistory {
    param (
        [string]$RegistryPath
    )
    try {
        # Enable clipboard history by setting the registry value to 1
        Set-ItemProperty -Path $RegistryPath -Name "EnableClipboardHistory" -Value 1 -Type DWORD -ErrorAction Stop
        return $true
    } catch {
        return $false
    }
}

# Specify the registry path
$registryPath = "HKCU:\Software\Microsoft\Clipboard"

# Check if the registry path exists
if (Test-Path $registryPath) {
    # Get the current value of EnableClipboardHistory
    $enableClipboardHistory = (Get-ItemPropertyValue -Path $registryPath -Name "EnableClipboardHistory" -ErrorAction SilentlyContinue) -eq 1

    if ($enableClipboardHistory) {
        Write-Host "Clipboard history is already enabled."
    } else {
        # Attempt to enable clipboard history
        if (Enable-ClipboardHistory -RegistryPath $registryPath) {
            Write-Host "Clipboard history has been enabled."
        } else {
            Write-Host "Failed to enable clipboard history."
            exit 1  # Exit with code 1 indicating failure
        }
    }
} else {
    Write-Host "Registry path not found: $registryPath"
    exit 1  # Exit with code 1 indicating failure
}

exit 0  # Exit with code 0 indicating success
