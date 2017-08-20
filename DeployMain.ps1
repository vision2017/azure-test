### Define Deployment Variables
{
$location = 'West Europe'
$resourceGroupName = 'Main-iaas'
$resourceDeploymentName = 'Main-iaas-deployment'
$templatePath = 'C:\AzurePowershell\Test-Task\Main'
$templateFile = 'azureDeploy.json'
$template = $templatePath + '\' + $templateFile
$password= "C0nts0sP@55"
$securePassword = $password | ConvertTo-SecureString -AsPlainText -Force
}

### Create Resource Group
{
New-AzureRmResourceGroup `
    -Name $resourceGroupName `
    -Location $location `
    -Verbose -Force
}

### Deploy Resources
{
$additionalParameters = New-Object -TypeName Hashtable
$additionalParameters['ServerAdminPassword']=$securePassword

New-AzureRmResourceGroupDeployment `
    -Name $resourceDeploymentName `
    -ResourceGroupName $resourceGroupName `
    -TemplateFile $template `
     @additionalParameters `
    -Verbose -Force
}


Remove-AzureRmResourceGroup -Name $resourceGroupName -Confirm -Verbose