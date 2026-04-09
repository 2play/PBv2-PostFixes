#!/bin/bash
# PlayBox Skyscraper BoxArt Wrapper with ES stop/start

stop_es() {
    clear
	echo "[Stopping EmulationStation...]"
	sleep 1
	
	# Stop ES
    pkill -f emulationstation
	
    while pgrep -f emulationstation >/dev/null; do
        sleep 2
    done

    # Extra delay to let esbgm service react
    sleep 1
}

start_es() {
    echo "[Starting EmulationStation...]"
    nohup emulationstation --no-splash 2>/dev/null &
    disown
}

# --- Detect ROM directory ---
ROMDIR=""
for d in "$HOME/RetroPie/roms" "$HOME/localroms" "$HOME/addonusb/roms"; do
    if [ -d "$d" ]; then
        ROMDIR="$d"
        break
    fi
done

if [ -z "$ROMDIR" ]; then
    echo "[ERROR] No valid ROMs directory found!"
    exit 1
fi

# --- Main ---
clear
echo "I will display a list of all systems from: $ROMDIR"
echo "Use <space>/<return>/d/q to scroll or exit list."
echo "----------------------------------------------------------------------"
echo "*** PLEASE TYPE THE SYSTEM NAME EXACTLY AS SHOWN ***"
echo "Example: nes   (not Nes or NES)"
echo
read -n 1 -s -r -p "Press any key to continue..."
cd "$ROMDIR" || exit
echo

# Show actual ROM directories in columns
ls -d */ | sed 's#/##' | column | more

echo
read -p 'So which system would you like to Skyscrape?: ' sname
echo

if [ -d "$sname" ]; then
    stop_es
    ~/code/skysource/Skyscraper -a ~/.skyscraper/artwork2P.xml -p "$sname" -s screenscraper --flags unattend,skipped,videos
    ~/code/skysource/Skyscraper -a ~/.skyscraper/artwork2P.xml -p "$sname" --flags unattend,skipped,nobrackets,relative,
	#~/code/skysource/Skyscraper "$@" -a ~/.skyscraper/artwork2P.xml -p "$sname" -s screenscraper --flags unattend,skipped,videos
    #~/code/skysource/Skyscraper "$@" -a ~/.skyscraper/artwork2P.xml -p "$sname" --flags unattend,skipped,nobrackets,relative,videos
    rm -rf ~/.skyscraper/cache/"$sname"

    echo
    while true; do
        read -p 'Would you like to Skyscrape another system [y/n]? ' yn
        case $yn in
            [Yy]*) SkyscrapeBoxart ;;
            [Nn]*) break ;;
            *) echo "Please answer yes or no." ;;
        esac
    done

    cd "$HOME"
    clear
    echo -e "[OK \033[32mDONE\033[0m!...]"
    sleep 1
    start_es
fi
