# Ansible Traning Machines in Azure

Azure Resource Manager templates for deploying 3 linux boxes in Azure for Ansible training

## Usage

* Open in PowerShell ISE. 
* Connect to your Azure subscription
* `Switch-AzureMode AzureResourceManager`
* `New-AzureResourceGroup -Name TniceRG1 -Location "East US 2" -TemplateFile "C:\at3hosts\azuredeploy.json" -TemplateParameterFile "C:\at3hosts\azuredeploy.parameters.json"`