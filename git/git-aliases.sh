a() {
    if [ $# -eq 0 ]
    then
        git add -A
    else
        git add $@
    fi
}
ac() {
    local message="$1"
    if [ $# -ne 0 ]
    then
        shift
    fi
    git a $@
    git cc "$message"
}
acc() {
    local message="$1"
    if [ $# -ne 0 ]
    then
        shift
    fi
    git a $@
    git c "$message"
}
acf() {
    git acc "$@"
    git pf
}
alias() {
    git config alias.$1 | sed 's/\(  \+\)/\n    /g'
}
ap() {
    git add -p
    git dc
}
as() {
    if [ $# -eq 0 ]
    then
        git a
    else
        git a $*
    fi
    git s
}
asd() {
    git as $@
    git dc
}
# checks out a branch, creates if not exist
b() {
    local current=$(git symbolic-ref --short HEAD)
    local pass=0
    local writelast=0
    if [ $1 ]
    then
        echo $1
        if git co $(echo $1 | sed 's/remotes\/[^\/]*\///g') 2>/dev/null
        then
            git p
            sleep 1
            pass=1
            writelast=1
        elif git co -b $1
        then
            pass=1
            writelast=1
        fi
    else
        pass=1
    fi
    if [ $pass = 1 ]
    then
        if [ $writelast = 1 ]
        then
            echo $current > $(git rev-parse --git-dir)/LAST_BRANCH
        fi
        git list-branches
        echo -e "\n\tb\t$(cat $(git rev-parse --git-dir)/LAST_BRANCH)"
    fi
}
bb() {
    git b $(cat $(git rev-parse --git-dir)/LAST_BRANCH)
}
bbg() {
    git b $(git bg $1)
}
bdg() {
    git bd $(git bg $1 n | sed 's/*//g')
}
bdn() {
    git bd $(git branch -a --color=never | head -n${1} | tail -n1)
    git list-branches
}
bg() {
    if [ "$2" = "" ]
    then
        a=-a
    fi
    git branch $a | grep $1
}
# switch to nth last branch, as shown by git b
bn() {
    git b $(git branch -a --color=never | head -n${1} | tail -n1)
}
br() {
    local branch=$(git symbolic-ref --short HEAD)
    git co -b $1
    git bd $branch
}
c() {
    if [ "$(git log -1 --pretty=%B)" = "WIP" ]
    then
        git st
        git wip
        git sp
        git c "$1"
    else
        if [ "$1" = "" ]
        then
            git commit
        else
            git commit-with-issue-tag "$@"
        fi
    fi
}
# commit and push
cc() {
    git c "$1"
    git pp
}
cl() {
    local toclean="$(git clean -n -d)"
    echo "$toclean"
    if [ "$toclean" != "" ]
    then
        read -p 'Enter y to confirm, or anything else to quit: ' y
        if [ "$y" = "y" ]
        then
            git clean -f -d
        fi
    fi
}
clo() {
    find . -name \*.orig | xargs -I{} rm "{}"
}
# redo commit
cr() {
    message=$(git log -1 --pretty=%B)
    git uc
    [ "$(git diff --name-only --cached)" = "" ] && git a
    git commit -m "$message"
    git pf
}
# diff blame filename line
db() {
    local rev="$(git blame $1 -L $2,$2 | cut -d' ' -f1)"
    echo $rev
    git df $1 $rev
}
# diff a commit against previous
dd() {
    local hash="$1"
    if [ "$hash" = "" ]
    then
        local hash="@"
    else
        shift
    fi
    git d "$hash^" "$hash" "$@"
}
# diff a file
df() {
    git dfh $1 $2 n
}
# keep diffing a file
dfh() {
    local current="$2"
    if [ "$current" = "" ]
    then
        local current="@"
    fi
    local prev="$(git rev-list $(git rev-list @ | tail -n 1)..$current^ $1 | head -n 1)"
    git log -n 1 $prev
    git d -y $prev:$1 $2:$1
    if [ "$3" = "" ]
    then
        read -p 'Enter q to quit, or anything else to continue: ' q
        if [ "$q" != "q" ]
        then
            git dfh $1 $prev
        else
            echo
        fi
    fi
}
# diff names only
dn() {
    if [ "$1" = "" ]
    then
        git diff --name-only
    else
        git diff --name-only "$1^!"
    fi
}
# diff using git show, `other` `this`
do() {
    git show $1 | vim -d - +"vs $2 | wincmd r | windo diffthis | windo set ro"
}
# diff stash
ds() {
    local stash="$1"
    if [ "$stash" = "" ]
    then
        local stash="0"
    fi
    git difftool ...stash@{$stash}
}
# grep files
g() {
    git rev-list --all -- "$2"  | xargs git grep "$1"
}
mtr() {
    git mt
    git rh
}
mtrd() {
    git mtr
    git std
}
p() {
    [ "$1" = "" ] && branch=$(git symbolic-ref --short HEAD) || branch=$1
    git pull origin $branch
}
pa() {
    local current="$(git symbolic-ref --short HEAD)"
    git branch -r | grep -v '\->' | while read remote
    do
        git b ${remote#origin/}
        git p
    done
    git b $current
}
pf() {
    git push --force origin $(git symbolic-ref --short HEAD)
}
# pull nth last branch, as shown by git b
pn() {
    git p $(git branch -a --color=never | head -n${1} | tail -n1)
}
pp() {
    git push origin $(git symbolic-ref --short HEAD)
}
r() {
    git reset --hard origin/$(git symbolic-ref --short HEAD)
}
rcl() {
    git r
    git cl
}
sd() {
    git s
    git d
}
# last two weeksprint
sr() {
    git f
    git lm --branches=* --since="2 weeks"
}
std() {
    git stash drop
    git sl
}
stb() {
    git st
    git b $1
}
stbp() {
    git stb $1
    git sp
}
stbpm() {
    git stbp master
}
stp() {
    git st
    git p $1
    git sp
}
stpm() {
    git stp master
}
# last working day logs for current user on all branches
su() {
    git f
    if [ $(date +%u) -eq 1 ]
    then
        git lm --branches=* --since="3 day"
    else
        git lm --branches=* --since="1 day"
    fi
}
t() {
    git tag -a "$1" -m "$1"
    git push --tags
}
wip() {
    git p
    if [ "$(git log -1 --pretty=%B)" = "WIP" ]
    then
        git uc
        git rh
        git pf
    else
        git as
        git commit -m WIP
        git pp
    fi
}
