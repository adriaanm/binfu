stApi="https://oss.sonatype.org/service/local/"

function st_curl(){
  curl -H "accept: application/json" --user $SONA_USER_TOKEN -s -o - $@
}

function SONA_USER_TOKEN() {
 st_curl "$stApi/staging/profile_repositories" | jq '.data[] | select(.profileName == "org.scala-lang") | .repositoryURI'
}

