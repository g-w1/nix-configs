#!/bin/env bash

export JAVA_AWT_WM_NONREPARENTING=1

xset r rate 300 50 &
exec bspwm
