terraform {
  backend "s3" {
    bucket = "myapp-learn-jenkins-2"
    key    = "jenkins/terraform.tfstate"
    region = "us-east-1"
  }
}