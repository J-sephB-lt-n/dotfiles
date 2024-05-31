source .bash_aliases

# print some system specs to screen #
echo $(uname -a)
echo "SHELL is '${SHELL}'"

# add files/folders to PATH:
export PATH=$PATH:~/cli_scripts 
chmod +x ~/cli_scripts/*
