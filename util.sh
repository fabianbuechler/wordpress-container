#!/usr/bin/env bash

function banner() {
    local text="${@}"
    local line='-------------------------------------------------------------'
    echo "> `tput bold`$text`tput sgr0` ${line:0:-${#text}}"
}

function progress_bar() {
    local TIMEOUT=${1:-60}
    local DELAY=${2:-1}
    local CHAR_FILLED="-"
    local CHAR_EMPTY=" "
    shift 2
    local COMMAND=$@
    local i
    echo -en "  ["
    for i in `seq 1 $TIMEOUT`
    do
        echo -en "$CHAR_EMPTY"
    done
    echo -en "]\0015  ["
    for i in `seq 1 $TIMEOUT`
    do
        eval ${COMMAND} && break
        echo -en "$CHAR_FILLED"
        sleep ${DELAY}
    done
    echo "✓"
}
