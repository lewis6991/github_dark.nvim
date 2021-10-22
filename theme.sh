#! /usr/bin/env bash

black='0d/11/17'
# black_bright='16/1b/22'
# black_bright='21/26/2d'
black_bright='30/36/3d'
white='b1/ba/c4'
white_bright='c9/d1/d9'
red='ff/7b/72'
red_bright='ff/a1/98'
green='3f/b9/50'
green_bright='56/d3/64'
yellow='d2/99/22'
yellow_bright='e3/b3/41'
blue='58/a6/ff'
blue_bright='79/c0/ff'
magenta='bc/8c/ff'
magenta_bright='d2/a8/ff'
cyan='76/e3/ea'
cyan_bright='b3/f0/ff'

color_foreground=$white
color_background=$black

if [ -n "$TMUX" ]; then
    # Tell tmux to pass the escape sequences through
    # (Source: http://permalink.gmane.org/gmane.comp.terminal-emulators.tmux.user/1324)
    put_template()        { printf '\033Ptmux;\033\033]4;%d;rgb:%s\033\033\\\033\\' "$1" "$2"; }
    put_template_var()    { printf '\033Ptmux;\033\033]%d;rgb:%s\033\033\\\033\\'   "$1" "$2"; }
    put_template_custom() { printf '\033Ptmux;\033\033]%s\033\033\\\033\\'          "$1" "$2"; }
elif [ "${TERM%%[-.]*}" = "screen" ]; then
    # GNU screen (screen, screen-256color, screen-256color-bce)
    put_template()        { printf '\033P\033]4;%d;rgb:%s\007\033\\' "$1" "$2"; }
    put_template_var()    { printf '\033P\033]%d;rgb:%s\007\033\\'   "$1" "$2"; }
    put_template_custom() { printf '\033P\033]%s\007\033\\'          "$1" "$2"; }
elif [ "${TERM%%-*}" = "linux" ]; then
    put_template()        { [ "$1" -lt 16 ] && printf "\e]P%x%s" "$1" "$(echo "$2" | sed 's/\///g')"; }
    put_template_var()    { true; }
    put_template_custom() { true; }
else
    put_template()        { printf '\033]4;%d;rgb:%s\033\\' "$1" "$2"; }
    put_template_var()    { printf '\033]%d;rgb:%s\033\\'   "$1" "$2"; }
    put_template_custom() { printf '\033]%s\033\\'          "$1" "$2"; }
fi

# 16 color space
put_template 0  $black
put_template 1  $red
put_template 2  $green
put_template 3  $yellow
put_template 4  $blue
put_template 5  $magenta
put_template 6  $cyan
put_template 7  $white
put_template 8  $black_bright
put_template 9  $red_bright
put_template 10 $green_bright
put_template 11 $yellow_bright
put_template 12 $blue_bright
put_template 13 $magenta_bright
put_template 14 $cyan_bright
put_template 15 $white_bright

# foreground / background / cursor color
if [ -n "$ITERM_SESSION_ID" ]; then
    blackp=${black//\/}
    black_brightp=${black_bright//\/}
    whitep=${white//\/}

    # iTerm2 proprietary escape codes
    put_template_custom "1337;SetColors=fg=$whitep"
    put_template_custom "1337;SetColors=bg=$blackp"
    put_template_custom "1337;SetColors=bold=$whitep"
    put_template_custom "1337;SetColors=selbg=$black_brightp"
    put_template_custom "1337;SetColors=selfg=$whitep"
    put_template_custom "1337;SetColors=curbg=$whitep"
    put_template_custom "1337;SetColors=curfg=$blackp"

    put_template_custom "6;1;bg;red;brightness;$((16#${blackp:0:2}))"
    put_template_custom "6;1;bg;green;brightness;$((16#${blackp:2:2}))"
    put_template_custom "6;1;bg;blue;brightness;$((16#${blackp:4:2}))"
else
    put_template_var 10 $color_foreground
    put_template_var 11 $color_background
    if [ "${TERM%%-*}" = "rxvt" ]; then
        put_template_var 708 $color_background # internal border (rxvt)
    fi
    put_template_custom 12 ";7" # cursor (reverse video)
fi
