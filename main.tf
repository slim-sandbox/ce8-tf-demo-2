resource "aws_instance" "public" {
  ami                         = "ami-04c913012f8977029"
  instance_type               = "t2.micro"
  subnet_id                   = "subnet-0021081c508245985" #Public Subnet ID, e.g. subnet-xxxxxxxxxxx.
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
 
  tags = {
    Name = "nameprefix-ec2"
  }
}

resource "aws_security_group" "allow_ssh" {
  name        = "nameprefix-sg"
  description = "Allow SSH inbound"
  vpc_id      = "vpc-067f3ab097282bc4d" #VPC ID (Same VPC as your EC2 subnet above), e.g. vpc-xxxxxxxxxxx
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.allow_ssh.id
  cidr_ipv4         = "0.0.0.0/0"  
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}
