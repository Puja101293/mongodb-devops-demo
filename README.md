# MongoDB DevOps Demo

This is a small DevOps demo project where I used **Terraform** to create AWS infrastructure (VPC, subnet, EC2, security group) 
and then installed **Docker** + **MongoDB** on the EC2 instance using `userdata.sh`.

I made this project to practice Infrastructure as Code (IaC) and automation.

---

## Prerequisites
- Terraform (v1.2 or above)
- AWS CLI configured with access keys
- An SSH key pair (for connecting to the EC2 instance)

---

## Steps to Run
1. Clone the repo
   ```bash
   git clone https://github.com/Puja101293/mongodb-devops-demo.git
   cd mongodb-devops-demo
   ```

2. Initialize Terraform
   ```bash
   terraform init
   ```

3. Plan and apply
   ```bash
   terraform plan
   terraform apply -auto-approve
   ```

4. After deployment, connect to EC2 and check MongoDB is running inside Docker:
   ```bash
   ssh -i your-key.pem ec2-user@<EC2_PUBLIC_IP>
   docker ps
   ```

---

## Cleanup
```bash
terraform destroy -auto-approve
```

---

## Notes
- `main.tf`, `variables.tf`, and `outputs.tf` define the infrastructure.
- `userdata.sh` installs Docker and starts MongoDB automatically.
- Later, I plan to extend this with Kubernetes and CI/CD pipeline.

---

## Demo Video
(Loom link will be added here soon)
