1. First provision a instance manually in a particular VPC and subnet, I will use this instance as a terraform master.
		Install Terraform on it
		Install AWS CLI, 
		Create a IAM Role with EC2 full permissions, attach it to this instance. This will help us to not adding AWS access and secret keys
		We have terraform instance ready.
		
Login to the Terraform instance

Below ec2.tf terraform script provisions a new Centos EC2 instace in the us-east-1 region: 
Apply the terraform commands 
terraform init
terrafrom plan
terrafrom apply *
		
		provider "aws" {
  region = "us-east-1"
}
resource "aws_instance" "test" {
  ami    = "ami-0c322300a1dd5dc79"
  instance_type = "t2.micro"
}

#Script to Install AWS Corretto 11 and tomcat8 in the newly provisioned instance
#I will use shell script to automate this
#!/bin/bash
ssh -i keyfile.pem ec2-user@PublicIP:/home/ec2-user@PublicIP
sudo mkdir corretto
cd /home/ec2-user/corretto
wget /hohttps://d3pxv6yz143wms.cloudfront.net/11.0.4.11.1/java-11-amazon-corretto-devel-11.0.4.11-1.x86_64.rpm 
sleep 7
sudo yum localinstall java*
echo "java --version"
mkdir /opt/tomcat/
cd /opt/tomcat/
wget https://archive.apache.org/dist/tomcat/tomcat-8/v8.5.4/bin/apache-tomcat-8.5.4.zip
sleep 5
unzip apache-tomcat-8.5.4.zip
cd apache-tomcat-8.5.4/bin
chmod 700 /opt/tomcat/apache-tomcat-8.5.4/bin/*.sh
ln -s /opt/tomcat/apache-tomcat-8.5.4/bin/startup.sh /usr/bin/tomcatup
ln -s /opt/tomcat/apache-tomcat-8.5.4/bin/shutdown.sh /usr/bin/tomcatdown
cd apache-tomcat-8.5.4/bin
./start.sh

#Deploying open source tomcat application war file from internet, example OpenMRS is java based application.
cd /opt/tomcat/apache-tomcat-8.5.4/webapps
wget https://sourceforge.net/projects/openmrs/files/releases/OpenMRS_Platform_2.2.0/openmrs.war

sudo bash /opt/tomcat/apache-tomcat-8.5.4/bin/shutdown.sh
sudo bash /opt/tomcat/apache-tomcat-8.5.4/bin/startup.sh

#Final URL to access the web applicaton.
#http://34.205.73.131:8080/openmrs
