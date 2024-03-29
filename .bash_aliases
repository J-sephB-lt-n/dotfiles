# -- TMUX -- 
# set up IDE-like tmux panes (run this within tmux)
alias ide="tmux send-keys \"xf\" C-m && tmux split-window -h && tmux send-keys \"ct | less\" C-m && tmux split-window -v && tmux send-keys \"python\" C-m && tmux select-pane -L"
alias trpu="tmux resize-pane -U"
alias trpd="tmux resize-pane -D"
alias trpl="tmux resize-pane -L"
alias trpr="tmux resize-pane -R"

timer () {
    if [[ -z "${TIMER_START}" ]]; then
        export TIMER_START=$EPOCHREALTIME
    else
        seconds_elapsed=$(echo "$EPOCHREALTIME - $TIMER_START" | bc)
        minutes_elapsed=$(echo "scale=2; $seconds_elapsed / 60" | bc)
        echo "minutes elapsed: $minutes_elapsed"
        echo "seconds elapsed: $seconds_elapsed"
        unset TIMER_START
    fi 
}

# interactively search for package documentation #
alias findman="compgen -c | fzf | xargs man"

# interactive kubernetes pod explorer #
alias xpod="kubectl get pods --all-namespaces --no-headers | fzf | awk '{print \$2, \$1}' | xargs -n 2 sh -c 'kubectl describe pod \$0 --namespace \$1'"

# explore files in current folder (sorted by size) and open one in vim #
alias xf="find . -type f -not -path '*/venv/*' -not -path '*/*cache*/*' -not -path '*/\.*/*' | xargs du -sh | sort -hr | fzf --preview 'cat {2}' --bind 'enter:become(echo {2})' | xargs -o vim"

# tree view of current folder (and subfolders) excluding clutter # 
alias ct="tree -a -I __pycache__ -I venv -I node_modules -I .mypy_cache -I .git -I .pytest_cache"
alias clct="clear && ct"
alias clctl="clear && ct | less"

# clean recursive grep (ignores certain folders) #
alias crg="grep -rI --exclude-dir venv --exclude-dir __pycache__ --exclude-dir node_modules --exclude-dir .mypy_cache"

# quick navigation
alias ..="cd .."
alias ...="cd ../.."
alias cl="clear"
std () {
    # save directory path to remember (under custom name)
    if [[ "$TERM" =~ "screen".* ]]; then
        # if we are in TMUX
        echo "saving path in TMUX env"
        tmux setenv -g SETDIR_$1 $(pwd)
    else
        echo "saving path in shell env"
        export SETDIR_$1=$(pwd)
    fi
}
gtd () {
    # get remembered directory path (by custom name)
    if [[ "$TERM" =~ "screen".* ]]; then
        echo "fetching path from TMUX env"
        saved_dir=$(tmux showenv -g | grep SETDIR_$1 | sed "s:^.*=::")
    else
        echo "fetching path from shell env"
        saved_dir=$(env | grep SETDIR_$1 | sed "s:^.*=::")
    fi
    cd $(echo $saved_dir)
    #if [ $SHELL = "/bin/zsh" ]; then
    #    cd ${(P)saved_dir}   
    #elif [ $SHELL = "/bin/bash" ]; then
    #    cd ${!saved_dir} 
    #else
    #    echo "ERROR: shell '$SHELL' not supported" 
    #fi
}
lsd () {
    # list remembered directory paths
    if [[ "$TERM" =~ "screen".* ]]; then
        echo "listing saved paths in TMUX env"
        tmux showenv -g | grep "^SETDIR_" | cut -c 8-
    else
        echo "listing saved paths in shell env"
        env | grep "^SETDIR_" | cut -c 8-
    fi
}
rm_setdir () {
    # remove remembered directory path by name
    if [[ "$TERM" =~ "screen".* ]]; then
        echo "removing saved path '$1' from TMUX env"
        tmux setenv -g -u SETDIR_$1
    else
        echo "removing saved path '$1' from shell env"
        unset SETDIR_$1 
    fi
}
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
alias grs.="git restore --staged ."
alias gst="git status"
alias czc="cz commit"

# example usage: uuid 4
uuid () {
    python -c "import uuid; print(uuid.uuid$1().hex)" 
}

# TASK TIMER #
# timer state is stored in /var/tmp/task_timers/
if [[ ! -e /var/tmp/task_timers/ ]]; then
    echo "creating directory /var/tmp/task_timers/"
    mkdir /var/tmp/task_timers/
fi
tmr_go () { # start specific timer
    # e.g. tmr_go work -> "started timer [work]"
    if [[ ! -f /var/tmp/task_timers/$1.tmr ]]; then
        echo -n $EPOCHREALTIME > /var/tmp/task_timers/$1.tmr
        echo "started timer [$1]"
    else
        latest_entry=$(tail -n 1 /var/tmp/task_timers/$1.tmr)
        n_entries=$(awk "{print NF}" <<< "$latest_entry")
        if [[ n_entries -eq 1 ]]; then
            echo "timer [$1] is already running"
        else
            echo -n $EPOCHREALTIME >> /var/tmp/task_timers/$1.tmr
            echo "started timer [$1]"
        fi
    fi
}
tmr_stop () { # stop specific timer
    # e.g. tmr_stop work -> "stopped timer [work]. 69 minutes elapsed."
    if [[ ! -f /var/tmp/task_timers/$1.tmr ]]; then
       echo "timer [$1] does not exist"
    else
        latest_entry=$(tail -n 1 /var/tmp/task_timers/$1.tmr)
        n_entries=$(awk "{print NF}" <<< "$latest_entry")
        if [[ n_entries -eq 1 ]]; then
            echo " ${EPOCHREALTIME}" >> /var/tmp/task_timers/$1.tmr
            echo "stopped timer [$1]"
        else
            echo "timer [$1] is already stopped"
        fi
    fi
}
tmr_view () { # view specific timer
    # e.g. tmr_view work
    if [[ ! -f /var/tmp/task_timers/$1.tmr ]]; then
        echo "timer [$1] does not exist"
    else
        echo "--Summary of Timer [$1]--"
        cat /var/tmp/task_timers/$1.tmr | while read line || [[ -n $line ]];
        do
            n_entries=$(awk "{print NF}" <<< "$line")
            if [[ $n_entries -eq 2 ]]; then
               start_utc=$(echo $line | cut -d " " -f 1)
               end_utc=$(echo $line | cut -d " " -f 2)
               echo -n $(perl -le 'print scalar localtime $ARGV[0]' $start_utc) 
               echo -n " --> "
               echo -n $(perl -le 'print scalar localtime $ARGV[0]' $end_utc) 
               echo ""
            else
               start_utc=$(echo $line | cut -d " " -f 1)
               echo -n $(perl -le 'print scalar localtime $ARGV[0]' $start_utc) 
               echo -n " --> "
               echo "<currently running>"
            fi
        done
        echo "TOTAL TIME: TODO"
    fi
}
tmr_ls () { # list all timers
    ls -1 /var/tmp/task_timers/
}
tmr_delete () {
    if [[ ! -f /var/tmp/task_timers/$1.tmr ]]; then
        echo "timer [$1] does not exist"
    else
        rm /var/tmp/task_timers/$1.tmr
        echo "deleted timer [$1]"
    fi
}
