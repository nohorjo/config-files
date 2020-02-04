bd() {
    git branch -D $1
    git push origin --delete $1
}
commit-with-issue-tag() {
    local issue_tag="#$(git symbolic-ref --short HEAD | cut -d- -f1) -"
    if [ "$(echo $issue_tag | sed 's/[^0-9 \-#]//g')" = '' ]
    then
        local issue_tag=""
    fi
    git commit -m "$issue_tag $@"
}
