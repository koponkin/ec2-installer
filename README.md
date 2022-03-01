# ec2-installer
This repo contains the terraform files in order to rollout micro instance of ec2 on AWS with docker engine inside.

### Pre-requirements
1. AWS account
2. [Terraform cli](https://learn.hashicorp.com/tutorials/terraform/install-cli)

### How to install
1.  Setup AWS IAM role:
	- Open IAM service
	- Add a new group
	- Add `AmazonEC2FullAccess` role to the group
	- Add a new user
	- Add a new user to the group
2. Create access key: `IAM`-> `Users`-> `<user>`-> `Security credentials` -> `Create access key`. 
3. Generate ssh key pair: `ssh-keygen -f london-region-key-pair`. Note that the script expects the pair and scripts in the same folder.
4. Generate the plan: `terraform plan -out terraform.out`
5. Apply the plan: `terraform apply terraform.out`

Note: the script rolls out an instance in `eu-central-1` region. If you want to change a region or ssh key file name, you can do it in `vars.tf`

After that you can ssh to the new instance:
`ssh -i london-region-key-pair ubuntu@<instanceIP>`