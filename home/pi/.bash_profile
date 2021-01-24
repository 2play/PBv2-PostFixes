source ~/.bashrc
let upSeconds="$(/usr/bin/cut -d. -f1 /proc/uptime)"
let secs=$((${upSeconds}%60))
let mins=$((${upSeconds}/60%60))
let hours=$((${upSeconds}/3600%24))
let days=$((${upSeconds}/86400))
UPTIME=`printf "%d days, %02dh%02dm%02ds" "$days" "$hours" "$mins" "$secs"`

echo "
        $(tput setaf 1)__________.__                 $(tput setaf 7)__________
        $(tput setaf 1)\______   \  | _____   ___.__.$(tput setaf 7)\______   \ ________  ___
        $(tput setaf 1) |     ___/  | \__  \ <   |  | $(tput setaf 7)|    |  _//  _  \  \/  /
        $(tput setaf 1) |    |   |  |__/ __ \ \___  | $(tput setaf 7)|    |   (  <_>  >    <
        $(tput setaf 1) |____|   |____(____  )/ ____| $(tput setaf 7)|______  /\_____/__/\_ \ 
        $(tput setaf 1)                    \/ \/      $(tput setaf 7)       \/             \/
                                                      By $(tput setaf 1)2$(tput setaf 7)Play!
		$(tput setaf 2)
`uname -srmo` - `lsb_release -ds`

`date +"%A, %e %B %Y, %r"`
Uptime    : ${UPTIME}
Last Login: `exec -- last | head -1`
$(tput setaf 7)
...SYSTEM INFO...$(tput setaf 3)
                            Size 	Used	Avail 	Used%
SD Boot         Partition: `df -h | grep '/dev/mmcblk0p1' | awk '{print " "$2,"	"$3," 	"$4," 	 "$5}'`
SD/USB Root     Partition: `df -h | grep '/dev/root' 	 | awk '{print " "$2,"	"$3,"	"$4," 	 "$5}'`
Ext-USB/USBBoot Partition: `df -h | grep '/dev/sda1' 	 | awk '{print " "$2,"	"$3,"	"$4," 	 "$5}'`
$(tput setaf 1)
$(tput setaf 7)`grep Model /proc/cpuinfo`

$(tput setaf 1)SoC Temperature : `exec -- /home/pi/PlayBox-Setup/.pb-fixes/_scripts/temperature.sh`
CPU `grep Hardware /proc/cpuinfo` - `lscpu | grep "Model name"`
CPU Max Speed   : `lscpu | grep max`
GPU Version     : `exec -- /opt/vc/bin/vcgencmd version`
$(tput setaf 6)
Memory          : `cat /proc/meminfo | grep MemFree | awk '{printf( "%.2f\n", $2 / 1024 )}'`MB (Free) / `cat /proc/meminfo | grep MemTotal | awk '{printf( "%.2f\n", $2 / 1024 )}'`MB (Total)
Local IP        : `hostname -I`
$(tput setaf 7)"
