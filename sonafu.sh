#!/bin/bash -e

# requires ~/.sonatype-curl that contains a line 'user = USER:PASS'
stApi="https://oss.sonatype.org/service/local"

function st_curl(){
  # -D - -v
  curl -H "Content-Type: application/json" -H "accept: application/json,application/vnd.siesta-error-v1+json,application/vnd.siesta-validation-errors-v1+json"  -K ~/.sonatype-curl -s -o - $@
}

function st_stagingRepoList() {
 st_curl "$stApi/staging/profile_repositories" | jq '.data[] | select(.profileName == "org.scala-lang")'
}

function st_stagingRepoURLs() {
  st_stagingRepoList | jq '.repositoryURI'
}

function st_stagingRepoDrop() {
  repo=$1
  message=$2
  echo "{\"data\":{\"description\":\"$message\",\"stagedRepositoryIds\":[\"$repo\"]}}" | st_curl -X POST -d @- "$stApi/staging/bulk/drop"
}

function st_stagingRepoClose() {
  repo=$1
  message=$2
  echo "{\"data\":{\"description\":\"$message\",\"stagedRepositoryIds\":[\"$repo\"]}}" | st_curl -X POST -d @- "$stApi/staging/bulk/close"
}

function st_stagingRepoPromote() {
  repo=$1
  message=$2
  echo "{\"data\":{\"description\":\"$message\",\"stagedRepositoryIds\":[\"$repo\"]}}" | st_curl -X POST -d @- "$stApi/staging/bulk/promote"
}


function st_stats() {
  st_curl "$stApi/stats/timeline?p=1d58bfc29fa3c&g=org.scala-lang&a=scala-library&v=$1&t=raw&from=$2&nom=$3" | jq -r '"\(.data.version)\t\(.data.timeline | map(tostring) | join("\t"))"'
}

# for i in 0 1 2 3 4 5 6 7; do st_stats 2.11.$i 201401 25 ; done
# for i in 0 1 2 3 4 5 6; do st_stats 2.10.$i 201201 24; done
# for i in 0 1 2 3 4; do st_stats 2.9.$i 201201 24; done