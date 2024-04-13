apt-get update
apt-get install -y --no-install-recommends \
    bc fzf htop tmux tree vim wget

wget https://raw.githubusercontent.com/J-sephB-lt-n/my-vim-config/main/.vimrc  
mv .vimrc ~/.vimrc 
wget https://raw.githubusercontent.com/J-sephB-lt-n/my-personal-bashrc-zshrc/main/.bash_aliases
mv .bash_aliases ~/.bash_aliases
echo "source ~/.bash_aliases" >> ~/.bashrc
