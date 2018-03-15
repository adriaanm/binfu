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
  ver=$1  # version of scala-library
  from=$2 # YYYMM
  months=$3 # number of months
  type=${4-raw} # raw or ip
  st_curl "$stApi/stats/timeline?p=1d58bfc29fa3c&g=org.scala-lang&a=scala-library&v=$ver&t=$type&from=$from&nom=$months" | jq -r '"\(.data.version)\t\(.data.timeline | map(tostring) | join("\t"))"'
}

function st_stats_ip() {
  st_curl "$stApi/stats/timeline?p=1d58bfc29fa3c&g=org.scala-lang&a=scala-library&v=$1&t=ip&from=$2&nom=$3" | jq -r '"\(.data.version)\t\(.data.timeline | map(tostring) | join("\t"))"'
}

# for i in 0 1 2 3 4 5 6; do st_stats_ip 2.10.$i 201701 9; done
# for i in 0 1 2 3 4 5 6 7 8 9 10 11; do st_stats_ip 2.11.$i 201701 9 ; done
# for i in 0 1 2 3; do st_stats_ip 2.12.$i 201701 9; done
