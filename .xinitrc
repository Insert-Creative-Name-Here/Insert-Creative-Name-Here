#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps
if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi


### CUSTOM
# Disable keyboard repeat rate; that is, if you hold down a key, it won't be
# counted multiple times
xset r off

# Swap escape and caps keys
setxkbmap -option caps:swapescape

# Be easier on the eyes
exec redshift -t 4200:2000 -g 0.8 -m randr &

# feh for wallpaper + picom as compositer
WALLPAPER="${XDG_CONFIG_HOME}/i3/wallpaper.png"
exec feh --no-fehbg --bg-scale ${WALLPAPER} &
exec picom --config ${XDG_CONFIG_HOME}/picom.conf &

# Execute a custom script that reminds you to get up and exercise
[[ -f "$HOME/bin/takeabreak" ]] && exec "$HOME/bin/takeabreak" &

# Start notification manager
exec dunst &

# Finally, execute the graphical environment
exec i3
