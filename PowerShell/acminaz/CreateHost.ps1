<#
Created by Karanfilov Dmitry
#>

# dot source script with Volt environment variables
. ($PSScriptRoot + "\Vars.ps1")
. ($PSScriptRoot + "\Functions.ps1")

[string] $VMURL = $CloudServiceName_ + ".cloudapp.net"

Select-AzureSubscription $SubscriptionName_

#create azure cloud service
New-AzureService -ServiceName $CloudServiceName_ -Location $Location_ 
Add-AzureCertificate –ServiceName $CloudServiceName_ –CertToDeploy $SshCertToDeploy_

CreateAzureStorageAccountsWithLocation `
  -SubscriptionName $SubscriptionName_ `
  -Location $Location_ `
  -StorageAccountList $StorageAccountList_

#create VM

[int] $vm_counter = 0 

	foreach ($VMName in $VMNamesList_ ) 
	{
	# ResetCurrentStorageAccount
	Set-AzureSubscription -SubscriptionName $SubscriptionName_ 

	# set new storage account 
	Set-AzureSubscription -SubscriptionName $SubscriptionName_ -CurrentStorageAccountName $StorageAccountList_[$vm_counter]

    deploy_one_vm `
			-SubscriptionName $SubscriptionName_ `
			-CloudServiceName $CloudServiceName_ `
			-OneVMName $VMName `
			-OneSSHPortNumber $SSHPortNumbers_[$vm_counter] `
			-VMSize $VMSize_ `
			-AzureOSImageName $AzureOSImageName_  `
			-LinuxUserName $LinuxUserName_ `
		    -SSHFingerprint $SSHFingerprint_ `
            -sshkeypath $sshkeypath_ 

    $VMObj_ = Get-AzureVM -ServiceName $CloudServiceName_ –Name $VMName
    Set-AzureVMExtension -ExtensionName $ExtensionName -VM  $VMObj_ -Publisher $Publisher -Version $Version -PublicConfiguration $PublicConfiguration  | Update-AzureVM

	 $vm_counter = $vm_counter + 1
	}
