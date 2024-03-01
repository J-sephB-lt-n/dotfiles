# interactively search for package documentation #
alias findman="compgen -c | fzf | xargs man"

# interactive kubernetes pod explorer #
alias xpod="kubectl get pods --all-namespaces --no-headers | fzf | awk '{print \$2, \$1}' | xargs -n 2 sh -c 'kubectl describe pod \$0 --namespace \$1'"

# explore files in current folder (sorted by size) #
alias xf="find . -type f -not -path '*/venv/*' -not -path '*/__pycache__/*' -not -path '*/.mypy_cache/*' | xargs du -sh | sort -hr | fzf --preview 'cat {2}' --bind 'enter:become(echo {2})' | xargs -o vim"

# tree view of current folder (and subfolders) excluding clutter # 
alias cleantree="tree -a -I __pycache__ -I venv -I node_modules -I .mypy_cache"

# quick navigation
alias ..="cd .."
alias ...="cd ../.."
