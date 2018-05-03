#!/bin/sh

seoul-light() {
    xrdb -override /home/void/hot/seoul256-light
    sed -i "s/^\(set background=\).*/\1light/" $HOME/.grvim
}

seoul-dark() {
    xrdb -override /home/void/hot/seoul256
    sed -i "s/^\(set background=\).*/\1dark/" $HOME/.grvim
}

seoul() {
    sed -i 's/^\(colo \).*/\1seoul256/' $HOME/.grvim
    case $1 in
        light|dark) eval "seoul-$1";;
        *) seoul-light;;
    esac
}
