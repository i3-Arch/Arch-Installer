#!/bin/bash
#
#  MENU FOR ARCH-INSTALLER
#  
#   i3-Arch
#   trewchainz 
##############################
setfont Lat2-Terminus16
scriptdir=""$HOME"/Arch-Installer"
red="$(tput setaf 1)"
white="$(tput setaf 7)"
green="$(tput setaf 2)"
yellow="$(tput setaf 3)"

# SETTING THINGS UP FIRST 
clear
printf " \033[1m ${red} \n Setting Things Up First \n \033[0m "
cd "$HOME"
pacman -Syy git --noconfirm
git clone https://github.com/i3-Arch/Arch-Installer.git
cp "$scriptdir"/* "$HOME"/
rm -rf "$scriptdir"

calculate() {
	source installer.sh
}	

CHOICE=4
until [ $CHOICE -eq 5 ]
do
	clear
	echo -e "\033[1m ${red} \n\n   TAKE YOUR PICK \n\033[0m"
	echo -e "${white}"
	echo -e " \033[1m ${red}1)${white}\033[1m VIEW installer.sh ( HALF OF INSTALL SCRIPT ) \033[0m"
	echo -e " \033[1m ${red}2)${white}\033[1m VIEW chrootnset.sh ( OTHER HALF OF SCRIPT )  \033[0m"
	echo -e " \033[1m ${red}3)${white}\033[1m VIEW README  \033[0m"
	echo -e " \033[1m ${red}4)${white}\033[1m INSTALL ARCHLINUX ! \033[0m"
	echo -e " \033[1m ${red}5)${white}\033[1m Exit\033[0m"
	read CHOICE

case $CHOICE in
	1) echo -e "\033[1m ${yellow} " && cat installer.sh|less ;;
	2) echo -e "\033[1m ${yellow} " && cat chrootnset.sh|less ;;
	3) echo -e "\033[1m ${white}  " && cat ReadMe.md |less ;;
	4) echo -e "\033[1m ${white}  LETS DO IT " && calculate ;;
	5) echo -e "\033[1m ${yellow} HOPE YOU ENJOY \033[0m" ;;
	*) echo -e "\033[1m ${yellow} invalid option ${red} try again\033[0m"
esac

echo -e "\033[1m ${green}\n\nPress ${red}Enter${green} to Continue\033[0m"
read Enter
done
