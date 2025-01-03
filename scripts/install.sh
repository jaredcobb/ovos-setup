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

source /home/ovos/.venvs/ovos/bin/activate

prompt_bright "Would you like to install the basic OVOS Skills? [Y/n]: "
read install_basic_skills
if [[ -z "$install_basic_skills" || $install_basic_skills == y* || $install_basic_skills == Y* ]]; then
    echo_info "Installing basic skills..."
    uv pip install -c https://github.com/OpenVoiceOS/ovos-releases/raw/refs/heads/main/constraints-testing.txt \
        ovos-skill-date-time \
        ovos-skill-weather
fi

prompt_bright "Would you like to restart now? [Y/n]: "
read restart
if [[ -z "$restart" || $restart == y* || $restart == Y* ]]; then
    echo_info "See you soon!"
    sudo reboot now
fi
