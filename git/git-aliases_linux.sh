# checks out a branch, creates if not exist
list-branches() {
    git branch -a --color=always | nl | tac
}
