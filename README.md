# Homelab setup help
I'm tired of doing the same old boring config over and over when I want to try some new stuff in my homelab, so I decided to start using ansible to automate the boring parts.

I use Debian for pretty much everything but this probably works with Ubunto as well.

If you installed Debian or Proxmox yourself, start with the readme in `./install` to prepare ansible using shell scripts.

If using a Debian cloud image, ansible is already installed there. Just pass an `ansible` user and public ssh key to your cloud-init drive.

## Install ansible
There is an install script to get ansible on your local machine or controle node in `./install`.

## Install the requirements
`ansible-galaxy install -r requirements.yml`

## Runing an ansible playbook
`ansible-playbook -i inv ./pb/debian-config.yml -K`
 - The -K options won't be necessary for a cloud image, maybe I should also change that for the way I set up ansible account on a custom install.
 - Prepend `sudo runuser -u ansible -- ` if you use ansible from it's own account.
 - Make your own `inv` file