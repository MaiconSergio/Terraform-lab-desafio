resource "aws_key_pair" "key" {
  key_name   = "aws-key"
  public_key = file("./aws-key.pub")
}


resource "aws_instance" "instance" {
  ami                         = "ami-00e801948462f718a" # Amazon Linux 2 AMI (HVM), SSD Volume Type
  instance_type               = "t2.micro"
  subnet_id                   = data.terraform_remote_state.network.outputs.subnet_id
  vpc_security_group_ids      = [data.terraform_remote_state.network.outputs.sg_id]
  region                      = "us-east-1"
  key_name                    = aws_key_pair.key.key_name
  associate_public_ip_address = true


  provisioner "local-exec" {
    command = "echo The servers IP address is ${self.public_ip} >> /tmp/meuip.txt"
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("./aws-key")
    host        = self.public_ip
  }



  provisioner "remote-exec" {
    inline = ["echo Hello, World! > /tmp/hello.txt",
      "echo subnet_id: ${data.terraform_remote_state.network.outputs.subnet_id} >> /tmp/network_info.txt",
    "echo security_group_id: ${data.terraform_remote_state.network.outputs.sg_id} >> /tmp/network_info.txt"]
  }

  provisioner "file" {
    source      = "./teste.txt"
    destination = "/tmp/teste.txt"
  }

  provisioner "file" {
    content     = "Validando se realmente o arquivo foi criado via content"
    destination = "/tmp/teste2.txt"
  }

}








