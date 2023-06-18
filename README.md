# Description

This project supposed to create a github self hosted runner on an Oracle Cloud Infrastructure Instance.

# Prerequirements

Install terraform and add keys (locally) based on the following documentation

https://docs.oracle.com/en-us/iaas/developer-tutorials/tutorials/tf-provider/01-summary.html


# Needed varialbes

Look at the [tfvars example](infrastructure/terraform.tfvars.example)
Fill in the variables in the tfvars file. BUT DO NOT COMMIT IT TO GIT!

# How to run

```bash
cd infrastructure
terraform init

```
Do not forget to fill in the variables in the tfvars file.

Hint:
```bash
cp terraform.tfvars.example terraform.tfvars
```

after that you can run the following commands:

```bash
terraform plan -var-file=terraform.tfvars
terraform apply -var-file=terraform.tfvars
```

# How to destroy

```
cd infrastructure
terraform destroy -var-file=terraform.tfvars
```

# Automation with github actions

The terraform files are automatically applied to the oracle cloud when a pull request is merged to the master branch.


# Add remote state

Use this description to add a remote state to the terraform files.
https://ruepprich.com/terraform-configuring-oci-object-storage-backend/


NOICE
