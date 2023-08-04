rm -f ~/.musicpaused.flag
/home/pi/.local/bin/esbgm > /dev/null 2>&1 &
ls -1 ~/RetroPie/splashscreens/* | shuf -n1 | mpv -playlist - >/dev/null 2>&1
#mpv ~/RetroPie/splashscreens/PlayBox\ v2\ Tinker\ Intro.mp4 >/dev/null 2>&1
#/home/pi/scripts/themerandom.sh
emulationstation --no-splash #auto
