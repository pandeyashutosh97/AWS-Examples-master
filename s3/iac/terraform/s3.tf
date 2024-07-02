resource "aws_s3_bucket" "my-s3-bucket" {
  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

#run the following commands in the terminal one by one
#terraform plan
#terraform apply
#terraform destroy