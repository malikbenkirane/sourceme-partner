#!/bin/sh
fixkeys() {
    setxkbmap us -option ctrl:nocaps -option shift:both_capslock
}

if [ -n "$DISPLAY" ]; then
    fixkeys
fi
