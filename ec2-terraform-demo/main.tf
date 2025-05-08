provider "aws" {
  region = "us-east-1" # change as needed
}

resource "aws_key_pair" "demo_key" {
  key_name   = "demo-key"
  public_key = file("~/.ssh/fresh_key.pub")
}

resource "aws_security_group" "demo_sg" {
  name        = "demo-sg"
  description = "Allow SSH and HTTP"
  
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "demo_instance" {
  ami                         = "ami-053b0d53c279acc90"
  instance_type               = "t3.micro"
  key_name                    = aws_key_pair.demo_key.key_name
  vpc_security_group_ids      = [aws_security_group.demo_sg.id]
  associate_public_ip_address = false

  tags = {
    Name = "DemoInstance"
  }
}




resource "aws_eip" "demo_eip" {
  domain = "vpc"
}

resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.demo_instance.id
  allocation_id = aws_eip.demo_eip.id
}

resource "null_resource" "remote_setup" {
  depends_on = [aws_instance.demo_instance, aws_eip_association.eip_assoc]

  provisioner "remote-exec" {
    inline = [
      "sleep 15",
      "sudo apt update -y",
      "sudo apt install -y git docker.io docker-compose",
      "sudo systemctl start docker",
      "sudo systemctl enable docker",
      "sudo usermod -aG docker ubuntu",
      "cd /home/ubuntu",
      "git clone https://github.com/arduino731/DevOps-Linux-System-Admin.git",
      "cd DevOps-Linux-System-Admin",
      "sudo docker-compose up -d"
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("~/.ssh/fresh_key.pem")
      host        = aws_eip.demo_eip.public_ip
      timeout     = "2m"
    }
  }
}
