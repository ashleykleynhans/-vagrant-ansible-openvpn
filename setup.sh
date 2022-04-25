#!/usr/bin/env bash

# Install homebrew
echo "Installing homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install virtualbox
echo "Installing VirtualBox"
brew install virtualbox

# Install Vagrant
echo "Installing Vagrant"
brew install vagrant

# Install Ansible
echo "Installing Ansible"
brew install ansible

# Install Python requirements
echo "Installing Python requirements"
pip3 install -r requirements.txt

# Install AWS CLI
echo "Installing AWS CLI"
brew install awscli
