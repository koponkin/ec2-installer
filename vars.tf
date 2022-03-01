variable "AWS_REGION" {    
    default = "eu-central-1"
}

variable "AMI" {
    default = "ami-09042b2f6d07d164a" //https://cloud-images.ubuntu.com/locator/ec2/
}

variable "PUBLIC_KEY_PATH" {    
    default = "london-region-key-pair.pub"
}

variable "PRIVATE_KEY_PATH" {    
    default = "london-region-key-pair"
}

variable "EC2_USER" {    
    default = "ubuntu"
}