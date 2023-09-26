# Define provider
provider "aws" {
  region = "us-east-1" # Change this to your desired AWS region
}

# Create VPC
resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16" # Update the CIDR block as needed
}

# Create public subnet
resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.1.0/24" # Update the CIDR block as needed
  map_public_ip_on_launch = true
  availability_zone = "us-east-1a" # Update with the desired availability zone
}

# Create private subnet
resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.2.0/24" # Update the CIDR block as needed
  availability_zone = "us-east-1b" # Update with the desired availability zone
}

# Create EC2 instance in the public subnet
resource "aws_instance" "ec2_instance" {
  ami           = "ami-0c55b159cbfafe1f0" # Update with your desired AMI ID
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_subnet.id

  root_block_device {
    volume_size = 8
    volume_type = "gp2"
    delete_on_termination = true
  }

  tags = {
    Name = "EC2 Assignment"
  }
}

# Create a security group for EC2 instance
resource "aws_security_group" "ec2_security_group" {
  name_prefix = "ec2-sg-"
  description = "Security group for EC2 instance"
  vpc_id      = aws_vpc.my_vpc.id

  # Inbound rule for SSH
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow SSH from anywhere (for demonstration purposes)
  }

  # Outbound rule allowing all traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Associate security group with the EC2 instance
resource "aws_network_interface_sg_attachment" "ec2_sg_attachment" {
  security_group_id    = aws_security_group.ec2_security_group.id
  network_interface_id = aws_instance.ec2_instance.network_interface_ids[0]
}
