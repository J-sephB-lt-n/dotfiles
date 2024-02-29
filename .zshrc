# interactively search for package documentation #
alias findman="compgen -c | fzf | xargs man"

# interactive kubernetes pod explorer #
alias findpod="kubectl get pods --all-namespaces --no-headers | fzf | awk '{print $2, $1}' | xargs -n 2 sh -c 'kubectl describe pod $0 -n $1'"
