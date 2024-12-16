# Fetch the latest Amazon Linux 2023 AMI
data "aws_ami" "amazon_linux_2023" {
  most_recent = true

  filter {
    name = "name"
    # values = ["al2023-ami-*-x86_64-gp2"] # Amazon Linux 2023 AMI pattern
    values = ["al2023-ami-*-x86_64"]
    # values = ["al2023-ami-2023*"]
    # values = ["al2023-ami-2023*-x86_64"]
    # values = ["/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"]
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
  instance_type = "t3.micro"        # Change as needed
  key_name      = var.key_pair_name # Use your existing key pair here

  # Attach the security group
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  # Optionally define user data to initialize the instance
  # user_data = <<-EOF
  #   #!/bin/bash
  #   dnf update -y
  #   dnf install bash-completion
  #   dnf install vim-enhanced
  #   dnf install httpd -y
  #   systemctl enable httpd
  #   systemctl start httpd
  #   echo "<h1>Welcome to Amazon Linux 2023!</h1><p>"O mueres siendo un héroe o vives lo suficiente para verte convertido en un villano."</p>" > /var/www/html/index.html
  # EOF

  # define user data to initialize the instance
  # user_data = <<-EOF
  #   #!/bin/bash
  #   apt update -y
  #   apt install nginx -y
  # EOF

  tags = {
    Name = "web-server"
    # Environment = "production"
    Environment = "development"
  }
  provisioner "file" {
    source = "sample.sh"
    destination = "/tmp/sample.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/sample.sh",
      "/tmp/sample.sh",
    ]
  }
}
