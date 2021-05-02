#!/bin/env bash

wmname LG3D

xset r rate 300 50 &


export JAVA_AWT_WM_NONREPARENTING=1
export AWT_TOOLKIT=MToolkit
exec bspwm
