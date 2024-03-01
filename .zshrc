# interactively search for package documentation #
alias findman="compgen -c | fzf | xargs man"

# interactive kubernetes pod explorer #
alias k8spodexplorer="kubectl get pods --all-namespaces --no-headers | fzf | awk '{print \$2, \$1}' | xargs -n 2 sh -c 'kubectl describe pod \$0 --namespace \$1'"

# explore files in current folder (sorted by size) #
alias explorefiles="find . -type f | xargs du -sh | sort -hr | fzf --preview 'cat {2}'"

# tree view of current folder (and subfolders) excluding clutter #
alias cleantree="tree -I __pycache__ -I venv -I node_modules"
