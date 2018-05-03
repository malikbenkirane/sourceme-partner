# font utilities
# --------------

font_defaults() {
    local defaults
    local fontname
    local fontsize
    if defaults=$(command xrdb -query | grep st.font); then
        fontname=$(echo $defaults | cut -d':' -f2 | sed 's/^\s\+//')
        echo $fontname
        if echo $defaults | grep size > /dev/null; then
            fontsize=$(echo $defaults | sed 's/.*=//')
            echo $fontsize
        fi
    fi
    if [ "$fontname" ]; then
        fontname=$(echo $fontname|sed 's/ /\\ /')
        if [ "$fontsize" ]; then
            fontsize="\\ $fontsize"
        fi
        echo "let gtkfonts='$fontname$fontsize'" > $HOME/.fovim
    fi
}


# font name utility
fn() {
    local arg=$@
    if [ "$arg" ]; then
        local fdefaults=$(font_defaults)
        local fs
        if [ $(echo $fdefaults | wc -l) -eq 2 ]; then
            fs=":$(echo $fdefaults | (read line; read line; echo size=$line))"
        fi
        echo "st.font: $@$fs" | xrdb -override
        return
    else
        font_defaults | head -n 1
    fi
    return 1
}

# is_numeric helper
is_numeric() {
    echo $1 | grep "^[0-9][0-9]\?"
    return $?
}

# font size utility
font_default_size() {
    local fs
    if [ $(font_defaults | wc -l) -gt 1 ]; then
        fs=$(font_defaults | tail -n 1)
    # FIXME MAYBE this is never the case.  There could not be font
    # size echoed alone by `font_defaults` because there is always
    # at least font name printed by xrdb API.
    elif font_defaults | is_numeric; then
        fs=$(font_defaults)
    else
        return 1
    fi
    echo $fs
    return
}

fs() {
    if [ "$2" ]; then
        font_default_size
        # echo " > Give one argument only (font size)"
        return
    elif echo $1 | grep -v "^[0-9][0-9]\?" > /dev/null; then
        font_default_size
        # echo "> Give only font size"
        return 
    fi
    local arg=$@
    if [ "$arg" ]; then
        local fdefaults=$(font_defaults)
        local fn
        if [ $(echo $fdefaults | wc -l) -gt 0 ]; then
            fn="$(echo $fdefaults | (read line; echo $line))"
        fi
        echo "st.font: ${fn}:size=$1" | xrdb -override
        return 0
    fi
    return 1
}
