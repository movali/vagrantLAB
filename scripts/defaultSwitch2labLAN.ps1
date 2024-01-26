Get-VM "ansible" | Get-VMNetworkAdapter | Connect-VMNetworkAdapter -SwitchName "VT-LAN-11"
Get-VM "debian" | Get-VMNetworkAdapter | Connect-VMNetworkAdapter -SwitchName "VT-LAN-11"
Get-VM "rocky" | Get-VMNetworkAdapter | Connect-VMNetworkAdapter -SwitchName "VT-LAN-11"
Get-VM "suse" | Get-VMNetworkAdapter | Connect-VMNetworkAdapter -SwitchName "VT-LAN-11"
Get-VM "ubuntu" | Get-VMNetworkAdapter | Connect-VMNetworkAdapter -SwitchName "VT-LAN-11"

Restart-VM -VMName "ansible" -Force
Restart-VM -VMName "debian" -Force
Restart-VM -VMName "rocky" -Force
Restart-VM -VMName "suse" -Force
Restart-VM -VMName "ubuntu" -Force