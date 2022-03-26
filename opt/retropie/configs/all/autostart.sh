#REGEX_VIDEO="\.avi\|\.mov\|\.mp4\|\.mkv\|\.3gp\|\.mpg\|\.mp3\|\.wav\|\.m4a\|\.aac\|\.ogg\|\.flac"
#REGEX_AUDIO="\.mp3\|\.wav\|\.m4a\|\.aac\|\.ogg\|\.flac"
#local rv="$REGEX_VIDEO" >/dev/null 2>&1 && local ra="$REGEX_AUDIO" >/dev/null 2>&1
#mpv --shuffle ~/RetroPie/splashscreens/*"$rv" >/dev/null 2>&1
mpv ~/RetroPie/splashscreens/PlayBox\ v2\ Tinker\ Intro.mp4 >/dev/null 2>&1; sleep 1; mpv --really-quiet --no-video --shuffle ~/RetroPie/roms/music/*.* >/dev/null 2>&1 &
#/home/pi/scripts/themerandom.sh
emulationstation --no-spalsh #auto
