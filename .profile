# MUST NOT CONTAIN SECRETS

export PATH="$HOME/bin:$HOME/scala/latest/bin:/usr/local/bin:/usr/local/sbin:$PATH"
export SCALA_SRC_HOME=$HOME/git/scala
export SCALA_PACKS_DIR=$HOME/scala-packs

export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Versions/1.6/Home/
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
