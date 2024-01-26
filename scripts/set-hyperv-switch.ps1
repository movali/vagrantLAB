# See: https://www.thomasmaurer.ch/2016/01/change-hyper-v-vm-switch-of-virtual-machines-using-powershell/

param (
    [string]$VmName,
    [string]$SwitchName
)

Get-VM "$VmName" | Get-VMNetworkAdapter | Connect-VMNetworkAdapter -SwitchName "$SwitchName"