# vagrant-ansible-openvpn

Provision OpenVPN using Vagrant, Virtualbox and Ansible.

## Clone the GitHub Repository

Run the following command from the terminal to clone the GitHub Repository:

```bash
git clone https://github.com/ashleykleynhans/vagrant-ansible-openvpn.git
```

## Install Required Software

Begin by installing the homebrew package manager, which works on both Mac
 and Ubuntu Linux.  May work on other Linux distributions but has not bee
n tested.

Run the following command from the terminal to install homebrew:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

All of the remaining software can be installed by cloning the git repository and  running the setup script provided.

Run the setup script from the terminal to install the required software:

```bassh
./setup.sh
```

## Managing the Stack

Begin by ensuring that you are in the directory which the Github Repository was cloned to:

```
cd vagrant-ansible-openvpn
```

### Starting the Stack

```bash
vagrant up
```

### Stopping the Stack

```bash
vagrant halt
```

### Deleting the Stack

```bash
vagrant destroy -f
```

## Creating an AWS AMI from the VirtualBox VM

### Conifgure your AWS CLI credentials (if not already done)

```
aws configure
```

### Provision the VM

If the VM has not already been provisioned (otherwise skip this step):

```bash
vagrant up
````

### Stop the VM

The VM must be stopped in order to export an OVA image from it:

```bash
vagrant halt
```

### Export the VM as an OVA image

```bash
VBoxManage export openvpn -o vms/openvpn.ova
```

### Create an AWS vmimport IAM role

```bash
aws iam create-role --role-name vmimport --assume-role-policy-document file://trust-policy.json
```

### Create a role policy for the vmimport role

Edit the **role-policy.json** file and change all instances of **YOUR-BUCKET-NAME** to an S3 bucket you've created to store the OVAs that will be imported as AMIs.

Once you've edited the role-policy.json file and ensured that your S3 bucket exists:

```bash
aws iam put-role-policy --role-name vmimport --policy-name vmimport --policy-document file://role-policy.json
```

### Upload the exported OVA file to S3

```bash
aws s3 cp vms/openvpn.ova s3://YOUR-BUCKET-NAME/openvpn.ova
```

### Import the OVA from S3 as an AMI into EC2

Edit the **containers.json** file and change **YOUR-BUCKET-NAME** to the same S3 bucket name you've specified above.

Once you've edited the containers.json file:

```bash
aws ec2 import-image --description "OpenVPN on Ubuntu 20.04 LTS" --disk-containers file://containers.json 
```
This process takes quite some time, but you can monitor the progress by using the following command:

```bash
aws --output json ec2 describe-import-image-tasks --import-task-ids import-ami-12345678
```

Where **import-ami-12345678** is the value from the **import-image** command that you ran previously.
