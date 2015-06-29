# Ansible Control Machine in Azure

PowerShell scripts for deploying Ubuntu 14.10 in Azure and installing Ansible 

## Usage

* Put your public ssh-key as PEM-certificate to the `acminaz` folder. (See below)
* Fill out appropriate variables in `Vars.ps1`.
* Open `CreateHost.ps1` in PowerShell ISE. 
* Connect to your Azure subscription. 
* Hit 'Run Script' button in PowerShell ISE. 

## Generate a PEM-certificate from an Existing OpenSSH Private Key

```bash
openssl req -x509 -key <path_to_OpenSSH_private_key> -nodes -days 365 -newkey rsa:2048 -out myCert.pem
```
In order to get value for `$SSHFingerprint_` variable in `Vars.ps1`, run following command:
```bash
openssl x509 -fingerprint -sha1 -in myCert.pem -noout | tr -d :
```