resource "aws_s3_bucket" "gemarakup_frontend" {
  bucket = "gemarakup-frontend"
  tags = {
    Name        = var.project_name
    Environment = "dev"
  }
}