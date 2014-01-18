#!/bin/bash -x

ghApi="https://api.github.com/repos/scala/scala"

function gh_curl(){
  curl -H "Authorization: token $(git config github.token)" -s -o - $@
}

function gh_repos() {
  gh_curl "$ghApi/$1"
}

function gh_pr_milestone_clear() {
  gh_curl -X PATCH -d '{"milestone":null}' "$ghApi/issues/$1"
}

function gh_pr_milestone_set() {
  gh_curl -X PATCH -d '{"milestone":"'$2'"}' "$ghApi/issues/$1"
}

function gh_pull() { 
  gh_repos "pulls/$1"
}

function gh_pr_merged() {
  gh_pull $1 | jq .merged
}

function gh_pr_closed_milestone() {
  gh_repos "issues?milestone=$1&state=closed" | jq '.[].number'
}

function gh_pr_closed_unmerged_milestone() {
  echo "To clear the milestone of unmerged but closed PRs for milestone $1, execute the following:"

  for pr in $(gh_pr_closed_milestone $1); do
    if [ "$(gh_pr_merged $pr)" == "false" ]; then
        echo "gh_pr_milestone_clear $pr"
    fi
  done
}
