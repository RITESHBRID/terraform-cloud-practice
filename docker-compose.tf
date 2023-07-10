resource "aws_instance" "ec2_instance" {
  ami           = "<your_ami_id>"
  instance_type = "<your_instance_type>"
  key_name      = "<your_key_pair_name>"
  security_group_ids = ["<your_security_group_id>"]

  provisioner "remote-exec" {
    inline = [
      "sudo yum install -y docker",                       # Install Docker
      "sudo service docker start",                         # Start Docker service
      "sudo usermod -aG docker ec2-user",                  # Add the current user to the Docker group
      "sudo systemctl enable docker",                      # Enable Docker service
      "sudo curl -L https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose",  # Download Docker Compose
      "sudo chmod +x /usr/local/bin/docker-compose",       # Make Docker Compose executable
      "sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose",   # Create a symbolic link
      "cd /path/to/docker-compose-directory",              # Change to the directory containing your Docker Compose file
      "sudo docker-compose up -d"                          # Execute Docker Compose command
    ]
  }
}
