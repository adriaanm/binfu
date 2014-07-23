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

function st_stagingRepoPromoteCommands() {
  echo "To promote all staging repositories, run the following commands:"
  allRepoIds=$(st_stagingRepoList | jq '.repositoryId' | tr -d \")
  for repoId in $allRepoIds; do echo "st_stagingRepoPromote $repoId"; done
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
