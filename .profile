# MUST NOT CONTAIN SECRETS

export PATH="$HOME/bin:$HOME/scala/latest/bin:/usr/local/bin:/usr/local/sbin:$PATH"

export PATH=$(brew --prefix ruby)/bin:$PATH

export SCALA_SRC_HOME=$HOME/git/scala
export SCALA_PACKS_DIR=$HOME/scala-packs

java_home () {
  export JAVA_HOME=$(/usr/libexec/java_home -v $1)
  export PATH=$JAVA_HOME/bin:$PATH
}

java_home 1.8

export EDITOR=`which mate_wait`

source ~/bin/gitfu.sh
source ~/bin/hubfu.sh
source ~/bin/scafu.sh
source ~/bin/sonafu.sh


# to use XQuartz
export DISPLAY=:0
# for gnuplot
export GNUTERM=x11

# if [ -f `brew --prefix`/etc/bash_completion ]; then
# . `brew --prefix`/etc/bash_completion
# fi

# http://www.interworks.com/blogs/ckaukis/2013/03/05/installing-ruby-200-rvm-and-homebrew-mac-os-x-108-mountain-lion
# [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# #source /usr/local/etc/bash_completion.d/git-completion.bash
source ~/bin/gitfu.sh
source ~/bin/hubfu.sh
source ~/bin/scafu.sh
source ~/bin/sonafu.sh
# source ~/git/libscala/libscala.sh # not compatible with zsh

# export PS1='\W/ $(__git_ps1 "(%s)") \$ ' # this tells terminal to open a new tab in this directory somehow
# export PROMPT_COMMAND='__git_ps1 "\W/ " " \\\$ " "(%s)"' -- this has colors, but loses the CWD info
# export GIT_PS1_SHOWUPSTREAM="auto"
# export GIT_PS1_SHOWDIRTYSTATE="1"
# export GIT_PS1_SHOWUNTRACKEDFILES="1"
# export GIT_PS1_SHOWSTASHSTATE="1"
# export GIT_PS1_SHOWCOLORHINTS="1"
