rm -f ~/.musicpaused.flag
/home/pi/.local/bin/esbgm > /dev/null 2>&1 &
mpv ~/RetroPie/splashscreens/PlayBox\ v2\ Intro\ RockPro64.mp4 >/dev/null 2>&1
#/home/pi/scripts/themerandom.sh
emulationstation --no-splash #auto
