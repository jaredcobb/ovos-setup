#!/bin/bash

echo_info() {
    echo -e "\033[94m[INFO]: $1\033[0m"
}

echo_warning() {
    echo -e "\033[91m[WARNING]: $1\033[0m"
}

echo_bright() {
    echo -e "\033[33m$1\033[0m"
}

prompt_bright() {
    echo -e "\033[33m$1\033[0m"
}

prompt_bright "Would you like to initialize the hardware? (First time only) [Y/n]: "
read init
if [[ -z "$init" || $init == y* || $init == Y* ]]; then
    echo_info "Initializing hardware..."
    sudo raspi-config nonint do_change_locale en_US.UTF-8
fi

prompt_bright "Would you like to update and upgrade apt? [Y/n]: "
read update_apt
if [[ -z "$init" || $init == y* || $init == Y* ]]; then
    sudo apt -y update && sudo apt -y upgrade
    sudo apt install -y vim lnav
fi

echo_info "Refreshing logo..."
if [ -f /home/ovos/.logo.sh ]; then
    mv /home/ovos/.logo.sh /home/ovos/.logo.sh.bak.$(date +%Y%m%d_%H%M%S)
fi
if [ -f /home/ovos/.cli_login.sh ]; then
    mv /home/ovos/.cli_login.sh /home/ovos/.cli_login.sh.bak.$(date +%Y%m%d_%H%M%S)
fi
wget -O /home/ovos/.logo.sh https://raw.githubusercontent.com/jaredcobb/ovos-setup/refs/heads/master/scripts/logo.sh
wget -O /home/ovos/.cli_login.sh https://raw.githubusercontent.com/jaredcobb/ovos-setup/refs/heads/master/scripts/cli_login.sh

echo "" >> /home/ovos/.bashrc
echo "alias l='ls -la'" >> /home/ovos/.bashrc
echo "alias ovos='/bin/bash ~/.cli_login.sh'" >> /home/ovos/.bashrc
echo "alias logs='lnav /home/ovos/.local/state/mycroft'" >> /home/ovos/.bashrc

chown ovos:ovos /home/ovos/.logo.sh
chown ovos:ovos /home/ovos/.cli_login.sh
chown ovos:ovos /home/ovos/.bashrc

echo "Done initializing the server..."
echo

source /home/ovos/.venvs/ovos/bin/activate

prompt_bright "Would you like to purge the preinstalled skills and start fresh? [Y/n]: "
read purge
if [[ -z "$purge" || $purge == y* || $purge == Y* ]]; then
    echo_info "Removing skills..."
    uv pip list | grep skill | awk '{print $1}' | xargs uv pip uninstall
fi

prompt_bright "Would you like to update the core OVOS packages? [Y/n]: "
read update
if [[ -z "$update" || $update == y* || $update == Y* ]]; then
    echo_info "Updating packages..."
    uv pip install -c https://github.com/OpenVoiceOS/ovos-releases/raw/refs/heads/main/constraints-testing.txt -U --pre $(uv pip list --format=freeze | grep -E 'ovos-|skill-' | cut -d '=' -f 1)
fi

prompt_bright "Would you like to restart now? [Y/n]: "
read restart
if [[ -z "$restart" || $restart == y* || $restart == Y* ]]; then
    echo_info "See you soon!"
    sudo reboot now
fi
