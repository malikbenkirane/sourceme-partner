#!/bin/zsh
# sourceme
SOURCMEDIR=$HOME/.local/sourceme/

sourceme() {
    source "$SOURCMEDIR$1"
}

for source in \
    gruv.sh \
    screen.sh \
    seoul.sh \
    hamster.sh \
    fixkeys.sh \
    fonts.sh
do sourceme $source
done

