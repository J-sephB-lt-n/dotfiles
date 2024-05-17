# USAGE: 
# $ wget https://raw.githubusercontent.com/J-sephB-lt-n/my-personal-configs/main/setup_joes_dev_environment.sh
# $ sudo bash setup_joes_dev_environment.sh
# $ rm setup_joes_dev_environment.sh

apt-get update
apt-get install -y --no-install-recommends \
    bc fzf htop tmux tree vim wget

wget https://raw.githubusercontent.com/J-sephB-lt-n/my-personal-configs/main/.bash_aliases
mv .bash_aliases ~/.bash_aliases
echo "source ~/.bash_aliases" >> ~/.bashrc
wget https://raw.githubusercontent.com/J-sephB-lt-n/my-personal-configs/main/.vimrc  
mv .vimrc ~/.vimrc 
