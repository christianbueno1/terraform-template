# Fetch the latest Amazon Linux 2023 AMI
data "aws_ami" "amazon_linux_2023" {
  most_recent = true

  filter {
    name   = "name"
    # values = ["al2023-ami-*-x86_64-gp2"] # Amazon Linux 2023 AMI pattern
    # values = ["al2023-ami-2023*"]
    # values = ["al2023-ami-2023*-x86_64"]
    values = ["/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"]
  }
  # filter {
  #   name = "architecture"
  #   values = ["x86_64"]
  # }

  filter {
    name   = "virtualization-type"
    values = ["hvm"] # Required for modern EC2 instance types
  }

  # owners = ["137112412989"] # AWS-owned Amazon Linux AMIs
  owners = ["amazon"] 
}

# Launch an EC2 instance with AL2023
resource "aws_instance" "web" {
  ami           = data.aws_ami.amazon_linux_2023.id
  instance_type = "t3.micro" # Change as needed

  # Attach the security group
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  # Optionally define user data to initialize the instance
  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    yum install httpd -y
    systemctl enable httpd
    systemctl start httpd
    echo "Welcome to Amazon Linux 2023!" > /var/www/html/index.html
  EOF

  tags = {
    Name = "al2023-web"
  }
}
