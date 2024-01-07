# Instaling OCI CLI

1. Run the installation command:
```
bash -c "$(curl -L https://raw.githubusercontent.com/oracle/oci-cli/master/scripts/install/install.sh)"
```
2. When prompted to update your PATH, respond with Y and use the following
```
~/.zshrc
```
3. Restart your terminal session.
4. Verify the installation.
```
oci -v
```
5. Configure the CLI
```
oci session authenticate
```
* Make sure to put the correct region, and when prompted for the profile name, enter DEFAULT so that Terraform finds the session token automatically.

# Creating the Cluster

1. Clone the repository
```
git clone https://github.com/Rapha-Borges/ampernetacle.git
```
2. Initialize the Terraform project
```
terraform init
```
3. Apply the changes
```
terraform apply
```
4. Copy the kubeconfig file to .kube/config
```
cp kubeconfig ~/.kube/config
```
5. Save the terraform output to a file
```
terraform output > ssh-info.txt
```