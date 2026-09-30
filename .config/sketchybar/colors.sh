#!/bin/bash

# Vesper — warm-neutral black with peach and mint, for SketchyBar
# https://github.com/raunofreiberg/vesper
# Other themes: ~/.config/sketchybar.prompt/, ~/.config/sketchybar.tokyo-night/

export BAR_COLOR=0xff000000       # bar background: pure black, same as the notch
export BAR_BORDER=0xff1c1c1c      # hairline around the bar

export FG=0xffffffff              # main text, active workspace apps
export MUTED=0xff8b8b8b           # labels (cpu, mem, battery icon)
export OCCUPIED=0xffb5b5b5        # workspaces with windows
export FAINT=0xff3d3d3d           # empty workspaces

export SURFACE=0xff121212         # active workspace box
export SURFACE_BORDER=0xff242424  # active workspace box border
export TRACK=0xff1a1a1a           # meter track

export PEACH=0xffffc799           # accent: active number, clock, mem meter
export MINT=0xff99ffe4            # second accent: cpu meter, charging
export RED=0xffff8080             # high load / low battery

export POPUP_BG=0xf0161616
export POPUP_BORDER=0xff282828
