# Terraform Setup for MongoDB on AWS EC2

This part of the project provisions AWS infrastructure using Terraform.

## Steps

1. Update `variables.tf` with your AWS key pair and CIDR blocks.
2. Initialize Terraform:
   ```bash
   terraform init
   ```
3. Plan:
   ```bash
   terraform plan
   ```
4. Apply:
   ```bash
   terraform apply -auto-approve
   ```
5. After provisioning, connect to the instance:
   ```bash
   ssh -i your-key.pem ec2-user@<EC2_PUBLIC_IP>
   docker ps
   ```

## Cleanup
```bash
terraform destroy -auto-approve
```
