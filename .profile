# MUST NOT CONTAIN SECRETS

export PATH="$HOME/bin:$HOME/scala/latest/bin:/usr/local/bin:/usr/local/sbin:$PATH"

export PATH=$(brew --prefix ruby)/bin:$PATH

export SCALA_SRC_HOME=$HOME/git/scala
export SCALA_PACKS_DIR=$HOME/scala-packs

java_home () {
  export JAVA_HOME=$(/usr/libexec/java_home -v $1)
  export PATH=$JAVA_HOME/bin:$PATH
}

java_home 1.6

export EDITOR=`which mate_wait`

# to use XQuartz
export DISPLAY=:0
# for gnuplot
export GNUTERM=x11

if [ -f `brew --prefix`/etc/bash_completion ]; then
. `brew --prefix`/etc/bash_completion
fi

# http://www.interworks.com/blogs/ckaukis/2013/03/05/installing-ruby-200-rvm-and-homebrew-mac-os-x-108-mountain-lion
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# #source /usr/local/etc/bash_completion.d/git-completion.bash
source ~/bin/gitfu.sh
source ~/bin/hubfu.sh
source ~/bin/scafu.sh
source ~/bin/sonafu.sh
source ~/git/libscala/libscala.sh
