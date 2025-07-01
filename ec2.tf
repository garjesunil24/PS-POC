# Get the latest Amazon Linux 2 AMI
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# Security Group allowing SSH and HTTP
resource "aws_security_group" "nginx_sg" {
  name        = "nginx-sg"
  description = "Allow SSH and HTTP"
  vpc_id      = aws_vpc.ps_vpc.id

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.10.0.0/32"]
  }

  ingress {
    description = "Allow HTTP"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["10.10.0.0/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "nginx-sg"
  }
}

# EC2 Instance with NGINX
resource "aws_instance" "nginx_instance" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.ec2_instance_type
  subnet_id              = aws_subnet.private_subnet_1.id 
  vpc_security_group_ids = [aws_security_group.nginx_sg.id]
  key_name               = var.aws_key

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              amazon-linux-extras install nginx1 -y
              sed -i 's/listen 80;/listen 8080;/g' /etc/nginx/nginx.conf
              systemctl enable nginx
              systemctl start nginx
              EOF

  tags = {
    Name = "nginx-server"
  }
}
