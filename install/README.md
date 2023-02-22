# Setting up Ansible from WSL2 Debian 11 with proxmox 7.3 and Debian 11 VM nodes in a lab environment
## NOT NECESSARY WHEN USING A CLOUD-INIT IMAGE
If using cloud init, set the default user as ansible and set the public key. Ansible is included in the Debian cloud image.

## Prerequisites
1. Have an SSH key configured for your machine.
2. Have root access to other machines.

## Install and configure Ansible -- 
1. Copy your public SSH key to your target hosts if ssh password login is disabled (proxmox root user, for example, needs your key appended at ~/.ssh/authorized_keys)
2. For the control node (maybe your local machine), run setup script in the install folder.
`sudo ./install/1-setup-control-node.sh`
3. Run the appropriate setup script for each target node.
`ssh root@host 'bash -s' < ./install/2a-setup-proxmox-target.sh`
`ssh root@host 'bash -s' < ./install/2b-setup-debian-target.sh`
4. Run the following on the Control Node to copy the key to
`sudo runuser -u ansible -- ssh-copy-id -i /home/ansible/.ssh/id_ed25519.pub ansible@HOST`
5. Run the following on each Target Node to disable password authentication after the key is installed.
`passwd brian` (set my password so I can sudo)
`passwd ansible --delete`
