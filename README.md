# minecraft-server
Builds a minecraft server in AWS using terraform 12.x and ansible 2.9. 

Super quick and dirt block bashing server spinner. 

## What does it build?
Terraform builds the following resources:
* Dedicated VPC with subnet in each AZ for the region.
* SSH Key
* IAM roles and policies for the instance which allow it to read/write it's backup bucket.
* Autoscaling group with one instance in it
* Security group to block SSH to anything but provided IPs.  Allow all IPs for minecraft.
* S3 Backup bucket.
* Uses `nolte.minecraft` role in a basic bootstrap.sh script to download and deploy latest version of minecraft.

## Running it
* Download and install [terraform](https://terraform.io) latest version.
* Do the usual setup for running terraform of aws access creds, running `aws configure` etc.
* Check the variables are for an image you like... The ubuntu 18.04 AMI is in there as std.
* Generate an SSH key for the server: `ssh-keygen -t rsa -b 4096 -f ~/.ssh/minecraft`
* Create a state bucket for terraform in S3 (and alter the name as required in `provider.tf`)
* Update `minecraft-server/ansible/minecraft-server-playbook.yml` with op names etc.
* Run a plan
```
cd terraform
terraform init
terraform plan -var='ssh_ips=["<your home ip>/32"]'
```
* _Eyeball the output_
* `terraform apply -var='ssh_ips=["<your home ip>/32"]'`
* This repo doesn't setup a R53 DNS for you.  So set that up yourself if you want a nice name...
* Profit?

## Notes
The server is configured to be world accessible (no whitelist).  So anyone with the IP can join.  If you want to
restrict access to certain players you will need their minecraft names and update the `minecraft-server-playbook.yml`
with a new variable.  (Check noltes project for full docs on this).