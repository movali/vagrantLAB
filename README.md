# Vagrant Lab  
In dieser Anleitung wird die Einrichtung einer Ansible IT-LAB Umgebung auf Grundlage des Buches Ansible beschrieben. Im Unterschied zum Buch wird als Vagrant-Host Hyper-V verwendet, zusammen mit einer **PFsense/Firewall**, um die IP-Adressvergabe zu steuern. In einer Hyper-V Umgebung ist es nicht möglich, Vagrant statische IPs zuzuweisen. Daher wird in einem Workaround das System zunächst mit dem **Default-Switch** initialisiert und mittels Prozessen und den Skripten
- `scripts\configure-static-ip.sh` und `scripts\set-hyperv-switch.ps1` werden den einzelnen Containern statische IPs zugewiesen, sowie die Netzwerkkarte auf das `labLAN` geändert. Schließlich wird durch das **RELOAD** Plugin die Umgebung neugestartet.

## Installation
1. In einem ersten Schritt wird die Windows Workstation in der Datei `C:\Windows\System32\drivers\etc\hosts` angepasst, um die Zielsysteme zu erkennen.

```
 # OPNSENSE
192.168.11.1 opnsense
 # Vagrant
192.168.11.50 ansible
192.168.11.51 debian
192.168.11.52 rocky
192.168.11.53 suse
192.168.11.54 ubuntu
```
2. Aus dem [GIT-Repo](https://github.com/movali/itlab) werden Ressourcen heruntergeladen und das Projekt in Visual Studio Code gestartet.

```
cd w:\tutoial
git clone git@github.com:movali/itlab.git
cd itlab
code .

# Terminal in VS-Code öffnen und in den Ordner vagrantLAB wechseln
cd vagrantLAB

# Reload Plugin zur Provisionierung in ein Vagrant Projekt hinzufügen
vagrant plugin install vagrant-reload

# Container starten
vagrant up --provider hyperv
```

- ISSUE1/ Workaround Von Default Switch auf labLAN umstellen`.\scripts\defaultSwitch2labLAN.ps1`

```
# Mit dem CTL, in diesem Fall der Ansible Container SSH-Key austauschen. Hierfür die Git-Bash Konsole verwenden
ssh-copy-id vagrant@ansible
```
- Einrichten der VS Code-IDE und Herstellen einer FTP-Verbindung zum Remote CTL-Host.
```
# Read more about SSH config files: https://linux.die.net/man/5/ssh_config

  Host ansible

  HostName ansible

  user vagrant

  IdentityFile ~/.ssh/id_rsa

  

  Host debian

  HostName debian

  user vagrant

  IdentityFile ~/.ssh/id_rsa

  

  Host rocky

  HostName rocky

  user vagrant

  IdentityFile ~/.ssh/id_rsa

  

  Host suse

  HostName suse

  user vagrant

  IdentityFile ~/.ssh/id_rsa

  

  Host ubuntu

  HostName ubuntu

  user vagrant

  IdentityFile ~/.ssh/id_rsa
```
^SSH-CONFIG

```json
  [

  {

    "name": "ansible",

    "host": "ansible",

    "port": 22,

    "type": "sftp",

    "username": "vagrant",

    "password": "vagrant",

    "path": "/home/vagrant",

    "autosave": false,

    "confirm": true

  }

]
```
^SFTP-CONFIG




