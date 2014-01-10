export PS1='$(__git_ps1 "[ %s ]") \W/ \$ ' # \e]1;\W/ $(__git_ps1 "%s")\a'
export GIT_PS1_SHOWUPSTREAM="auto"
export GIT_PS1_SHOWDIRTYSTATE="1"
export GIT_PS1_SHOWUNTRACKEDFILES="1"
export GIT_PS1_SHOWSTASHSTATE="1"

alias g='git'
alias gam='git commit -a -m'
alias gba='git branch -a'
alias gbag='git branch -a |grep'
alias gdh='git diff head^ head'
alias gdhm='git diff head^ | mate'
alias gdm...='git diff master... -- src'
alias gdm='git diff master'
alias gdmm='git diff master | mate'
alias gdsh='git diff --stat=100,100 head^'
alias gdsm...='git diff --stat master... -- src'
alias gdsm='git diff --stat=100,100 master'
alias gfrr='git fetch . refs/remotes/*:refs/heads/*'
alias git-svn-sha-pairs="git svn log --oneline --show-commit | cut -d '|' -f 1,2"
alias gitpatches='git format-patch --full-index --binary'
alias glsm='git log --no-merges master..' # git, log since master
alias glnm='git lol --branches --not master'
alias gmm='git merge master'
alias gra='git rebase --abort'
alias grc='git rebase --continue'
alias grh='git reset --hard'
alias grhchop='git reset --hard ; git chop'
alias grhh='git reset --hard head^'
alias grm='git rebase master'
alias gsr='git svn rebase'
alias gupd='git commit -a --amend -C head'
alias gvps='git verify-pack -v .git/objects/pack/pack-*.idx | sort -k3n'
alias gprm='git pull --rebase main master'
alias gaup='git add -u --patch'

function gnbm() { git fetch main; git checkout main/master -b $1; git push --set-upstream origin $1 ;} # git new branch off of master

alias grim='git fetch main ; git rebase -i remotes/main/master'
alias gris='git fetch main ; git rebase -i remotes/main/2.10.x'

alias gm='git merge --log=100 -s recursive -X ignore-space-at-eol -X patience'

function newpull() { 
  curr_branch=$(git symbolic-ref -q HEAD)
  curr_branch=${curr_branch##refs/heads/}
  curr_branch=${curr_branch:-HEAD}
  ghUser=$(git config github.user)
  repo=$(git remote -v | cut -f2 | grep $ghUser | tail -n 1 | perl -pe 's/.*$ghUser\/(\S*).git.*/$1/' )
  repo=${repo:-scala}
  upstream=scala # TODO
  open https://github.com/$ghUser/$repo/pull/new/$upstream:${1:-master}...${2:-$curr_branch}
}


# function gitpa() { git push --all ;}
# # ticket workflow: check ticket N in trac, accept, gitnewt N, add test files tN.scala, hack hack hack, git commit, testtick N, gitdone N, git commit, git svn dcommit
# function gitnewt() { gitsvnup && git checkout -b ticket/$1 ;}
# 
# # these functions expect a screen daemon running on chara:  screen -dmS anttest
# function testtick() { gitpa && ssh chara "screen -D -RR anttest -p compile -X screen ~/bin/scabld ticket/$1 test-opt clean" ;}
# function quicktick() { gitpa && ssh chara "screen -D -RR anttest -p compile -X screen ~/bin/scabld ticket/$1 quick.bin" ;}
# function testmaster() { gitpa && ssh chara "screen -D -RR anttest -p compile -X screen ~/bin/scabld master test-opt clean" ;}
# function quickmaster() { gitpa && ssh chara "screen -D -RR anttest -p compile -X screen ~/bin/scabld master quick.bin" ;}
# function scabld() { gitpa && ssh chara "screen -D -RR anttest -p compile -X screen ~/bin/scabld $*" ;}
# 
# function gitdone() { gitsvnup && git merge -n --squash ticket/$1 && gitfixed $1;}
# 
# function gittick() { gitco ticket/$1 ;}
# function gitreopen() { git branch -M fixed/$1 ticket/$1 ; gittick $1 ;}
# function gitfixed() { git branch -M ticket/$1 fixed/$1 ;}
# function gitobsol() { git branch -M ticket/$1 obsolete/$1 ;}
# function gitpending() { git branch -M ticket/$1 pending/$1 ;}
# 
# # looking up stuff in Trac
# function querytick() { echo -n "Ticket $1:"; curl -s -o - http://lampsvn.epfl.ch/trac/scala/ticket/$1 | grep '<span class="status">' | perl -pe 's/\s*<span class="status">//;' ;}
# function querybranchticks() { for t in `git branch | grep -e "ticket\/[0-9][0-9]*" | perl -pe 's/^.*ticket\/(\d+)/$1/'`; do querytick $t; done ;}
# function synchclosedticks() { for t in `querybranchticks | grep "(closed" | perl -pe 's/^Ticket (\d*):.*$/$1/'`; do gitfixed $t; done ;}
# function lsmybugs() { curl -s -o - 'http://lampsvn.epfl.ch/trac/scala/query?status=assigned&status=new&status=reopened&format=tab&order=priority&priority=%21low&col=id&col=summary&owner=moors&type=defect' ;}
# function lspending() { curl -s -o - 'http://lampsvn.epfl.ch/trac/scala/query?status=assigned&status=closed&status=new&status=reopened&format=tab&order=priority&col=id&col=summary&keywords=%7Epatch_pending&owner=moors&type=defect' ;}
