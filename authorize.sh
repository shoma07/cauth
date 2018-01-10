#!/bin/sh
. ./provider_env
script_dir=$(cd $(dirname $0) && pwd)
csrf_tag=$(curl -s -X GET $NEW_AUTHORIZE_URL -b $script_dir/cookie -c $script_dir/cookie | grep csrf-token)
csrf_token=$(echo $csrf_tag | grep -o '[a-zA-Z0-9=/\+]\{88\}')
authorization_html=$(
  curl -s -X POST $AUTHORIZE_URL \
       -H "X-CSRF-TOKEN: $csrf_token" \
       -F response_type=$RESPONSE_TYPE \
       -F client_id=$CLIENT_ID \
       -F redirect_uri=$REDIRECT_URI \
       -b $script_dir/cookie \
       -c $script_dir/cookie
)
authorization_code=$(echo $authorization_html | grep -o '[a-z0-9]\{64\}')
echo $authorization_code
exit 0
