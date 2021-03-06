#!/bin/bash

# These should be passed in via custom_provisioning_env
#APP='puppet-application-manager'
#CHANNEL='standalone'

set -e

#################################################################################
# Provide a script to get kubernetes back into a working state after vm checkout.

sudo mv /tmp/restart_k8s.sh /root
sudo chmod 750 /root/restart_k8s.sh

cat << EOF | sudo tee -a /etc/motd

After initial checkout, run /root/restart_k8s.sh to get the Kubernetes environment restarted.

EOF

#############################
# Install Kubernetes via Kurl
curl -sSLO https://k8s.kurl.sh/bundle/${APP}-${CHANNEL}.tar.gz
tar xzf ${APP}-${CHANNEL}.tar.gz
rm ${APP}-${CHANNEL}.tar.gz

dnf -y install bash-completion
cat install.sh | sudo bash -s airgap preserve-selinux-config
