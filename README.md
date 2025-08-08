# Terraform Remote State Backend with Locking (AWS)

## 📌 Overview
This project demonstrates how to securely manage Terraform state files by storing them in a **remote backend** (AWS S3) with **state locking** enabled using AWS DynamoDB.

By implementing remote state storage and locking:
- The `.tfstate` file is **not committed** to version control, reducing security risks.
- **Only one person** can modify the state at a time, preventing race conditions.
- The state is backed up and versioned automatically.

---

## 📂 Project Structure

```
D:.
│   README.md
│
├───learn-terraform-get-started-aws     # Basic Terraform setup for AWS resources
│       main.tf
│       output.tf
│       terraform.tf
│       variable.tf
│
└───remote-infra                        # Remote backend & locking configuration
        dynamodb.tf
        providers.tf
        s3.tf
        terraform.tf
```

---

## 🛠️ Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/downloads) >= 1.0.0
- AWS CLI configured with appropriate credentials (`aws configure`)
- An AWS account with permissions to create:
  - S3 bucket
  - DynamoDB table
  - AWS resources defined in `learn-terraform-get-started-aws`

---

## ⚙️ How It Works

1. **Remote State Storage (S3)**
   - Stores `.tfstate` file securely in an AWS S3 bucket.
   - Enables versioning to recover old state files if needed.

2. **State Locking (DynamoDB)**
   - Uses a DynamoDB table to manage state locks.
   - Prevents multiple users from applying changes simultaneously.

---

## 🚀 Deployment Steps

### 1️⃣ Create Remote Backend (S3 & DynamoDB)
```bash
cd remote-infra
terraform init
terraform apply
```

This will:
- Create an S3 bucket for storing the state.
- Create a DynamoDB table for state locking.

---

### 2️⃣ Deploy Your Infrastructure
Update the `backend` block in `learn-terraform-get-started-aws/terraform.tf` with your S3 bucket and DynamoDB table details.

```hcl
terraform {
  backend "s3" {
    bucket         = "your-bucket-name"
    key            = "terraform/state.tfstate"
    region         = "us-east-1"
    dynamodb_table = "your-dynamodb-table"
    encrypt        = true
  }
}
```

Then:
```bash
cd ../learn-terraform-get-started-aws
terraform init
terraform apply
```

---

## 📖 Example Use Case
- A DevOps team wants to collaborate on Terraform-managed infrastructure without risking **state conflicts** or leaking sensitive data into Git.
- Remote backend ensures everyone works from the **same source of truth**.

---

## 🔐 Security Considerations
- Never commit `.tfstate` files to Git.
- Enable **S3 encryption** and **bucket policies** to restrict access.
- Use **AWS IAM roles** for fine-grained access control.

---

## 🏷️ Tags
`Terraform` `AWS` `S3` `DynamoDB` `Remote State` `State Locking` `DevOps` `IaC`

