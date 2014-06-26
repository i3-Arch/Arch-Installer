#!/bin/bash
#
#  MENU FOR ARCH-INSTALLER
#  
#   i3-Arch
#   trewchainz 
##############################
setfont Lat2-Terminus16
scriptdir=$HOME/Arch-Installer
red=$(tput setaf 1)
white=$(tput setaf 7)
green=$(tput setaf 2)
yellow=$(tput setaf 3)

# SETTING THINGS UP FIRST 
printf " \033[1m ${red} \n Setting Things Up First \n \033[0m "
cd $HOME
pacman -Syy git --noconfirm
git clone https://github.com/i3-Arch/Arch-Installer.git
printf "\033[1m \n \n Copying Files and Removing Clone Dir \n \033[0m"
cp $scriptdir/* $HOME/
rm -rf $scriptdir

calculate() {
	if [ $CHOICE -eq 4 ]
		then
		   sleep 2 && source installer.sh
	fi
}	

CHOICE=4
until [ $CHOICE -eq 5 ]
do
	clear
	echo -e "\033[1m ${red} TAKE YOUR PICK \033[0m"
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
	5) echo -e "\033[1m ${yellow} HOPE YOU ENJOY \033[0m" && rm *.sh *Installer*.gz issue ReadMe* ;; # Exit and Cleanup
	*) echo -e "\033[1m ${yellow} invalid option ${red} try again\033[0m"
esac

echo -e "\033[1m ${green} Press Enter to Continue\033[0m"
read Enter
done
