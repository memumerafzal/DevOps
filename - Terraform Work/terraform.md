# Terraform with an accompanying script to deploy an Azure Virtual Machine

## Terraform Configuration File (main.tf) is in same directory.
## Terraform deployment script (deploy.sh) is in same directory.

## Usage Instructions
1. Install Terraform and Azure CLI.
2. Authenticate to Azure using:
   ```sh
   az login
   ```
3. Save the Terraform configuration as `main.tf`.
4. Save the deployment script as `deploy.sh` and make it executable:
   ```sh
   chmod +x deploy.sh
   ```
5. Run the script:
   ```sh
   ./deploy.sh
   ```

This will deploy an Azure VM inside a virtual network. Let me know if you need modifications! 🚀

