#!/bin/sh
set -e
set -x

cd /e2e

#con electron fallisce qualche test per via di un posizionamento non esatto di alcune componenti
npx cypress run --browser chrome
