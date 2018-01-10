#!/bin/sh
. ./provider_env
script_dir=$(cd $(dirname $0) && pwd)
authorization_code=$1
echo $authorization_code
curl -X POST $TOKEN_URL \
     -F grant_type=$GRANT_TYPE \
     -F client_id=$CLIENT_ID \
     -F client_secret=$CLIENT_SECRET \
     -F code=$authorization_code \
     -F redirect_uri=$REDIRECT_URI \
     -b $SCRIPT_DIR/cookie \
     -c $SCRIPT_DIR/cookie
