# Terraform: MongoDB EC2 Demo (Docker)

This Terraform code provisions a minimal AWS environment (VPC, subnet, IGW, security group)
and an EC2 instance that runs MongoDB inside Docker via `user_data`.

## Pre-requisites
- Terraform >= 1.2.0
- AWS CLI configured with credentials or environment variables (AWS_ACCESS_KEY_ID / AWS_SECRET_ACCESS_KEY)
- A public SSH key available (path default: ~/.ssh/id_rsa.pub)

## Quick start
1. Copy the repo locally and change variables if needed.
2. Initialize Terraform:
   ```bash
   terraform init
   ```
3. Preview the plan:
   ```bash
   terraform plan -var="public_key_path=~/.ssh/id_rsa.pub"
   ```
4. Apply (be careful, this will create real AWS resources):
   ```bash
   terraform apply -var="public_key_path=~/.ssh/id_rsa.pub" -auto-approve
   ```
5. After apply, note the `instance_public_ip` output and SSH into the instance:
   ```bash
   ssh -i ~/.ssh/id_rsa ubuntu@<instance_public_ip>
   ```
6. Check that MongoDB is running in Docker:
   ```bash
   docker ps
   docker logs mongodb
   ```

## Security notes
- The `allowed_ssh_cidr` and `allowed_mongo_cidr` default to `0.0.0.0/0` for demo convenience. **Lock these to your IP range** before production use.
- Change default MongoDB username/password in `userdata.sh` before using anywhere sensitive.
- For production, prefer EBS volumes for persistence, IAM roles for instance profiles, and proper secrets management.
