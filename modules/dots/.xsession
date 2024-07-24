#!/usr/bin/env bash

xrandr --output DP-4 --primary --mode 2560x1440 --rate 144 --output HDMI-0 --mode 1920x1080 --rate 144 --rotate right --right-of DP-4 --output eDP-1-1 --off

xset r rate 170 90

