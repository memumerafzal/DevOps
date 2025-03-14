# Terraform Azure VM Deployment

## Prerequisites
- Install [Terraform](https://www.terraform.io/downloads)
- Install [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)

## Setup Instructions
1. Authenticate to Azure:
   ```sh
   az login
2. Save the Terraform configuration as `main.tf`.
3. Save the deployment script as `deploy.sh` and make it executable:
   ```sh
   chmod +x deploy.sh
   ```
4. Run the script:
   ```sh
   ./deploy.sh
   ```

This will deploy an Azure VM inside a virtual network. Let me know if you need modifications!
