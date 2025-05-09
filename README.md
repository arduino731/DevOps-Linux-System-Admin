DevOps-Linux-System-Admin

A hands-on project demonstrating how to deploy, monitor, and manage a full-stack Dockerized application on AWS EC2 using Infrastructure as Code (Terraform), bash automation scripts, and best practices in backup and monitoring.

🛠️ 1. Setup Instructions

✅ Requirements

AWS account with EC2 access

SSH key pair (fresh_key.pem & fresh_key.pub)

Ubuntu-based local machine or WSL

Terraform, Docker, Docker Compose, Git

📁 Clone the Repo

git clone https://github.com/arduino731/DevOps-Linux-System-Admin.git
cd DevOps-Linux-System-Admin

🚀 Launch Infrastructure

Provision EC2 + security group + EIP with Terraform:

cd ec2-terraform-demo
terraform init
terraform apply

Make sure your ~/.ssh/fresh_key.pub exists locally.

🔧 Configure AWS CLI

aws configure

Ensure proper IAM permissions for EC2, S3, CloudWatch.

🐳 Deploy the App

./deploy.sh

This will:

Sync code to EC2

Restart Docker frontend and backend

Install monitoring script into /etc/cron.daily

🧱 2. Architecture Diagram

[Local Dev Machine] --rsync+SSH--> [EC2 Instance]
                                     |
                                     |-- Docker Compose
                                     |     ├── Frontend (Nginx on :8080)
                                     |     └── Backend (Node.js on :5001)
                                     |
                                     |-- Cron Script -> /var/log/monitor.log
                                     |-- CloudWatch Agent
                                     |-- Fail2ban (SSH protection)

![architecture_diagram_local_to_ec2](https://github.com/user-attachments/assets/7e51a84e-9336-4802-af7a-8b697c602da8)

💾 3. Backup & Restore

🗂️ Backup

Use backup.sh to archive data volumes or app code:

./backup.sh

Store archives locally or upload to S3 for durability.

🔁 Restore

SCP or rsync backed-up data to EC2:

rsync -avz backup.tar.gz ubuntu@<EC2-IP>:/home/ubuntu/

SSH into EC2, extract, and restart Docker:

ssh -i ~/.ssh/fresh_key.pem ubuntu@<EC2-IP>
cd /home/ubuntu && tar -xzvf backup.tar.gz
cd DevOps-Linux-System-Admin && docker-compose up -d --build

♻️ 4. Rebuild from Scratch

🔄 Clean Start

If you need to wipe and start fresh:

terraform destroy

Then re-run from Setup Instructions:

terraform apply
./deploy.sh

⚙️ System Reinstall

If EC2 was manually terminated:

Update your Elastic IP or DNS records.

Ensure fresh_key.pem still matches EC2 authorized key.

Follow the deployment steps again.

📈 Monitoring & Security

fail2ban: Protects from SSH brute-force attacks

CloudWatch Agent: Streams memory, disk, and uptime logs to AWS

monitor.sh: Local disk + uptime cron script logged daily to /var/log/monitor.log

📂 Folder Structure
![Screenshot 2025-05-09 122348](https://github.com/user-attachments/assets/26517e9c-e900-44cd-9987-2c1e815cbf45)

📬 Contact

Maintained by Brian — feel free to fork, star, or reach out with feedback or questions.
