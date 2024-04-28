# Creating an Ubuntu Virtual Machine in Azure

## Sign in to the Azure Portal:
   - Navigate to the Azure Management Portal at [https://portal.azure.com/](https://portal.azure.com/).
   - Sign in with your Azure account credentials.

## Navigate to Virtual Machines:
   - Once logged in, click on "Virtual Machines" in the Azure dashboard menu, or you can use the search bar at the top and type "Virtual Machines" to navigate directly.

## Create Virtual Machine:
   - Click on the "Add" button to create a new virtual machine.

## Choose a Base Image:
   - In the "Basics" tab of the creation process, select the desired base image. Choose "Ubuntu" from the available options.
   - Select the Ubuntu version you prefer, such as "Ubuntu Server 20.04 LTS".
   - Click "Next: Disks".

## Configure Disks and Networking:
   - Configure the disk size and networking settings as per your requirements. You can keep the default settings for now if they suit your needs.
   - Click "Next: Management".

## Configure Management Options:
   - Optionally, configure management options like monitoring, boot diagnostics, etc. You can leave these settings as default if desired.
   - Click "Review + create".

## Review and Create:
   - Review the configuration details of your virtual machine.
   - Click "Create" to start the deployment process.

## Deployment Progress:
   - Wait for the deployment process to complete. You can track the progress in the Azure portal.

## Connect to the Virtual Machine:
   - Once the virtual machine is deployed, you can connect to it using SSH or RDP, depending on the OS and configuration.
   - Use your preferred SSH client to connect to the Ubuntu instance.
