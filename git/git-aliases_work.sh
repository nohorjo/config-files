commit-with-issue-tag() {
    if git symbolic-ref --short HEAD | grep -q '^[0-9]\+'
    then
        local issue_tag="$(git symbolic-ref --short HEAD | cut -d- -f1) "
    else
        local issue_tag=""
    fi
    git commit -m "$issue_tag$@"
}
master-branch() {
    echo develop
}
