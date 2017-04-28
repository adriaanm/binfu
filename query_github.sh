#https://gist.github.com/adriaanm/4760366

export TOKEN=444ae24520d91d88141a6688e1064ad3b97ea69d

# brew install jq
# enter your github password to get a token (see output)
# curl https://api.github.com/authorizations --user "$GITHUB_USERNAME" --data '{"scopes":["public_repo"],"note":"cli"}'

closed_prs=$(git log --decorate=no v2.10.1..f81a4f9296 --merges --oneline | grep "Merge pull request" | cut -f 5 -d' ' | sort -u | uniq | perl -pe 's/#//')

# # fork
# for PRNUM in $closed_prs
# do
#   curl -H "Authorization: token $TOKEN" -s -o - https://api.github.com/repos/scala/scala/pulls/$PRNUM &
# done
# 
# read

# twiddle fingers -- how to join programmatically?
for PRNUM in $closed_prs; do cat /tmp/$PRNUM.json | jq '.[] | "\(.number) \(.merged_at)   \(.user.login)           \(.title)"'; done | sort

# contributor stats
for PRNUM in $closed_prs; do cat /tmp/$PRNUM.json | jq '.user.login'; done | sort | uniq -c | sort -u | tail -r | perl -pe 's/"//g'