# OVOS Setup

Helper scripts to setup my own OVOS preferences

## Base Setup

Ensure that you have a fresh installation of the [raspOVOS](https://github.com/OpenVoiceOS/raspOVOS) image. Configure the defaults using the [Raspberry Pi Imager](https://www.raspberrypi.com/software/).

## Initializer

Run the following command to bootstrap additional packages and configurations. This will also customize the default installation.

```
sh -c "curl -s https://raw.githubusercontent.com/jaredcobb/ovos-setup/refs/heads/master/scripts/init.sh > init.sh && chmod +x init.sh && sudo ./init.sh && rm init.sh"
```

## Installer

Run the following command to install preferred skills.

```
sh -c "curl -s https://raw.githubusercontent.com/jaredcobb/ovos-setup/refs/heads/master/scripts/install.sh > install.sh && chmod +x install.sh && sudo ./install.sh && rm install.sh"
```
