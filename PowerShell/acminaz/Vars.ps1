[String] $SubscriptionName_="BizSpark"
[string] $CloudServiceName_="anciblecm-tnice"
[string] $Location_="East US 2"
#~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~
[Array] $VMNamesList_=@( "anciblecm-tnice")
[array] $SSHPortNumbers_=@(22)
[array] $StorageAccountList_=@("anciblecmtnicestr1")
[string] $VMSize_="Basic_A1"
[string] $AzureOSImageName_ = "b39f27a8b8c64d52b05eac6a62ebad85__Ubuntu-14_10-amd64-server-20150620-en-us-30GB"
#~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~
[string] $LinuxUserName_="nice"
$SshCertToDeploy_ = ($PSScriptRoot + "\c_ssh_public_azure.pem")
$sshkeypath_ = "/home/$LinuxUserName_/.ssh/authorized_keys"
$SSHFingerprint_ = "56367D8E12F800FBA994302DE471059C591AC617"

#~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~
$ExtensionName = 'CustomScriptForLinux'  
$Publisher = 'Microsoft.OSTCExtensions'  
$Version = '1.*' 
$PublicConfiguration = '{"fileUris":["https://raw.githubusercontent.com/kdsnice/Scripts/master/InstallAnsible/InstallAnsible.sh"], "commandToExecute": "sudo bash InstallAnsible.sh" }'
