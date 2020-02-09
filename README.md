# minecraft-server

Builds a minecraft server in AWS using terraform and ansible. 

Super quick and dirt block server spinner. 

## Running 
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
