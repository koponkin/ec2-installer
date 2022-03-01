resource "aws_instance" "web1" {
    ami = "${var.AMI}"
    instance_type = "t2.micro"
    # VPC
    subnet_id = "${aws_subnet.prod-subnet-public-1.id}"
    # Security Group
    vpc_security_group_ids = ["${aws_security_group.ssh-allowed.id}"]
    # the Public SSH key
    key_name = "${aws_key_pair.london-region-key-pair.id}"

    provisioner "remote-exec" {
        connection {
            type        = "ssh"
            user        = "${var.EC2_USER}"
            private_key = "${file("${var.PRIVATE_KEY_PATH}")}"
            host        = self.public_ip
        }
        inline = [
             "sudo apt-get update",
             "sudo apt-get -y install ca-certificates curl gnupg lsb-release",
             "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg",
             "echo \"deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable\" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null",
             "sudo apt-get update",
             "sudo apt-get -y install docker-ce docker-ce-cli containerd.io"
        ]
    }
    
}
// Sends your public key to the instance
resource "aws_key_pair" "london-region-key-pair" {
    key_name = "london-region-key-pair"
    public_key = "${file(var.PUBLIC_KEY_PATH)}"
}