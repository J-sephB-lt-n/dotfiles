#!/bin/bash

# USAGE: 
# $ sudo wget https://raw.githubusercontent.com/J-sephB-lt-n/my-personal-configs/main/setup_joes_dev_environment.sh
# $ sudo bash setup_joes_dev_environment.sh
# $ rm setup_joes_dev_environment.sh

set -e

apt-get update
apt-get install -y --no-install-recommends \
    bc fzf htop tmux tree vim wget

wget -O ~/.bash_aliases https://raw.githubusercontent.com/J-sephB-lt-n/my-personal-configs/main/.bash_aliases
echo 'source ~/.bash_aliases' >> ~/.bashrc
wget -O ~/.vimrc https://raw.githubusercontent.com/J-sephB-lt-n/my-personal-configs/main/.vimrc  

mkdir ~/cli_tools
for script_name in "gpt.py"; 
do
    wget -O ~/cli_tools/$script_name https://raw.githubusercontent.com/J-sephB-lt-n/my-personal-configs/main/cli_tools/$script_name
done
echo 'export PATH=$PATH:~/cli_tools' >> ~.bashrc
echo 'chmod +x ~/cli_tools/*' >> ~.bashrc

wget -O ~/.tmux.conf https://raw.githubusercontent.com/J-sephB-lt-n/my-personal-configs/main/.tmux.conf

source ~/.bashrc
