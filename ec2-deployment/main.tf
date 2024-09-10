resource "aws_instance" "app_server" {
  ami = var.ami_id_fedora40
}