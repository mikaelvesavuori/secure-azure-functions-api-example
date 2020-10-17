##########################################
# Post-fix Serverless Framework security #
##########################################

# Documentation and references:
# https://docs.microsoft.com/bs-latn-ba/azure/storage/blobs/security-recommendations
# https://docs.microsoft.com/en-us/cli/azure/storage/account?view=azure-cli-latest#az_storage_account_update
# https://docs.microsoft.com/en-us/cli/azure/functionapp/config?view=azure-cli-latest

# Set variable names
# You can easily get these through your deployment information, else check Azure CLI or Azure Portal
RG_NAME=SECURE_API
FUNCTIONAPP_NAME=sls-neur-dev-secure-azure-functions-api
STORAGE_NAME=slsneurdev??????

# Secure storage
az storage account update \
  --name $STORAGE_NAME \
  --resource-group $RG_NAME \
  --allow-blob-public-access false \
  --https-only true \
  --min-tls-version TLS1_2

# Secure function app
# If you don't want to disable FTP, use "FtpsOnly"
az functionapp config set \
  --name $FUNCTIONAPP_NAME \
  --resource-group $RG_NAME \
  --ftps-state Disabled \
  --http20-enabled true \
  --min-tls-version 1.2 \
  --use-32bit-worker-process false

# Set function app to only use HTTPS
az functionapp update \
  --name $FUNCTIONAPP_NAME \
  --resource-group $RG_NAME \
  --set httpsOnly=true