# USAGE: 
# $ sudo wget https://raw.githubusercontent.com/J-sephB-lt-n/my-personal-configs/main/setup_joes_dev_environment.sh
# $ sudo bash setup_joes_dev_environment.sh
# $ rm setup_joes_dev_environment.sh

apt-get update
apt-get install -y --no-install-recommends \
    bc fzf htop tmux tree vim wget

wget --directory-prefix=~ https://raw.githubusercontent.com/J-sephB-lt-n/my-personal-configs/main/.bash_aliases
echo 'source ~/.bash_aliases' >> ~/.bashrc
wget --directory-prefix=~ https://raw.githubusercontent.com/J-sephB-lt-n/my-personal-configs/main/.vimrc  

mkdir ~/cli_scripts
for script_name in "gpt.py"; 
do
    wget --directory-prefix=~/cli_scripts https://raw.githubusercontent.com/J-sephB-lt-n/my-personal-configs/main/cli_scripts/$script_name
done
echo 'export PATH=$PATH:~/cli_scripts' >> ~/.bashrc
echo 'chmod +x ~/cli_scripts/*' >> ~/.bashrc

wget --directory-prefix=~ https://raw.githubusercontent.com/J-sephB-lt-n/my-personal-configs/main/.tmux.conf

source ~/.bashrc
