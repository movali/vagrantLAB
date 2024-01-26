# See: https://www.petri.com/using-nat-virtual-switch-hyper-v

If ("VT-LAN-11" -in (Get-VMSwitch | Select-Object -ExpandProperty Name) -eq $FALSE) {
    'Creating Internal-only switch named "VT-LAN-11" on Windows Hyper-V host...'

    New-VMSwitch -SwitchName "VT-LAN-11" -SwitchType Internal

    New-NetIPAddress -IPAddress 192.168.11.254 -PrefixLength 24 -InterfaceAlias "vEthernet (VT-LAN-11)"

    New-NetNAT -Name "VT-LAN-11" -InternalIPInterfaceAddressPrefix 192.168.11.0/24
}
else {
    '"VT-LAN-11" for static IP configuration already exists; skipping'
}

If ("192.168.11.1" -in (Get-NetIPAddress | Select-Object -ExpandProperty IPAddress) -eq $FALSE) {
    'Registering new IP address 192.168.11.1 on Windows Hyper-V host...'

    New-NetIPAddress -IPAddress 192.168.11.254 -PrefixLength 24 -InterfaceAlias "vEthernet (VT-LAN-11)"
}
else {
    '"192.168.11.1" for static IP configuration already registered; skipping'
}

If ("192.168.11.0/24" -in (Get-NetNAT | Select-Object -ExpandProperty InternalIPInterfaceAddressPrefix) -eq $FALSE) {
    'Registering new NAT adapter for192.168.11.0/24 on Windows Hyper-V host...'

    New-NetNAT -Name "NATNetwork" -InternalIPInterfaceAddressPrefix 192.168.11.0/24
}
else {
    '"192.168.11.0/24" for static IP configuration already registered; skipping'
}