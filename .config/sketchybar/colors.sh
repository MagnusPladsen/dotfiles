#!/bin/bash

# Vesper — warm-neutral black with a peach accent, for SketchyBar
# https://github.com/raunofreiberg/vesper
# Previous Tokyo Night bar: dotfiles tag sketchybar-tokyo-night (see ~/README.md)

export BAR_COLOR=0xff000000       # bar background: pure black, same as the notch
export BAR_BORDER=0xff1c1c1c      # hairline around the bar

export FG=0xffffffff              # main text, active workspace apps
export MUTED=0xff8b8b8b           # all right-side status text, glyphs and meters; window title
export OCCUPIED=0xffb5b5b5        # workspaces with windows, date
export FAINT=0xff3d3d3d           # empty workspaces

export SURFACE=0xff121212         # active workspace box
export SURFACE_BORDER=0xff242424  # active workspace box border
export TRACK=0xff1a1a1a           # meter track

export PEACH=0xffffc799           # accent: focused workspace pill, time
export RED=0xffff8080             # high load / low battery

export POPUP_BG=0xf0161616
export POPUP_BORDER=0xff282828
