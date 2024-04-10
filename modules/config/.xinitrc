exec i3
setxkbmap -option 'caps:ctrl_modifier'
xcape -e 'Caps_Lock=Escape'
setxkbmap -option 'caps:ctrl_modifier'
xcape -e 'Caps_Lock=Escape;Control_L=Escape;Control_R=Escape'

xrandr --output HDMI-0 --primary --mode 2560x1440 --rate 144 --output eDP-1-1 --off
