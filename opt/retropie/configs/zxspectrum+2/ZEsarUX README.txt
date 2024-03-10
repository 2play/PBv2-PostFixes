ZEsarUX - ZX Second-Emulator And Released for UniX 

Created by Cesar Hernandez Bano

https://github.com/chernandezba/zesarux


It's a ZX Machines Emulator for UNIX based operating systems (and Windows), including all the Sinclair computers:

* MK14
* ZX80
* ZX81
* ZX Spectrum
* QL
* Z88

And also:

* Timex TS 2068
* Sam Coupe
* Pentagon 
* Chloe 140 SE, 280 SE
* Chrome
* Prism
* ZX-Uno
* ZX-Evolution BaseConf
* ZX-Evolution TS-Conf
* TBBlue/ZX Spectrum Next
* Jupiter Ace
* Amstrad CPC 464, CPC 4128
* MSX1 
* Spectravideo 318/328
* Colecovision
* Sega SG1000

ZEsarUX source code and binaries are distributed under GNU GPL license. 
ZEsarUX also includes a folder, "my_soft", which has some programs and data made by me. The entire folder is also covered by the GNU GPL license.

ZEsarUX also includes third-party roms, media, programs and games NOT covered by this license.

This is my second ZX Spectrum emulator after ZXSpectr
https://github.com/chernandezba/zxspectr

I recommend you to read FEATURES, INSTALL and HISTORY files, as well as other documents in this emulator.
You can open them from the help menu or from an external viewer.


ZEsarUX distributed under GNU GENERAL PUBLIC LICENSE v3. You may read it on the LICENSE file.

Please read the other licenses used in ZEsarUX, from the menu Help->Licenses or just open files from folder licenses/


Available versions for download here:
* Source code
* Binary compiled versions:
* GNU/Linux 32/64 Bits
* FreeBSD 64 Bits
* Mac OS X
* Windows
* Raspberry pi (raspbian)

Other by 3rd party:
* Arch Linux
* Slackware
* Retropie/EmulationStation
* Open Pandora
* PocketCHIP
* MorhpOS


ZEsarUX has won the "Best Emulator" award from Retrogaming Total blog on 2015 and 2017




__DONATE__

ZEsarUX is free software and you don't need to pay to use it. 
ZEsarUX will always cost you nothing to use, but that doesn't mean it costs me nothing to make.
So if you want to demonstrate your appreciation to it, you can donate using Paypal. Just click:

[ZEsarUX donation](https://www.paypal.com/cgi-bin/webscr?cmd=_donations&business=E5RSRST8N7KWS&lc=ES&item_name=Donativo%20ZEsarUX&currency_code=EUR&bn=PP%2dDonationsBF%3abtn_donateCC_LG%2egif%3aNonHosted)


All donors will appear in the acknowledgements file

Thanks!


__FEATURES__

* Runs on any Unix system and Windows: tested on GNU/Linux x86, GNU/Linux x86_64, GNU/Linux Raspbian, GNU/Linux RetroPie, FreeBSD x86_64, Haiku, Mac OS X, Windows native, Windows + Cygwin

* Emulates:
* Science of Cambridge MK14
* Sinclair ZX80
* Sinclair ZX81
* Spectrum models: 16k, 48k (English and Spanish), Inves Spectrum +, Spectrum 128k (English and Spanish), Spectrum +2 (English, Spanish and French), Spectrum +2A (English and Spanish), Spectrum +3 (English and Spanish), Microdigital TK90X (Portuguese and Spanish), TK95 
* Sinclair QL
* Cambridge Z88
* Timex TS 2068 
* Sam Coupe
* Pentagon 
* Chloe 140 SE, 280 SE
* Chrome
* Prism
* ZX-Uno
* ZX-Evolution BaseConf (beta)
* ZX-Evolution TS-Conf
* TBBlue/ZX Spectrum Next
* Jupiter Ace
* Amstrad CPC 464, CPC 4128
* MSX1 
* Spectravideo 318/328
* Colecovision
* Sega SG1000

* Is the only emulator for machines: Chloe 140/280, Prism and Chrome

* Almost perfect emulation of timing of all Spectrum machines

* Supports undocumented Z80 flags, features, and MEMPTR register

* Supports idle bus port, contended memory, ULA early/late timings

* Supports Motorola CPU 68008 (Sinclair QL)

* Supports SC/MP CPU - INS8060 (MK14)

* Supports perfect ZX Spectrum 16k/48k colour palette

* Supports ULAplus: Standard 64 colour palette, linear modes with 16 colours per pixel: Radastan Mode: 128x96, ZEsarUX modes: 256x96, 128x192, 256x192

* Supports Chroma81 ZX81 Colour mode

* Supports Spectra Video Modes

* Supports Timex Video modes (Mode 0 standard, 1 dual screen, 2 hires colour 8x1, 6 512x192 monochrome)

* Supports Pentagon 16C mode

* Supports All Video modes from Prism machine

* Supports ZGX Sprite Chip

* Supports snow effect on Spectrum models

* Supports interlaced, scanlines and Gigascreen effects

* Supports hi-res modes on ZX Spectrum (rainbow effects and others) and ZX80/ZX81 (UDG, CHR$128, WRX, HRG and some other hi-res modes)

* Supports reducing the screen to 192x144 (0.75 scale)

* Uses its own powerful window environment (ZX Vision) inside the program application window, having the same GUI style on all plattforms. Allows to have an extended display to hold menus and multitask windows (ZX Desktop)

* Can be used with joystick and environments without keyboard, like Raspiboy / Retropie

* Emulates all the oddities of the Inves Spectrum +: 64 KB RAM, RAM initialization with FF00H pattern, OUT ula AND RAM, EAR and MIC XOR, no contended memory, snow in border, colour ula delay, interrupt starts at end of top border (not at the beginning of the border), corrupt memory on every interrupt, no idle bus

* Uses Video drivers: X-Windows, SDL, Cocoa (Mac OS X), Framebuffer, ncurses, aalib, cacalib, stdout(console), simpletext(console)

* Uses Audio Drivers: PulseAudio, Alsa, SDL, DSP(OSS), CoreAudio (Mac OS X). 

* Supports dumping audio & video to file

* Supports real tape loading of file formats: RWA, SMP, WAV, TZX, PZX, CDT, TAP, P, O. It handles loading of turbo load tapes or any type of tape loading for standard/non standard loading routines

* Handles binary tape format files (TAP, TZX, O, P, CDT, CAS) on standard BASIC ROM routines for ZX Spectrum, ZX80, ZX81, Amstrad CPC, Jupiter Ace, MSX, Spectravideo

* Handles real audio loading (RWA, SMP, WAV) on standard BASIC ROM routines for ZX Spectrum, ZX80, ZX81, Amstrad CPC, Jupiter Ace

* Simulates real tape loading on standard BASIC ROM routines for ZX Spectrum, ZX80, ZX81

* Handles snapshot formats: ZSF, ZX, Z80, SP, SPG, NEX, SNA, P, O, Z81, ACE

* Handles cartridge formats: DCK, ROM, COL, SG

* Handles RZX playback 

* Emulates Multiface One, 128 and Three

* Emulates Datagear/MB02 DMA, ZX-Uno DMA

* Emulates +3 Disk

* Emulates Betadisk/TR-DOS. Direct support for .trd files. scl files can be converted from file selector pressing space

* Emulates ZX Spectrum MMC Interfaces: ZXMMC, DivMMC. Support for raw (.mmc) files and hdf files

* Emulates ZX Spectrum IDE Interface: DivIDE, 8-bit simple 

* Emulates Sam Coupe IDE Interface: Atom Lite

* Emulates ZXPand MMC Interface on ZX80 and ZX81

* Emulates ZX Dandanator! Mini, CPC Dandanator! Mini

* Emulates Speccy Superupgrade

* Emulates Kartusho,iFrom interfaces by Antonio Villena

* Emulates DataDrive HiLow (beta)

* Handles RAM, EPROM, Intel Flash and Hybrid (RAM+EPROM) cards on Z88

* Handles compressed formats zip (with internal decompressor), and tar, rar, gz through external utilities

* Supports AY Audio Chip, Turbosound (2 AY Channels), 3 AY Channels, MIDI channels, different DAC: Specdrum, Covox, ACB/ABC/BAC Stereo 

* Supports SN76489AN Audio Chip

* Real time playback from AY Chip sound to external MIDI device 

* Supports Quicksilva, ZON-X81, and VSYNC-based sound on ZX80/81

* Supports Speaker and Soundbox sound on Jupiter Ace

* Experimental simulation of the Sam Coupe Audio Chip (SAA1099)

* Supports RAM size up to 1024 KB on Spectrum and Pentagon

* Supports RAM packs on ZX80/81 up to 56 KB

* Supports RAM packs on Jupiter Ace up to 35 KB

* Joystick emulation with real joystick (on GNU/Linux and Windows) and keyboard cursors: Kempston, Sinclair 1&2, Cursor Joystick, Cursor & Shift, OPQA, Fuller, Zebra, Mikro-Gen, ZXPand, SAM Coupe Cursors. Autofire function too

* On Screen keyboard useful when playing with joystick, two types: one with keyboard letters, and another with words, useful for playing Text Adventures. Also a tool to extract words from text adventures (Daad, Paws, Quill and Gac) and configure this on screen text keyboard

* Emulates Spectrum keyboard ghosting error feature

* ZX Spectrum Recreated keyboard support

* Supports native turbo modes on ZX-Uno, Chloe, Prism and TBBlue and manual for other machines

* ZX Printer emulation

* Lightgun emulation: Almost perfect emulation of Gunstick from MHT Ingenieros S.L and experimental emulation of Magnum Light Phaser

* Kempston mouse emulation

* Supports Network gaming using its own protocol (ZEsarUX Network Gaming protocol - ZENG), which allows you to play to any emulated game, using two ZEsarUX instances, located each one on any part of the world or in a local network. Games doesn't have to be modified, you can use any existing game

* Uart bridge emulation: allows you to use a real uart-wifi connected to your computer, on GNU/Linux only (Windows, Mac can simulate it)

* Can browse online ZX81 games

* Can browse online Spectrum games

* Supports Input spool text file to simulate keyboard press

* Supports reading Pokes from .POK files

* AY Chip Tools: AY Player, AY Sheet, AY Piano, AY Registers, export AY music to midi (.mid) files, AY Mixer

* Supports ZEsarUX remote command protocol (ZRCP). You can do enhanced debugging on ZEsarUX by using a telnet client.

* Can use a reduced Spectrum core, with some features disabled, useful on slow devices, like Raspberry Pi 1/Zero

* Powerful debug features: Assembler, Registers, Dissassemble, Conditional Breakpoints using text expressions, Watches, Step-to-step, Step-over, Runto, Show TV electron position, Load source code, Hexadecimal Editor, View Sprites, Find byte (useful to find POKEs), CPU Transaction log, View BASIC, verbose messages on console, DAAD/PAWS/Quill Debugger

* File utilities menu: Allowing to view, expand and convert some common file formats: tap, tzx, trd, dsk, mdv, hdf, etc

* Accessibility support: Print char traps allows to capture generated text from almost any program or game, using standard ROM calls (RST 10H) or even non standard print character routines. Can send generated text from a game to a text-to-speech program. It's ready for text to speech support for blind or visually impaired people. Menu emulator can also be read by a text-to-speech program.

* Simulates upper RAM memory refresh on Spectrum 48Kb, losing its contents when changing R register very quickly

* Supports command line settings, configuration file settings and per-game configuration settings

* Other features: Visualmem menu, CPU Statistics

* Includes three easter eggs. Can you find them? :)



__Some screenshots__

ZX Desktop, running multitask windows, on Solarized Dark GUI Style, running ZX Spectrum OverScan demo

![alt text](https://github.com/chernandezba/zesarux/raw/master/screenshots/screenshot_zxdesktop_multitask.png "ZX Desktop")


ZX Spectrum Overscan demo

![alt text](https://github.com/chernandezba/zesarux/raw/master/screenshots/screenshot_overscan.jpg "Overscan demo")


ZX-81 Mazogs

![alt text](https://github.com/chernandezba/zesarux/raw/master/screenshots/screenshot_mazogs.png "Mazogs")


Sinclair QL

![alt text](https://github.com/chernandezba/zesarux/raw/master/screenshots/screenshot_ql.png "QL")


Cambridge Z88

![alt text](https://github.com/chernandezba/zesarux/raw/master/screenshots/screenshot_z88.png "Z88")


ZX Spectrum Sir Fred running on curses (text) driver

![alt text](https://github.com/chernandezba/zesarux/raw/master/screenshots/screenshot_sirfred_curses.png "Sirfred curses")


ZX-Uno

![alt text](https://github.com/chernandezba/zesarux/raw/master/screenshots/screenshot_zxuno.png "ZX-Uno")


ZX-Evolution TSConf

![alt text](https://github.com/chernandezba/zesarux/raw/master/screenshots/screenshot_tsconf.jpeg "ZX-Evolution TSConf")


TBBlue/ZX Spectrum Next

![alt text](https://github.com/chernandezba/zesarux/raw/master/screenshots/screenshot_tbblue.png "TBBlue/ZX Spectrum Next")


CPC 464

![alt text](https://github.com/chernandezba/zesarux/raw/master/screenshots/screenshot_cpc.png "CPC 464")


MSX

![alt text](https://github.com/chernandezba/zesarux/raw/master/screenshots/screenshot_msx.png "MSX")


Colecovision

![alt text](https://github.com/chernandezba/zesarux/raw/master/screenshots/screenshot_coleco.png "Colecovision")


Sega SG-1000

![alt text](https://github.com/chernandezba/zesarux/raw/master/screenshots/screenshot_sg1000.png "Sega SG-1000")


You can find some ZEsarUX videos on my [Youtube channel](https://www.youtube.com/user/chernandezba)

HELP COMMAND LINE

ZEsarUX - ZX Second-Emulator And Released for UniX
https://github.com/chernandezba/zesarux

Copyright (C) 2013 Cesar Hernandez Bano

ZEsarUX is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.

Please read the other licenses used in ZEsarUX, from the menu Help->Licenses or just open files from folder licenses/


ZEsarUX v.9.1-SN - xxxxx edition. 24 August 2020

Error: Unknown parameter : -_help . Stopping parsing the rest of parameters


Usage:
[--tape] file      Insert input standard tape file. Supported formats: Spectrum: .TAP, .TZX -- ZX80: .O, .80, .Z81 -- ZX81: .P, .81, .Z81 -- All machines: .RWA, .SMP, .WAV
[--realtape] file  Insert input real tape file. Supported formats: Spectrum: .TAP, .TZX -- ZX80: .O, .80, .Z81 -- ZX81: .P, .81, .Z81 -- All machines: .RWA, .SMP, .WAV
[--snap] file      Load snapshot file. Supported formats: Spectrum: .Z80, .ZX, .SP, .SNA -- ZX80: .ZX, .O, .80 -- ZX81: .ZX, .P, .81, .Z81
[--slotcard] file  Insert Z88 EPROM/Flash file. Supported formats: .EPR, .63, .EPROM, .FLASH
Note: if you write a tape/snapshot/card file name without --tape, --realtape, --snap or --slotcard parameters, the emulator will try to guess file type (it's the same as SmartLoad on the menu)

--outtape file     Insert output standard tape file. Supported formats: Spectrum: .TAP, .TZX -- ZX80: .O -- ZX81: .P
--zoom n           Total Zoom Factor
--vo driver        Video output driver. Valid drivers: xwindows sdl fbdev caca curses stdout simpletext null
--vofile file      Also output video to raw file
--vofilefps n      FPS of the output video [1|2|5|10|25|50] (default:5)
--ao driver        Audio output driver. Valid drivers: alsa sdl dsp null
--aofile file      Also output sound to raw file
--version          Get emulator version and exit. Must be the first command line setting

--machine          Machine type:
 MK14     MK14
 ZX80     ZX80
 ZX81     ZX81
 16k      ZX Spectrum 16k
 48k      ZX Spectrum 48k
 128k     ZX Spectrum+ 128k
 QL       QL
 P2       ZX Spectrum +2
 P2F      ZX Spectrum +2 (French)
 P2S      ZX Spectrum +2 (Spanish)
 P2A40    ZX Spectrum +2A (ROM v4.0)
 P2A41    ZX Spectrum +2A (ROM v4.1)
 P2AS     ZX Spectrum +2A (Spanish)
 P340     ZX Spectrum +3 (ROM v4.0)
 P341     ZX Spectrum +3 (ROM v4.1)
 P3S      ZX Spectrum +3 (Spanish)
 TS2068   Timex TS 2068
 Inves    Inves Spectrum+
 48ks     ZX Spectrum+ 48k (Spanish)
 128ks    ZX Spectrum+ 128k (Spanish)
 TK90X    Microdigital TK90X
 TK90XS   Microdigital TK90X (Spanish)
 TK95     Microdigital TK95
 Z88      Cambridge Z88
 Sam      Sam Coupe
 Pentagon Pentagon
 Chloe140 Chloe 140 SE
 Chloe280 Chloe 280 SE
 Chrome   Chrome
 Prism    Prism 512
 ZXUNO    ZX-Uno
 BaseConf ZX-Evolution BaseConf
 TSConf   ZX-Evolution TS-Conf
 TBBlue   TBBlue/ZX Spectrum Next
 ACE      Jupiter Ace
 CPC464   Amstrad CPC 464
 CPC4128  Amstrad CPC 4128
 MSX1     MSX1
 Coleco   Colecovision
 SG1000   Sega SG1000
 SVI318   Spectravideo SVI 318
 SVI328   Spectravideo SVI 328

--noconfigfile     Do not load configuration file. This parameter must be the first and it's ignored if written on config file
--configfile f     Use the specified config file. This parameter must be the first and it's ignored if written on config file
--experthelp       Show expert options

Any command line setting shown here or on experthelp can be written on a configuration file,
this configuration file is on your home directory with name: .zesaruxrc
