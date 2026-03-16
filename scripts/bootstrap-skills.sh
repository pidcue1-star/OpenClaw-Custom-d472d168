#!/bin/bash

# Bootstrap script for installing self-improving-agent and supermemory skills

# Update package list and install necessary packages
apt-get update
apt-get install -y python3-pip

# Install self-improving-agent
pip3 install self-improving-agent

# Install supermemory skills
pip3 install supermemory

echo "Installation of self-improving-agent and supermemory skills completed successfully."