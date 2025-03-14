#!/bin/bash

# Initialize Terraform
terraform init

# Validate Terraform Configuration
terraform validate

# Plan the Deployment
terraform plan -out=tfplan

# Apply the Terraform Plan
terraform apply tfplan
