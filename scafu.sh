export ANT_OPTS="-Xmx3g -Xms3g -XX:+TieredCompilation -XX:ReservedCodeCacheSize=256m -XX:MaxPermSize=384m -XX:+UseNUMA -XX:+UseParallelGC"
# export ANT_OPTS="-Xms1536M -Xmx4096M -Xss2M -XX:MaxPermSize=512M -XX:ReservedCodeCacheSize=256m"

function debug () {
  export JAVA_OPTS="-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=y,address=8001"
}

function nodebug () {
  export JAVA_OPTS=""
}

difftest () { for i in `find test/files -name *-$1.log`; do diff -u `echo $i | perl -pe s/-$1.log/.check/` $i; done }

# alias eclipsem="/Applications/eclipse/Eclipse.app/Contents/MacOS/eclipse --launcher.ini /Users/adriaan/eclipse/eclipse.ini -data /Users/adriaan/eclipse/master/workspace -configuration /Users/adriaan/eclipse/master/configuration -clean"
# alias eclipser="/Applications/eclipse/Eclipse.app/Contents/MacOS/eclipse --launcher.ini /Users/adriaan/eclipse/eclipse.ini -data /Users/adriaan/eclipse/release/workspace -configuration /Users/adriaan/eclipse/release/configuration -clean"

alias ant="gant"
alias qs='~/git/scala/build/quick/bin/scala -cp /tmp'
alias qsc='~/git/scala/build/quick/bin/scalac -d /tmp -cp /tmp'
alias pt='test/partest --all'
# alias ptv='SCALAC_OPTS=-Yvirtpatmat test/partest'
# alias vs='~/git/scala-virt/build/quick/bin/scala -cp /tmp'
# alias vsc='~/git/scala-virt/build/quick/bin/scalac -d /tmp -cp /tmp'
# alias vscx='~/git/scala-virt/build/quick/bin/scalac -d /tmp -cp /tmp -Xexperimental'

alias aqb='ant quick.bin'
alias part='ant pack.done && test/partest'

lanton () { (git fetch origin ; git clean -fxd ; git checkout -f $1 ; git reset --hard ; git --no-pager show ; lant $2 $3 $4 ) | tee /tmp/log ; (grep timer /tmp/log; grep -i fail /tmp/log; cat /tmp/log) | mail -s "buildlog" adriaan.moors@typesafe.com ; git push origin; }
testopt () { lanton $1 test-opt $2 $3 $4 ; }
nightly () { lanton $1 nightly $2 $3 $4 ; }

function SI () { open https://issues.scala-lang.org/browse/SI-$1 ; }
function P () { open https://github.com/scala/scala/pull/$1 ; }

function closew () {
  jira comment $1 $2
  jira close $1 
}

function pr_dist () {
  pr=$1
  sha=$(cd ~/git/scala && git fetch scala refs/pull/$pr/head && git rev-parse FETCH_HEAD)
  pushd ~/git/scala-dist
  sbt 'set version := "2.11.0-'${sha:0:7}'-SNAPSHOT"' clean universal:stage
  echo "To run the repl for #$pr:"
  echo "`pwd`/target/universal/stage/bin/scala"
  popd
}

alias scala="~/scala/latest/bin/scala"
alias scalac="~/scala/latest/bin/scalac"
alias scala29="~/scala/2.9/bin/scala"
alias scalac29="~/scala/2.9/bin/scalac"
