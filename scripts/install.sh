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
