#! /bin/bash
set -e


echo "Installing GitHub Actions runner"

# This script is used to create a GitHub Actions runner on a Linux machine.

# This script is based on the following documentation:
# https://docs.github.com/en/actions/hosting-your-own-runners/adding-self-hosted-runners



mkdir ~/actions-runner && cd ~/actions-runner

curl -o actions-runner-linux-arm64-2.304.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.304.0/actions-runner-linux-arm64-2.304.0.tar.gz

tar xzf ./actions-runner-linux-arm64-2.304.0.tar.gz

chmod +x ./config.sh
chmod +x ./run.sh


# TODO: make it run as-non-root
export RUNNER_ALLOW_RUNASROOT=1
 
# Install system dependencies
./bin/installdependencies.sh


# Create the runner and start the configuration experience
./config.sh --url ${github_runner_url} --token ${github_runner_token}  --name oci-runner --work _work --labels linux,AMD,production --unattended --replace

# Install the runner as a service and run it in the background

./run.sh &
