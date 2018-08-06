param(
 [Parameter(Mandatory=$true)]
 [string]
 $packageLocation,
 [string]
 $certSubjectName)
 
 SetupIis;
 CreateWebsite -PackageLocation $packageLocation -SiteName "" -CertificateSubject $certSubjectName

function SetupIis(){
# This script installs IIS and the features required to run asp.net applications

# * Make sure you run this script from an Admin Prompt!
# * Make sure Powershell Execution Policy is bypassed to run these scripts:
# * YOU MAY HAVE TO RUN THIS COMMAND PRIOR TO RUNNING THIS SCRIPT!
# Set-ExecutionPolicy Bypass -Scope Process

# these ar eneeded to turn on the .netextensibiity and asp.net
# these are idempotent
Add-WindowsFeature NET-Framework-45-ASPNET
Add-WindowsFeature NET-HTTP-Activation

Enable-WindowsOptionalFeature -Online -FeatureName IIS-WebServerRole
Enable-WindowsOptionalFeature -Online -FeatureName IIS-WebServer
Enable-WindowsOptionalFeature -Online -FeatureName IIS-CommonHttpFeatures
Enable-WindowsOptionalFeature -Online -FeatureName IIS-HttpErrors
Enable-WindowsOptionalFeature -Online -FeatureName IIS-HttpRedirect
Enable-WindowsOptionalFeature -Online -FeatureName IIS-ApplicationDevelopment
Enable-WindowsOptionalFeature -Online -FeatureName IIS-HealthAndDiagnostics
Enable-WindowsOptionalFeature -Online -FeatureName IIS-HttpLogging
Enable-WindowsOptionalFeature -Online -FeatureName IIS-Security
Enable-WindowsOptionalFeature -Online -FeatureName IIS-RequestFiltering
Enable-WindowsOptionalFeature -Online -FeatureName IIS-Performance
Enable-WindowsOptionalFeature -Online -FeatureName IIS-WebServerManagementTools
Enable-WindowsOptionalFeature -Online -FeatureName IIS-IIS6ManagementCompatibility
Enable-WindowsOptionalFeature -Online -FeatureName IIS-Metabase
Enable-WindowsOptionalFeature -Online -FeatureName IIS-ManagementConsole
Enable-WindowsOptionalFeature -Online -FeatureName IIS-StaticContent
Enable-WindowsOptionalFeature -Online -FeatureName IIS-DefaultDocument
Enable-WindowsOptionalFeature -Online -FeatureName IIS-WebSockets
Enable-WindowsOptionalFeature -Online -FeatureName IIS-ApplicationInit
Enable-WindowsOptionalFeature -Online -FeatureName IIS-ISAPIExtensions
Enable-WindowsOptionalFeature -Online -FeatureName IIS-ISAPIFilter
Enable-WindowsOptionalFeature -Online -FeatureName IIS-HttpCompressionStatic                                              
Enable-WindowsOptionalFeature -Online -FeatureName IIS-NetFxExtensibility                                     
Enable-WindowsOptionalFeature -Online -FeatureName IIS-NetFxExtensibility45                                   
Enable-WindowsOptionalFeature -Online -FeatureName IIS-ASPNET                                                 
Enable-WindowsOptionalFeature -Online -FeatureName IIS-ASPNET45                                               
Enable-WindowsOptionalFeature -Online -FeatureName IIS-ASP 
Enable-WindowsOptionalFeature -Online -FeatureName IIS-WebDAV
Enable-WindowsOptionalFeature -Online -FeatureName IIS-ServerSideIncludes
Enable-WindowsOptionalFeature -Online -FeatureName IIS-FTPServer  
Enable-WindowsOptionalFeature -Online -FeatureName IIS-FTPSvc
Enable-WindowsOptionalFeature -Online -FeatureName IIS-ManagementService
Enable-WindowsOptionalFeature -Online -FeatureName IIS-ManagementScriptingTools                               
Enable-WindowsOptionalFeature -Online -FeatureName IIS-ManagementService                                      
Enable-WindowsOptionalFeature -Online -FeatureName IIS-WMICompatibility
Enable-WindowsOptionalFeature -Online -FeatureName IIS-LegacySnapIn                                           
Enable-WindowsOptionalFeature -Online -FeatureName IIS-LegacyScripts  

}

function CreateWebsite([string] $PackageLocation, [string] $SiteName, [string] $CertificateSubject){
$TargetDir = 'C:\inetpub\wwwroot\'
#$PackageLocation = 'F:\TestWebApp'
#$SiteName = 'TestWebApp'
#$CertificateSubject = 'fabric.mgmtiothub.local.azurestack.external'

# 1 : create root directory, if not exists
if(!(Test-Path -Path $TARGETDIR )){
    New-Item -ItemType directory -Path $TargetDir
}

# 2 : Copy the package folder
Copy-Item -Path $PackageLocation -Destination $TargetDir –Recurse -Force

#3 Set up the IIS website
Write-Output "$TargetDir$FolderName"
New-WebSite -Name $SiteName -PhysicalPath "$TargetDir$SiteName" -Force

#4 Remove the default web binding
Remove-WebBinding -name $SiteName -Protocol http

#5 Create a web binding and add the certificate
New-WebBinding -name $SiteName -Protocol https -Port 443

$cert = Get-ChildItem -Path 'Cert:\LocalMachine\My' | Where-Object {$_.Subject -match $CertificateSubject}
$binding = Get-WebBinding -Name $SiteName
$binding.AddSslCertificate($cert.GetCertHashString(),'My')

#6 Start the website
Start-Website -Name $SiteName 

}