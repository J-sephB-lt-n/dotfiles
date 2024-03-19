# -- TMUX -- 
# set up IDE-like tmux panes (run this within tmux)
alias ide="tmux send-keys \"xf\" C-m && tmux split-window -h && tmux send-keys \"ct | less\" C-m && tmux split-window -v && tmux send-keys \"python\" C-m && tmux select-pane -L"
alias trpu="tmux resize-pane -U"
alias trpd="tmux resize-pane -D"
alias trpl="tmux resize-pane -L"
alias trpr="tmux resize-pane -R"

# interactively search for package documentation #
alias findman="compgen -c | fzf | xargs man"

# interactive kubernetes pod explorer #
alias xpod="kubectl get pods --all-namespaces --no-headers | fzf | awk '{print \$2, \$1}' | xargs -n 2 sh -c 'kubectl describe pod \$0 --namespace \$1'"

# explore files in current folder (sorted by size) and open one in vim #
alias xf="find . -type f -not -path '*/venv/*' -not -path '*/*cache*/*' -not -path '*/\.*/*' | xargs du -sh | sort -hr | fzf --preview 'cat {2}' --bind 'enter:become(echo {2})' | xargs -o vim"

# tree view of current folder (and subfolders) excluding clutter # 
alias ct="tree -a -I __pycache__ -I venv -I node_modules -I .mypy_cache -I .git -I .pytest_cache"

# clean recursive grep (ignores certain folders) #
alias crg="grep -rI --exclude-dir venv --exclude-dir __pycache__"

# quick navigation
alias ..="cd .."
alias ...="cd ../.."
alias cl="clear"

# see my public-facing IP address #
alias myip="curl ipinfo.io/ip"

# list files in Amazon S3 bucket 
lss3 () {
    # list files files in s3 bucket
    # example usage: 
    #   lss3 s3://mybucket/myfolder/ 
    #   lss3 s3://mybucket/myfolder/ | wc -l
    aws s3 ls $1 --recursive
}

# make file overwriting less likely
alias cp="cp -iv"
alias mv="mv -iv"
alias rm="rm -v"
alias mkd="mkdir -pv"

# git aliases #
alias ga="git add"
alias ga.="git add ."
alias gb="git branch"
alias gch="git checkout"
alias gd="git diff"
alias gdn="git diff --name-only"
alias gp="git push"
alias gpom="git pull origin main --no-rebase"
alias gst="git status"
alias czc="cz commit"

# example usage: uuid 4
uuid () {
    python -c "import uuid; print(uuid.uuid$1().hex)" 
}
#alias uuid="python -c \"import uuid; import sys; print(uuid.uuid$1().hex)\""

# string encoding/decoding 
hex2string() {
    python -c "import binascii; print(binascii.unhexlify('$1').decode('utf-8'))"
}
string2hex() {
    python -c "import binascii; print(binascii.hexlify('$1'.encode('utf-8')).decode('utf-8'))"
}
