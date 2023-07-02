locals {
  env_vars        = read_terragrunt_config(find_in_parent_folders("env.hcl"))

  aws_region      = local.env_vars.locals.aws_region
  aws_account_id  = local.env_vars.locals.aws_account_id
}

remote_state {
  backend = "s3"

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }

  config = {
    bucket         = "iac-tfstate-bucket"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "ap-northeast-2"
    encrypt        = true
    dynamodb_table = "iac-dynamodb-lock-table"
  }
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "aws" {
  region  = "${local.aws_region}"
  assume_role {
    role_arn = "arn:aws:iam::${local.aws_account_id}:role/ExecutionRole"
  }
}
EOF
}