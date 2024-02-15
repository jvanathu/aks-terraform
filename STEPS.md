brew update && brew install azure-cli
alias tf=terraform
openssl pkcs12 -export -out data/certs/certificate.pfx -inkey data/certs/private-key.pem -in data/certs/full-chain.pem

az login --tenant b5bc7c3d-d7f5-48a4-a38f-7864f685d660
az account set --subscription c0946a49-b1c1-469e-b6e7-94088e571ff9

terraform init \
  -backend-config="resource_group_name=automation"     \
  -backend-config="storage_account_name=virtuapimterraform" \
  -backend-config="container_name=terraform"       \
  -backend-config="key=tfstate/vrtuaksint/terraform.tfstate"

  az storage blob lease break -b terraform.tfstate -c terraform --account-name virtuapimterraform --account-key w0LiwRuClpHKEmt+MmtlgE/nSA/EBB5r3IrLRIxh1rfE3pcL3KoKLMkVY4KedAZUYomwXXyFkNSh+AStxUypdQ==