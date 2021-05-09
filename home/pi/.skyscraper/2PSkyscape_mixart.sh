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
	#ls -d */ | column | more
	echo -e 'Available platforms v3.6.11:\n* 3do\n* 3ds\n* amiga\n* amigacd32\n* amstradcpc\n* apple2\n* arcade\n* arcadia\n* astrocde\n* atari800\n* atari2600\n* atari5200\n* atari7800\n* atarijaguar\n* atarijaguarcd\n* atarilynx\n* atarist\n* atomiswave\n* c16\n* c64\n* c128\n* channelf\n* coco\n* coleco\n* daphne\n* dragon32\n* dreamcast\n* fba\n* fds\n* gameandwatch\n* gamegear\n* gb\n* gba\n* gbc\n* gc\n* genesis\n* intellivision\n* mame-advmame\n* mame-libretro\n* mame-mame4all\n* mastersystem\n* megacd\n* megadrive\n* msx\n* msx2\n* n64\n* naomi\n* nds\n* neogeo\n* neogeocd\n* nes\n* ngp\n* ngpc\n* openbor\n* oric\n* pc\n* pc88\n* pc98\n* pcfx\n* pcengine\n* pcenginecd\n* pokemini\n* ports\n* ps2\n* psp\n* psx\n* saturn\n* scummvm\n* sega32x\n* segacd\n* sg-1000\n* snes\n* steam\n* ti99\n* trs-80\n* vectrex\n* vic20\n* videopac\n* virtualboy\n* wii\n* wiiu\n* wonderswan\n* wonderswancolor\n* x68000\n* x1\n* zmachine\n* zx81\n* zxspectrum\n' | column | more
	echo
	read -p 'So which system would you like to Skyscrape?: ' sname
	echo
	if [ -d $sname ]; then 
	Skyscraper -a artworkMix.xml -p $sname -s screenscraper --flags unattend,skipped,videos;
	Skyscraper -a artworkMix.xml -p $sname --flags unattend,skipped,nobrackets,relative,videos;
	rm -rf ~/.skyscraper/cache/$sname
	#clear
	echo
	while true; do
		echo ""
		read -p 'Whould you like to Skyscrape another system [y] or [n]? ' yn
		case $yn in
		[Yy]*) ~/.skyscraper/2PSkyscape_mixart.sh;;
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
	