#!/bin/bash
Source_Name="keyvaulsecrets1"
Dest_Name="keyvaulsecrets2"
Source_SECRETS=$(az keyvault secret list --vault-name $Source_Name --query "[].id" -o tsv)
# list out the destination key valut
Dest_SECRETS=$(az keyvault secret list --vault-name $Dest_Name --query "[].id" -o tsv)

# compare with source account
for SECRET in $Source_SECRETS; do
SECRETNAME=$(echo "$SECRET" | sed 's|.*/||')
SECRET_CHECK=$(az keyvault secret list --vault-name $Source_Name --query "[?name=='$SECRETNAME']" -o tsv)
echo "$SECRETNAME"
if [ -n "$SECRET_CHECK" ]
then
    echo "$SECRETNAME exists in $Source_Name"
    SECRET_VALUE_CHECK=$(az keyvault secret show --vault-name $Source_Name -n $SECRETNAME --query "value" -o tsv)
    DEST_VALUE_CHECK=$(az keyvault secret show --vault-name $Dest_Name -n $SECRETNAME --query "value" -o tsv)
if [ "$SECRET_VALUE_CHECK" == "$DEST_VALUE_CHECK" ]
then
        echo "test1"

      echo "$SECRETNAME already exists in $Dest_Name"
else
        echo "test"
      echo "Copying $SECRETNAME from Source KeyVault: $Source_Name to Destination KeyVault: $Dest_Name"
      SECRET=$(az keyvault secret show --vault-name $Source_Name -n $SECRETNAME --query "value" -o tsv)
      az keyvault secret set --vault-name $Dest_Name -n $SECRETNAME --value "$SECRET" >/dev/null
fi
else
    echo "$SECRETNAME not exists in $Source_Name"

    
    test
    test2


fi
done
