#!/bin/bash

function repos() {
  curl -H "Authorization: token $(git config github.token)" -s -o - https://api.github.com/repos/scala/scala/$1
}

function gh_pull() { 
  repos "pulls/$1"
}

function gh_pr_merged() {
  gh_pull $1 | jq .merged
}

function gh_pr_closed_milestone() {
  repos "issues?milestone=$1&state=closed" | jq '.[].number'
}

function gh_pr_closed_unmerged_milestone() {
  for pr in $(gh_pr_closed_milestone $1); do
    if [ "$(gh_pr_merged $pr)" == "false" ]; then
        echo "#$pr"
    fi
  done
}