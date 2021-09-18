#!/usr/bin/env bash

wmname LG3D

xset r rate 300 50 &

setxkbmap -variant colemak
setxkbmap -variant colemak
xsetroot -cursor_name left_ptr



export JAVA_AWT_WM_NONREPARENTING=1
export AWT_TOOLKIT=MToolkit
if [[ -z "${NOT_USE_SHOD}" ]]; then
    case $(hostname) in
        dell)
            if [ $(xrandr --query | grep " connected" | cut -d" " -f1 | grep HDMI) ]; then
              xrandr --output HDMI-1 --right-of DP-3
            fi
            ;;
        *)
            ;;
    esac
	sxhkd -c ~/.config/sxhkd/shodsxhkdrc&
	exec ~/dev/shod2/shod
else
  exec bspwm
fi
