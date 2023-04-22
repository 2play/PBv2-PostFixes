while pgrep omxplayer >/dev/null; do sleep 1; done
(sleep 5; mpg123 -Z ~/RetroPie/roms/music/*.mp3 >/dev/null 2>&1) &
#/home/pi/scripts/themerandom.sh
emulationstation --no-splash #auto