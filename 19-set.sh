#!/bin/bash

set -e  #setting automatic exit
failure(){
    echo "Failed at: $1:$2"
}

trap 'failure "${LINENO}" "$BASH_COMMAND"' ERR

echo "Hello word!! success"
echooo "Hello worldd failure!!"
echo "Hello world -after failure"

