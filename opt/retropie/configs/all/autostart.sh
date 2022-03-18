REGEX_VIDEO="\.avi\|\.mov\|\.mp4\|\.mkv\|\.3gp\|\.mpg\|\.mp3\|\.wav\|\.m4a\|\.aac\|\.ogg\|\.flac"
REGEX_AUDIO="\.mp3\|\.wav\|\.m4a\|\.aac\|\.ogg\|\.flac"

local rv="$REGEX_VIDEO" >/dev/null 2>&1 &
local ra="$REGEX_AUDIO" >/dev/null 2>&1 &

mpv --vo=drm ~/RetroPie/splashscreens/PlayBox\ v2\ Intro.mp4 >/dev/null 2>&1 &
#mpv ~/RetroPie/splashscreens/PlayBox\ v2\ Intro.mp4 >/dev/null 2>&1 &
#mpv --vo=drm ~/RetroPie/splashscreens/*"$rv" >/dev/null 2>&1 &
sleep 1; mpv --no-video --loop --shuffle ~/RetroPie/roms/music/*"$ra" >/dev/null 2>&1 &
#mpv --vo=drm --no-video https://www.youtube.com/watch?v=djV11Xbc914&list=PLmXxqSJJq-yXrCPGIT2gn8b34JjOrl4Xf
emulationstation --no-splash #auto