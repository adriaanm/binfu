export ANT_OPTS="-Xmx3g" # -Xms3g -XX:+TieredCompilation -XX:ReservedCodeCacheSize=256m -XX:MaxPermSize=384m -XX:+UseNUMA -XX:+UseParallelGC"
# export ANT_OPTS="-Xms1536M -Xmx4096M -Xss2M -XX:MaxPermSize=512M -XX:ReservedCodeCacheSize=256m"

function debug () {
  export JAVA_OPTS="-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=y,address=8002"
}

function nodebug () {
  export JAVA_OPTS=""
}

difftest () { for i in $(find test/files -name "*-$1.log"); do diff -u ${i//-$1.log/.check} $i; done }

# alias eclipsem="/Applications/eclipse/Eclipse.app/Contents/MacOS/eclipse --launcher.ini /Users/adriaan/eclipse/eclipse.ini -data /Users/adriaan/eclipse/master/workspace -configuration /Users/adriaan/eclipse/master/configuration -clean"
# alias eclipser="/Applications/eclipse/Eclipse.app/Contents/MacOS/eclipse --launcher.ini /Users/adriaan/eclipse/eclipse.ini -data /Users/adriaan/eclipse/release/workspace -configuration /Users/adriaan/eclipse/release/configuration -clean"

alias qs='~/git/scala/build/quick/bin/scala -Dscala.color=1 -cp /tmp'
alias qsx='~/git/scala/build/quick/bin/scala -Dscala.color=1 -Xexperimental -cp /tmp'
alias qsc='~/git/scala/build/quick/bin/scalac -d /tmp -cp /tmp'
alias pt='test/partest --all'
# alias ptv='SCALAC_OPTS=-Yvirtpatmat test/partest'
# alias vs='~/git/scala-virt/build/quick/bin/scala -cp /tmp'
# alias vsc='~/git/scala-virt/build/quick/bin/scalac -d /tmp -cp /tmp'
# alias vscx='~/git/scala-virt/build/quick/bin/scalac -d /tmp -cp /tmp -Xexperimental'


function strap () { sbt clean publishLocal ; sbt -Dstarr.version=2.12.0-local-$(g rev-parse --short HEAD) ; }

function SI () { open https://issues.scala-lang.org/browse/SI-$1 ; }
function P () { open https://github.com/scala/scala/pull/$1 ; }

function closew () {
  jira comment $1 $2
  jira close $1 
}

# create a scala distribution for any commit that passed the pr-scala-publish-core part of PR validation
# this assumes:
# - a global sbt config (e.g., in ~/.sbt/0.13/resolvers.sbt) with the line:
#    resolvers += "pr-scala" at "http://private-repo.typesafe.com/typesafe/scala-pr-validation-snapshots/"
# - initial setup:
#   cd ~/git
#   hub clone scala/scala-dist
function pr_dist () {
  pr=$1
  sha=$(git ls-remote https://github.com/scala/scala.git refs/pull/$pr/head | cut -f1)
  echo "Making scala-dist for the head commit $sha of #$pr:"
  sha_dist $sha
}
function sha_dist() {
  sha=$1
  pushd ~/git/scala-dist > /dev/null
  sbt 'set version := "2.11.0-'${sha:0:7}'-SNAPSHOT"' clean universal:stage
  echo "Scala dist in `pwd`/target/universal/stage/bin/scala"
  popd > /dev/null
}
alias prs='~/git/scala-dist/target/universal/stage/bin/scala -cp /tmp'
alias prsc='~/git/scala-dist/target/universal/stage/bin/scalac -d /tmp -cp /tmp'

alias scala="~/scala/latest/bin/scala"
alias scalac="~/scala/latest/bin/scalac"
alias scala29="~/scala/2.9/bin/scala"
alias scalac29="~/scala/2.9/bin/scalac"
