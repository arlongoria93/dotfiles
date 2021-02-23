#!/bin/bash

xmodmap ~/.xmodmaprc &
xrdb -load ~/.Xresources &
xsetroot -cursor_name Left_ptr

# wallpaper, notification, tranparency
setbg &
dunst &
# picom &

# window manager
exec xmonad
