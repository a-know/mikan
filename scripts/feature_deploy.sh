#!/bin/bash -e

HEROKU_APPS="mikanz-stg"

DEPLOY_SCRIPT=/tmp/deploy.$$.sh
curl https://s3-ap-northeast-1.amazonaws.com/shitemil.com/scripts/heroku_production_deploy.sh.txt > ${DEPLOY_SCRIPT}
. ${DEPLOY_SCRIPT}

deploy
