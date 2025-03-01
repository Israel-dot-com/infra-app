# Infrastructure Deployment for Todo App

## Overview
This repository contains the Infrastructure as Code (IaC) setup for deploying a microservices-based Todo application. It uses **Terraform** to provision AWS resources and **Ansible** to configure and deploy the application.

## Infrastructure Components
- **EC2 Instance**: Hosts the application backend and frontend.
- **Security Groups**: Configured to allow required traffic (SSH, HTTP, HTTPS, application ports).
- **Terraform**: Automates infrastructure provisioning.
- **Ansible**: Automates configuration and deployment.
- **Traefik**: Manages reverse proxy and SSL termination.

## Requirements
Ensure you have the following installed before proceeding:
- **Terraform** (>= 1.0.0)
- **Ansible** (>= 2.9.0)
- **AWS CLI** (configured with credentials)
- **SSH Key** for accessing the EC2 instance

## Setup Instructions
### 1. Clone the Repository
```sh
git clone <repo-url>
cd infrastructure
```

### 2. Initialize Terraform
```sh
terraform init
```

### 3. Configure Variables
Modify `terraform.tfvars` or export environment variables:
```hcl
ami = "ami-12345678"
instance_type = "t2.micro"
key_name = "my-key"
security_group = "todo-app-sg"
```

### 4. Deploy Infrastructure
```sh
terraform apply -auto-approve
```
This will:
- Create an EC2 instance
- Generate an **Ansible inventory file** dynamically
- Execute an **Ansible playbook** to configure and deploy the application

### 5. Verify Deployment
Check if the application is accessible:
```sh
curl http://<instance-public-ip>:3000
```

## Deployment Process
1. **Terraform provisions AWS resources** (EC2 instance, security groups, etc.).
2. **Generates an inventory file dynamically** with the new instance’s IP.
3. **Runs an Ansible playbook** to install dependencies and deploy the application.
4. **Traefik is configured** as a reverse proxy to manage traffic and SSL.

## Configuration
### Environment Variables
Set the following variables for Ansible deployment:
```sh
export ANSIBLE_HOST_KEY_CHECKING=False
export TF_VAR_key_name="my-key"
```

### Updating the Application
To update the application without redeploying infrastructure:
```sh
ansible-playbook -i ../ansible/inventory.yml ../ansible/playbook.yml
```

## Cleanup
To destroy the infrastructure, run:
```sh
terraform destroy -auto-approve
```

## Troubleshooting
- **Connection refused error**: Ensure the instance is running and SSH is open.
- **Instance not reachable**: Check security groups and verify the public IP.
- **Deployment failed**: Run `terraform destroy` and redeploy from scratch.

## License
This project is licensed under the MIT License.


