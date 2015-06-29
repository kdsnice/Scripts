Function CreateAzureStorageAccountsWithLocation
{
    param (
        [string]  $SubscriptionName,
        [string]  $Location,
        [array] $StorageAccountList
        )

    Select-AzureSubscription $SubscriptionName

    foreach ($StorageAccountName in $StorageAccountList )
        {

		$StorageAccountName

        #create new storage account if it does not exist
		if ( Test-AzureName -Storage -Name $StorageAccountName ) 
			{
				"Storage account already exists	"
			}
			else
			{
				New-AzureStorageAccount -StorageAccountName $StorageAccountName -Location $Location 
			}
        }
}

Function deploy_one_vm
{
   param (
        [string] $SubscriptionName,
        [string] $CloudServiceName,
        [string] $OneVMName,
        [int] $OneSSHPortNumber,
        ##
        [string] $VMSize,
        [string] $AzureOSImageName, 
        ##
        [string] $LinuxUserName,
        [string] $SSHFingerprint,
        [string] $sshkeypath
       )
    
    
    $sshkey = New-AzureSSHKey -PublicKey -Fingerprint $SSHFingerprint -Path $sshkeypath

    # create VM and add it to existing could service
    New-AzureVMConfig -Name $OneVMName -InstanceSize $VMSize -ImageName $AzureOSImageName -HostCaching ReadWrite | Add-AzureProvisioningConfig –Linux –LinuxUser $LinuxUserName -SSHPublicKeys $sshkey | New-AzureVM -ServiceName $CloudServiceName

    # change endpoint port for SSH
    Get-AzureVM -ServiceName $CloudServiceName –Name $OneVMName | Set-AzureEndpoint -Name "SSH" -PublicPort $OneSSHPortNumber -LocalPort 22 -Protocol "tcp" | Update-AzureVM

    # make sure that the VM is ready before we proceed
    $thisVM = Get-AzureVM -ServiceName $CloudServiceName –Name $OneVMName
    while ($thisVM.InstanceStatus -ne "ReadyRole" )
    {
        "Current Status of $OneVMName is: " + $thisVM.InstanceStatus 
        Start-Sleep -Seconds 15       
        $thisVM = Get-AzureVM -ServiceName $CloudServiceName –Name $OneVMName
    }
}
