#!/bin/bash

# My custom additions...
MATCAZ_WRAPPERS="obs-gamecapture mangohud gamemoderun"

# figure out the absolute path to the script being run a bit
# non-obvious, the ${0%/*} pulls the path out of $0, cd's into the
# specified directory, then uses $PWD to figure out where that
# directory lives - and all this in a subshell, so we don't affect
# $PWD

# GMOD: Apparently fixes multimonitor setups with SDL?
export SDL_VIDEO_X11_XRANDR=1

GAMEROOT=$(cd "${0%/*}" && echo $PWD)/bin/linux64
export LD_LIBRARY_PATH="${GAMEROOT}":$LD_LIBRARY_PATH
unset LD_PRELOAD
GAMEEXE=gmod

ulimit -n 2048

# enable nVidia threaded optimizations
export __GL_THREADED_OPTIMIZATIONS=1

# and launch the game
cd "$GAMEROOT"

# Enable path match if we are running with loose files
if [ -f pathmatch.inf ]; then
	export ENABLE_PATHMATCH=1
fi

${MATCAZ_WRAPPERS} "${GAMEROOT}"/${GAMEEXE} "$@"
exit $?
