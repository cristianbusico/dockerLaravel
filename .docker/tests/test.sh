#!/bin/bash

set -e
set -v

node ./.docker/tests/check-database.js

cd /home/node/app/test

npx jest -i

