
terraform {
  backend "s3" {
    bucket       = "himanshu-tfstate-2026-11011"
    key          = "database-reliability/dev/terraform.tfstate"
    region       = "ap-south-1"
    encrypt      = true
    use_lockfile = true
  }
}
