#!/bin/bash

BACKED_UP=false
checkedLog() {
    /usr/bin/printf "\xE2\x9C\x94 $1\n"
}

log() {
   echo $'\u2712' $1
}

if [ "$1" == "--restore" ]; then
    mv -rf test/rules test/rules-back
    rm -rf test/rules
    checkedLog "Moved existing rules to back-up..."
    mv test/rules-back test/rules
    checkedLog "Moved back-up to source..."
else
    if [ ! -d "test/rules-back" ]; then
        mv test/rules test/rules-back
        checkedLog "Created back-up..."
        BACKED_UP=true
    fi

    if [ $BACKED_UP ]; then
        if [ ! -d "test/rules-back/$1" ]; then
            mv test/rules-back/$1 test/rules
            checkedLog "Running rule $1 only..."
        else
            log "Already processed $1..."
        fi
    else
        mkdir test/rules
        if [ ! -d "test/rules-back/$1" ]; then
            mv test/rules-back/$1 test/rules
            checkedLog "Running rule $1 only..."
        else
            log "Already processed $1..."
        fi
    fi
fi
