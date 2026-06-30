#!/bin/bash
# PlayBox Skyscraper BoxArt Wrapper with ES stop/start
# Watch a video demonstrating the artwork compositing features here: https://youtu.be/TIDD8EFSz50
# ReadThis For Extra help on manual scrapes: https://github.com/muldjord/skyscraper/blob/master/docs/ARTWORK.md
# And here https://github.com/muldjord/skyscraper/tree/master?tab=readme-ov-file
# 30.06.2026

function tostop_es() {
    clear
    ensure_lolcat
    echo "[WARN] Please exit EmulationStation manually before you continue with Skyscraper..." | lolcat
 	pausepress
}

function tostart_es() {
    clear
    ensure_lolcat
    echo "[WARN] Please start EmulationStation again or restart your system..." | lolcat
 	pausepress
}


function pausepress() {
    echo
    read -n 1 -s -r -p "Press any key to continue..."
    echo
}


function ensure_lolcat() {
    if ! command -v lolcat >/dev/null 2>&1; then
        sudo gem install lolcat >/dev/null 2>&1
    else
        # Test if lolcat runs without Ruby errors
        if ! echo "test" | lolcat >/dev/null 2>&1; then
            sudo gem install lolcat >/dev/null 2>&1
        fi
    fi
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
    tostop_es
    ~/code/skysource/Skyscraper -a ~/.skyscraper/artwork2P.xml -p "$sname" -s screenscraper --flags unattend,skipped,onlymissing,relative,theinfront,videos
    #~/code/skysource/Skyscraper -a ~/.skyscraper/artwork2P.xml -p "$sname" -s screenscraper -u <USER:PASS> --flags unattend,skipped,onlymissing,relative,theinfront,videos
    #~/code/skysource/Skyscraper -a ~/.skyscraper/artwork2P.xml -p "$sname" --flags unattend,skipped,onlymissing,relative,theinfront,videos
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
    tostart_es
fi
