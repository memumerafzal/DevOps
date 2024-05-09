# SetUp Nexus

#!/bin/bash

# Refresh package manager repositories
sudo apt-get update

# Obtain essential dependencies
sudo apt-get install -y ca-certificates curl

# Establish directory for Docker GPG key
sudo install -m 0755 -d /etc/apt/keyrings

# Retrieve Docker's GPG key
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc

# Ensure proper permissions for the key
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Integrate Docker repository into Apt sources
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
$(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Refresh package manager repositories
sudo apt-get update

sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin


#Store this script in a file, such as install_docker.sh, and grant executable permissions by executing:

```bash
chmod +x install_docker.sh
```

#Then, you can run the script using:

```bash
./install_docker.sh
```

## Deploy Nexus Using Docker Container

To deploy a Docker container hosting Nexus 3, accessible via port 8081, execute the following command:

```bash
docker run -d --name nexus -p 8081:8081 sonatype/nexus3:latest
```

This command does the following:

- `-d`: Detaches the container, allowing it to run in the background..
- `--name nexus`: Assigns the container the name "nexus".
- `-p 8081:8081`: Maps port 8081 on the host to port 8081 on the container, facilitating access to Nexus via port 8081.
- `sonatype/nexus3:latest`: Specifies the Docker image for the container, here utilizing the latest version of Nexus 3 from the Sonatype repository.


Upon execution of this command, Nexus will be reachable on your host machine at http://IP:8081.



