# Ansys-Infrastructure
Interview Coding Challenge: Terraform Infrastructure as Code
Deployment Instructions

Clone the repository and navigate to the project directory
Copy and customize the variables file:

cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars with your specific values

Initialize Terraform:
terraform init

Plan the deployment:
terraform plan

Apply the configuration:
terraform apply

Access your nginx server:
# The URL will be displayed in the terraform output
curl http://$(terraform output -raw ec2_public_ip)