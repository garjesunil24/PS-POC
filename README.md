# PS-POC

main.tf -- Contains code to create VPC, two public subnets and one Private Subnet
variables.tf -- Contains all necessory variables
asg.tf --- Contains code to create autoscaling group
ec2.tf -- Contains code to launch webserver alongwith Port change from 80 to 8080
alb.tf -- Contains code to create ALB, SG, Target group to integrate it with webserver
iam.tf -- Contains code to create IAM user alongwith webserver restart access using SSM
