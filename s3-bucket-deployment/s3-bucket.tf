resource "random_pet" "s3_bucket_name" {
  prefix = "s3"
  length = 4
}

resource "aws_s3_bucket" "b" {
  bucket = "my-bucket-${random_pet.s3_bucket_name.id}"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}