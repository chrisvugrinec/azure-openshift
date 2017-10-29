#!/bin/bash

echo "name:"
read rgname

echo "openshift user:"
read osuser

echo "openshift password:"
read ospassword

echo "AAD SP password:"
read password

echo "your ssh pub key"
read sshkey
sshKey=$(echo "$sshkey" | sed 's/\//\\\//g')


#create resource group
az group create -n $rgname -l 'westeurope'

#create keyvault 
az keyvault create -n $rgname-kv -g $rgname -l 'westeurope' --enabled-for-template-deployment true
 
#determine groupid (needed for for RBAC) 
#create service principal, don't forget to register the appId 
groupid=$(az group list --query "[?contains(name,'"$rgname"')]" | jq -r '.[].id')
aadclientid=$(az ad sp create-for-rbac -n $rgname-sp --role="Contributor" --scopes=$groupid --password $password | jq -r '.appId')

#Change parameter file…
rm -f azuredeploy-parameters.json?
cp azuredeploy-parameters.json.template azuredeploy-parameters.json

sed -in 's/XXX_NAME_XXX/'$rgname'/g' ./azuredeploy-parameters.json
sed -in 's/XXX_OSUSER_XXX/'$osuser'/g' ./azuredeploy-parameters.json
sed -in 's/XXX_OSPASSWORD_XXX/'$ospassword'/g' ./azuredeploy-parameters.json
sed -in "s/XXX_SSH_XXX/\"$sshKey\"/g" ./azuredeploy-parameters.json
sed -in 's/XXX_KVRG_XXX/'$rgname'/g' ./azuredeploy-parameters.json
sed -in 's/XXX_KVNAME_XXX/'$rgname-kv'/g' ./azuredeploy-parameters.json
sed -in 's/XXX_AADCLIENTID_XXX/'$aadclientid'/g' ./azuredeploy-parameters.json
sed -in 's/XXX_AADCLIENTSECRET_XXX/'$password'/g' ./azuredeploy-parameters.json
 
#Keyvault secret:
#List
#az keyvault secret list --vault-name openshiftdemo-kv  keyVaultSecret…Hier ff opletten…openshift-secret


echo "for some weird reason unable to script...please copy paste this command"
echo "az keyvault secret set --vault-name "$rgname-kv" --name openshift-secret --file PATH_TO_YOUR_PRIVATE_SSHKEY"
 
#Create the Openshift Origin setup 
echo "now create with the following command:"
echo "az group deployment create -g $rgname --template-file azuredeploy.json --parameters @azuredeploy-parameters.json
 
#Orginal from:  https://github.com/Microsoft/openshift-origin
#oc login https://masterdnswmdjtnhuu36fm.westeurope.cloudapp.azure.com:8443
#oc project chris1
#oc status
#oc expose rc azure-openshift-pythonflaskapp-5 --port=5000
