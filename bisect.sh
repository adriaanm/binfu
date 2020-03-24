#!/usr/bin/env bash

notice() {
  cat <<EOF
notice:
* currently you have to edit this script for each use
maintenance status:
* this is somewhat rough, but hopefully already useful
* pull requests with improvements welcome
EOF
}

die () {
  echo "$@"
  exit 1
}

repo_dir=$(git rev-parse --show-toplevel) || die "Run this script in a Scala git checkout"

current () {
  local sha=$(cat "$repo_dir/.git/BISECT_HEAD")
  echo ${sha:0:10}
}

scalaVersion () {
  local sha=$(current)
  sha=${sha:0:7}
  local artifact=$(curl -s "https://scala-ci.typesafe.com/artifactory/api/search/artifact?name=$sha" | jq -r '.results | .[] | .uri' | grep "/scala-compiler-.*-$sha.jar")
  # scala version is in second-to-last column
  # http://scala-ci.typesafe.com/artifactory/api/storage/scala-integration/org/scala-lang/scala-compiler/2.13.0-pre-d40e267/scala-compiler-2.13.0-pre-d40e267.jar
  res=$(echo $artifact | awk -F/ '{print $(NF-1)}' 2> /dev/null)
  echo $res
}

# Use `return` instead of `exit` to get some additional logging (using `exit` also works)
# Return 125 for commits that need to be skipped
run () {
  local sha=$(current)

  local num=$(git rev-list --parents -n 1 $sha | wc -w | tr -d ' ')
  [[ $num -gt 2 ]] || {
    echo "Not a merge commit: $sha"
    return 125
  }

  local br="2.12.x"
  local brs=$(git branch --contains $sha)
  if $(grep 2.10.x <<< $brs > /dev/null) ; then
    [[ "$br" == "2.10.x" ]] || {
      echo "Merge commit from 2.10.x: $sha"
      return 125
    }
  elif $(grep 2.11.x <<< $brs > /dev/null) ; then
    [[ "$br" == "2.11.x" || "$br" == "2.10.x" ]] || {
      echo "Merge commit from 2.11.x: $sha"
      return 125
    }
  elif $(grep 2.12.x <<< $brs > /dev/null) ; then
    [[ "$br" == "2.12.x" || "$br" == "2.11.x" || "$br" == "2.10.x" ]] || {
      echo "Merge commit from 2.12.x: $sha"
      return 125
    }
  elif $(grep 2.13.x <<< $brs > /dev/null) ; then
    [[ "$br" == "2.13.x" || "$br" == "2.12.x" || "$br" == "2.11.x" || "$br" == "2.10.x" ]] || {
      echo "Merge commit from 2.13.x: $sha"
      return 125
    }
  fi

  local sv=$(scalaVersion)
  [[ ! -z "$sv" ]] || {
    echo "Could not find artifact for $sha on scala-integration"
    return 125
  }

  # local cp=$(coursier fetch -p -r https://scala-ci.typesafe.com/artifactory/scala-integration org.scala-lang:scala-compiler:$sv)
  # [[ ! -z "$cp" ]] || {
  #   echo "Coursier failed to download Scala version $sv"
  #   return 125
  # }
  # ! java -cp $cp scala.tools.nsc.Main -usejavacp Test.scala 2>&1 | grep "unreachable code"

  cd /Users/luc/Downloads/scala-sweble-bug
  sbt "++$sv!" 'set resolvers += "scala-integration" at "https://scala-ci.typesafe.com/artifactory/scala-integration/"' compile
}

if [[ $1 == "run-the-run" ]]; then
  echo "=== TESTING $(current) ==="
  cd "$2"
  run
  res=$?
  case $res in
    0)
      echo "good: $(current)"
      ;;
    125)
      echo "skip: $(current)"
      ;;
    *)
      echo "bad: $(current)"
      ;;
  esac
  echo
  exit $res

elif [[ $# -ne 2 ]]; then
  notice
  die "usage: $0 <good> <bad>"
else
  notice
fi

good=$1
bad=$2

script_path="$(cd "$(dirname "$0")" ; pwd -P)/$(basename "$0")"
current_dir=$(pwd)
cd "$repo_dir"

# git fetch --quiet --all
git bisect start --no-checkout
git bisect good $good
git bisect bad $bad
git bisect run "$script_path" run-the-run "$current_dir"
git bisect log > "bisect_$good-$bad.log"
git bisect reset
