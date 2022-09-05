source "amazon-ebs" "ubuntu" {
  ami_name      = "alpha-ion-ami"
  instance_type = "t2.micro"
  region        = "us-east-2"
  source_ami    = "ami-02f3416038bdb17fb"
  ssh_username  = "ubuntu"
}


build {
  name = "alpha-ion-build-ami"
  sources = [
    "source.amazon-ebs.ubuntu"
  ]
  provisioner "shell" {
    inline = [
      "sudo apt-get update -y && sudo apt-get upgrade -y",
      "sudo apt-get install libtomcat9-embed-java -y",
      "sudo apt-get update -y",
      "sudo apt-get install tomcat9-admin tomcat9-common -y",
      "sudo apt-get install tomcat9 -y",
      "cd /var/lib/tomcat9/webapps/",
      "sudo wget https://alpha55.s3.us-east-2.amazonaws.com/myapp.war",
      "sudo systemctl start tomcat9"
    ]
  }
}
