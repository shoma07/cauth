#!/bin/bash
. ./provider_env
script_dir=$(cd $(dirname $0) && pwd)
user=$1
password=$2
csrf_tag=$(curl -s $SITE$SIGNIN_PATH -c $script_dir/cookie | grep csrf-token)
csrf_token=$(echo $csrf_tag | grep -o '[a-zA-Z0-9=/\+]\{88\}')
http_status=$(
  curl -s -X POST $SIGNIN_URL \
          -H "X-CSRF-TOKEN: $csrf_token" \
          -F user[email]=$user \
          -F user[password]=$password \
          -b $script_dir/cookie \
          -c $script_dir/cookie \
          -o /dev/null \
          -w '%{http_code}\n'
)
if [ $http_status = "302" ]; then
  echo "Success"
else
  echo "False"
fi
