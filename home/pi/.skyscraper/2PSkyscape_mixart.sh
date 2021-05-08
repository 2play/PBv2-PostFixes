#!/bin/bash
clear
	echo 
	echo " I will display a list of all systems... "
	echo " If you can't see full list. Use below keys to scroll or exit list!"
	echo
	echo "----------------------------------------------------------------------"
	echo " <space>		Display next k lines of text [current screen size]"
	echo " <return>		Display next k lines of text [1]*"
	echo " d			Scroll k lines [current scroll size, initially 11]*"
	echo " q			Exit from more"
	echo "----------------------------------------------------------------------"
	echo
	echo ***PLEASE TYPE THE SYSTEM NAME AS SHOWS***
	echo 
	echo Example: nes
	echo NOT Nes or NES etc...
	echo
	read -n 1 -s -r -p "Press any key to continue..."
	cd ~/RetroPie/roms/
	echo
	ls -d */ | column | more
	echo
	read -p 'So which system would you like to Skyscrape?: ' sname
	echo
	if [ -d $sname ]; then 
	Skyscraper -a artworkMix.xml -p $sname -s screenscraper --flags unattend,skipped,videos;
	Skyscraper -a artworkMix.xml -p $sname --flags unattend,skipped,nobrackets,relative,videos;
	rm -rf ~/.skyscraper/cache/$sname
	clear
	echo
	while true; do
		echo ""
		read -p 'Whould you like to Skyscrape another system [y] or [n]? ' yn
		case $yn in
		[Yy]*) ~/.skyscraper/2Pskyscape.sh;;
		[Nn]*) exit;;
		* ) echo ""; echo "Please answer yes or no.";;
		esac
	done
	cd $HOME
	clear
	echo
	echo "[OK DONE!...]"
	sleep 1
	fi
	