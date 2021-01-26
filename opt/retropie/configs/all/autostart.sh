#fbset -fb /dev/fb0 -g 1920 1080 1920 1080 16
HDMI2ON=`tvservice -l |grep "HDMI" |wc -l`
if [[ $HDMI2ON == "2" ]]; then
/usr/bin/python /opt/retropie/configs/all/PieMarquee2/PieMarquee2.py > /dev/null 2>&1 &
fi
#/home/pi/scripts/themerandom.sh
emulationstation --no-splash #auto
