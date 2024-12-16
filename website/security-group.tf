# Create a Security Group for the instance
resource "aws_security_group" "web_sg" {
  name        = "al2023-web-sg"
  description = "Allow SSH and HTTP access"

  # Allow inbound SSH
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.allowed_ssh_cidr]
    # cidr_blocks = ["0.0.0.0/0"] # Replace with a restricted IP range for better security
    # cidr_blocks = ["203.0.113.25/32"] # Replace with your actual IP
  }

  # Allow inbound HTTP
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "al2023-sg"
  }
}

