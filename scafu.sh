function jardiff() {
    [[ -f "$JARDIFF_JAR" ]] || (
        echo "Please download https://gitreleases.dev/gh/scala/jardiff/latest/jardiff.jar to a location specified by \$JARDIFF_JAR" >&2
        return 1
    )
    java -jar "$JARDIFF_JAR" "$@";
}

function nodebug () {
  export JAVA_OPTS=""
}

difftest () { for i in `find test/files -name *-$1.log`; do diff -u `echo $i | perl -pe s/-$1.log/.check/` $i; done }

# alias eclipsem="/Applications/eclipse/Eclipse.app/Contents/MacOS/eclipse --launcher.ini /Users/adriaan/eclipse/eclipse.ini -data /Users/adriaan/eclipse/master/workspace -configuration /Users/adriaan/eclipse/master/configuration -clean"
# alias eclipser="/Applications/eclipse/Eclipse.app/Contents/MacOS/eclipse --launcher.ini /Users/adriaan/eclipse/eclipse.ini -data /Users/adriaan/eclipse/release/workspace -configuration /Users/adriaan/eclipse/release/configuration -clean"

alias ant="gant"
alias qs='~/git/scala/build/quick/bin/scala -Dscala.color=1 -cp /tmp'
alias qsx='~/git/scala/build/quick/bin/scala -Dscala.color=1 -Xexperimental -cp /tmp'
alias qsc='~/git/scala/build/quick/bin/scalac -d /tmp -cp /tmp'
alias pt='test/partest --all'
# alias ptv='SCALAC_OPTS=-Yvirtpatmat test/partest'
# alias vs='~/git/scala-virt/build/quick/bin/scala -cp /tmp'
# alias vsc='~/git/scala-virt/build/quick/bin/scalac -d /tmp -cp /tmp'
# alias vscx='~/git/scala-virt/build/quick/bin/scalac -d /tmp -cp /tmp -Xexperimental'

alias aqb='ant quick.bin'
alias part='ant pack.done && test/partest'
alias acl='rm -rf build/quick/classes/{reflect,compiler} build/pack build/quick/*.complete'

lanton () { (git fetch origin ; git clean -fxd ; git checkout -f $1 ; git reset --hard ; git --no-pager show ; lant $2 $3 $4 ) | tee /tmp/log ; (grep timer /tmp/log; grep -i fail /tmp/log; cat /tmp/log) | mail -s "buildlog" adriaan.moors@typesafe.com ; git push origin; }
testopt () { lanton $1 test-opt $2 $3 $4 ; }
nightly () { lanton $1 nightly $2 $3 $4 ; }

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
=======

function nodebug () {
  export JAVA_OPTS=""
}

difftest () { for i in $(find test/files -name "*-$1.log"); do gdw ${i//-$1.log/.check} $i; done }

# alias eclipsem="/Applications/eclipse/Eclipse.app/Contents/MacOS/eclipse --launcher.ini /Users/adriaan/eclipse/eclipse.ini -data /Users/adriaan/eclipse/master/workspace -configuration /Users/adriaan/eclipse/master/configuration -clean"
# alias eclipser="/Applications/eclipse/Eclipse.app/Contents/MacOS/eclipse --launcher.ini /Users/adriaan/eclipse/eclipse.ini -data /Users/adriaan/eclipse/release/workspace -configuration /Users/adriaan/eclipse/release/configuration -clean"

alias ant="gant"
alias qs='~/git/scala/build/quick/bin/scala -Dscala.color=1 -cp /tmp'
alias qsx='~/git/scala/build/quick/bin/scala -Dscala.color=1 -Xexperimental -cp /tmp'
alias qsc='~/git/scala/build/quick/bin/scalac -d /tmp -cp /tmp'
alias pt='test/partest --all'
# alias ptv='SCALAC_OPTS=-Yvirtpatmat test/partest'
# alias vs='~/git/scala-virt/build/quick/bin/scala -cp /tmp'
# alias vsc='~/git/scala-virt/build/quick/bin/scalac -d /tmp -cp /tmp'
# alias vscx='~/git/scala-virt/build/quick/bin/scalac -d /tmp -cp /tmp -Xexperimental'

alias aqb='ant quick.bin'
alias part='ant pack.done && test/partest'
alias acl='rm -rf build/quick/classes/{reflect,compiler} build/pack build/quick/*.complete'

lanton () { (git fetch origin ; git clean -fxd ; git checkout -f $1 ; git reset --hard ; git --no-pager show ; lant $2 $3 $4 ) | tee /tmp/log ; (grep timer /tmp/log; grep -i fail /tmp/log; cat /tmp/log) | mail -s "buildlog" adriaan.moors@typesafe.com ; git push origin; }
testopt () { lanton $1 test-opt $2 $3 $4 ; }
nightly () { lanton $1 nightly $2 $3 $4 ; }

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
