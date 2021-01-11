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

# start some nice programs
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# Fonts and stuff
xset +fp /home/icnh/.fonts
xset fp rehash


### CUSTOM
# Export path to GTK2 config file
export GTK2_RC_FILES=~/.config/gtk-2.0/gtkrc-2.0

# Be easier on the eyes
exec redshift &

# feh for wallpaper + picom as compositer
exec feh --no-fehbg --bg-scale $XDG_CONFIG_HOME/i3/wallpaper.png &
exec picom --config $XDG_CONFIG_HOME/picom.conf &

# Finally, execute the graphical environment
exec i3