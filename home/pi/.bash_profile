# The PlayBox Project
# Copyright (C)2018-2026 2Play! (S.R.)
# 24.06.2026
#clear
echo "
        $(tput setaf 1)__________.__                 $(tput setaf 7)__________
        $(tput setaf 1)\______   \  | _____   ___.__.$(tput setaf 7)\______   \ ________  ___
        $(tput setaf 1) |     ___/  | \__  \ <   |  | $(tput setaf 7)|    |  _//  _  \  \/  /
        $(tput setaf 1) |    |   |  |__/ __ \ \___  | $(tput setaf 7)|    |   (  <_>  >    <
        $(tput setaf 1) |____|   |____(____  )/ ____| $(tput setaf 7)|______  /\_____/__/\_ \ 
        $(tput setaf 1)                    \/ \/      $(tput setaf 7)       \/             \/
                                                      By $(tput setaf 1)2$(tput setaf 7)Play!

$(tput setaf 2)`uname -srmo` - `lsb_release -ds`
$(tput setaf 2)Your $(tput setaf 1)Play$(tput setaf 7)Box $(tput setaf 2)is `uptime -p` since `uptime -s` 😃
User `exec -- last | head -1`
$(tput bold)$(tput setaf 5)
Date & Time     : `date +"%A, %e %B %Y, %r"`
$(tput bold)$(tput setaf 7)
...SYSTEM INFO...$(tput sgr0)$(tput setaf 3)
                          $(tput bold)Size 	Used	Avail 	Used%
Int-SSD/HDD   Partition: `df -h | grep '/dev/sda3' 	 | awk '{print " "$2,"	"$3,"	"$4," 	 "$5}'`
Int-SSD/HDD2  Partition: `df -h | grep '/dev/sda4' 	 | awk '{print " "$2,"	"$3,"	"$4," 	 "$5}'`
Ext-USB       Partition: `df -h | grep '/dev/sda1' 	 | awk '{print " "$2,"	"$3,"	"$4," 	 "$5}'`
SD Boot       Partition: `df -h | grep '/dev/mmcblk[0-9]*p1' | awk '{print " "$2,"	"$3," 	"$4," 	 "$5}'`
SD/USB Root   Partition: `df -h | grep '/dev/root' 	 | awk '{print " "$2,"	"$3,"	"$4," 	 "$5}'`$(tput sgr0)

$(tput bold)$(tput setaf 2)CPU         :`neofetch | grep "CPU" | cut -d ":" -f2`
$(tput bold)$(tput setaf 2)GPU         :`neofetch | grep "GPU" | cut -d ":" -f2`$(tput sgr0)

$(tput bold)$(tput setaf 1)Temperature : `exec -- /home/pi/PlayBox-Setup/.pb-fixes/_scripts/temperature.sh`$(tput sgr0)
$(tput setaf 6)
Memory      : `cat /proc/meminfo | grep MemFree | awk '{printf( "%.2f\n", $2 / 1024 )}'`MB (Free) / `cat /proc/meminfo | grep MemTotal | awk '{printf( "%.2f\n", $2 / 1024 )}'`MB (Total)
LAN & WAN   : `ip route get 8.8.8.8 | awk '{print $7}'` / `curl -s https://api.ipify.org`
$(tput setaf 7)$(tput sgr0)"

# Detect location via IP
city=$(curl -s --max-time 2 https://ipinfo.io | jq -r '.city')
country=$(curl -s --max-time 2 https://ipinfo.io | jq -r '.country')
location="$city, $country"
#echo "[.] Detected location: $location"

# Fallback if city/country empty
if [[ -z "$city" ]]; then
    location=$(curl -s --max-time 2 wttr.in/?format="%l" | sed 's/, ,/,/g' | sed 's/, $//' 2>/dev/null)
fi

# Try AccuWeather RSS feed
weather=$(curl -s --max-time 2 "http://rss.accuweather.com/rss/liveweather_rss.asp?metric=1&locCode=$city" \
    | sed -n '/Currently:/ s/.*: \(.*\): \([0-9]*\)\([CF]\).*/\2°\3, \1/p')

# Fallback to wttr.in if empty
if [[ -z "$weather" ]]; then
    weather=$(curl -s --max-time 2 "wttr.in/$city?format=%C+%t")
fi

# Extract numeric temperature
temp=$(echo "$weather" | grep -oE '[+-]?[0-9]+' | head -1)

# Default color + emoji
color=$(tput sgr0)
emoji="🌡️"

if [[ $TERM == "linux" ]]; then
    cold="❄︎"; mild="~"; warm=">O<"; hot="H"
else
    cold="🧊"; mild="🍃"; warm="🔆"; hot="🔥"
fi

if [[ -n "$temp" ]]; then
    if (( temp <= 5 )); then
        color=$(tput setaf 4); emoji=$cold
    elif (( temp <= 20 )); then
        color=$(tput setaf 2); emoji=$mild
    elif (( temp <= 30 )); then
        color=$(tput setaf 3); emoji=$warm
    else
        color=$(tput setaf 1); emoji=$hot
    fi
fi

echo "...WEATHER INFO..."
echo "${color}- $location : $emoji $weather$(tput sgr0)"
echo
source ~/.bashrc