#!/usr/bin/env bash

function banner() {
    local text="${@}"
    local line='---------------------------------------------------------'
    echo "[- `tput bold`$text`tput sgr0` ${line:0:-${#text}}]"
}


function progress_bar() {
    local text=${1:-""}
    local max=${2:-60}
    local delay=${3:-1}
    local todo=${4:-"."}
    local done=${5:-"-"}
    local i

    if [ -n "${text}" ]; then
        banner "$text"
    fi;
    echo -en "["
    for i in `seq 1 $max`
    do
        echo -en "$todo"
    done
    echo -en "]\0015["
    for i in `seq 1 $max`
    do
        echo -en "$done"
        sleep ${delay}
    done
    echo
}
