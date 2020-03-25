bd() {
    git branch -D $1
    git push origin --delete $1
}
commit-with-issue-tag() {
    if git symbolic-ref --short HEAD | grep -q '^[0-9]\+'
    then
        local issue_tag="#$(git symbolic-ref --short HEAD | cut -d- -f2) - "
    else
        local issue_tag=""
    fi
    git commit -m "$issue_tag$@"
}
