rm -f ~/.musicpaused.flag
#fbset -fb /dev/fb0 -g 1920 1080 1920 1080 16
HDMI2ON=$(grep -c "^connected$" /sys/class/drm/*HDMI*/status | awk -F: '{sum+=$2} END {print sum}')
if [[ $HDMI2ON == "2" ]]; then
    /usr/bin/python3 /opt/retropie/configs/all/PieMarquee2/PieMarquee2.py > /dev/null 2>&1 &
fi
ls -1 ~/RetroPie/splashscreens/* | shuf -n1 | mpv -playlist - >/dev/null 2>&1
#find ~/RetroPie/splashscreens/ -type f | shuf -n1 | xargs -d '\n' ffplay -fs -autoexit -loglevel quiet >/dev/null 2>&1
#mpv ~/RetroPie/splashscreens/filename.mp4 >/dev/null 2>&1
#/home/pi/scripts/themerandom.sh
emulationstation --no-splash #auto