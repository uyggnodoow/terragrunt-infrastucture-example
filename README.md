# terragrunt-infrastucture-example

This is just one of many structures for using Terragrunt.


## Prerequisites

1. Install `terraform` and `terragrunt`
2. Configure your `AWS credentials` using one of the supported authentication mechanisms.
3. Update the parameters in the root `terragrunt.hcl`, and in `env.hcl` for each account.


### Install Terraform and Terragrunt

You can download it from the official website.

* [Install Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
* [Install Terragrunt](https://terragrunt.gruntwork.io/docs/getting-started/install/)


### Configure AWS credentials (using IAM Role)

To summarize, we need to create two IAM roles.

***First, you need to create a policy with create/delete/update permissions on resources per account.***

For our purposes, we'll name this role `"ExecutionRole"`.


***Next, Your AWS user must have an IAM policy which grants permissions for interacting with DynamoDB and S3. It also includes permission to assume the `ExecutionRole` role.***

You can see how you can create an IAM Role with minimal permissions [here](https://terragrunt.gruntwork.io/docs/features/aws-auth/).

**_NOTE:_** Recommend using a Trust Relationship to securely use Roles)


### Update the parameters

Update the parameter values required by the `*.hcl` file.


## Deploy the infrastructure

### Deploy single module

1. Change directory into the resource to deploy folder (eg. `cd /prod/us-east-1/ec2`)
2. Run `terragrunt plan` to see the changes you're about to apply.
3. If there are no issues, run `terragrunt apply`.

### Deploy all modules

1. Change directory into the account/region folder (eg. `cd /prod`, `cd /prod/us-east-1`)
2. Run `terragrunt run-all plan` to see the changes you're about to apply.
3. If there are no issues, run `terragrunt run-all apply`.