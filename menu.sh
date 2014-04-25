#!/bin/bash
removeit=$(rm ReadMe.md 2> /dev/null)
red=$(tput setaf 1)
white=$(tput setaf 7)
green=$(tput setaf 2)
yellow=$(tput setaf 3)

calculate () {
	if [ $CHOICE -eq 4 ]
		then
		   sleep 2 && source installer.sh
		else
			echo
	fi
}	

CHOICE=6
	until [ $CHOICE -eq 5 ]
	do
clear
	echo
	echo -e "\033[1m ${red} TAKE YOUR PICK \033[0m"
	echo -e "${white}"
	echo -e " \033[1m ${red}1)${white}\033[1m VIEW installer.sh ( HALF OF INSTALL SCRIPT ) \033[0m"
	echo -e " \033[1m ${red}2)${white}\033[1m VIEW chrootnset.sh ( OTHER HALF OF SCRIPT )  \033[0m"
	echo -e " \033[1m ${red}3)${white}\033[1m VIEW README  \033[0m"
	echo -e " \033[1m ${red}4)${white}\033[1m INSTALL ARCHLINUX ! \033[0m"
	echo -e " \033[1m ${red}5)${white}\033[1m Exit\033[0m"
	echo
read CHOICE
	case $CHOICE in
		1) echo -e "\033[1m ${yellow} " && cat installer.sh|less ;;
		2) echo -e "\033[1m ${yellow} " && cat chrootnset.sh|less ;;
		3) echo -e "\033[1m ${white}  $(wget https://raw.githubusercontent.com/i3-Arch/Arch-Installer/master/ReadMe.md) " && cat ReadMe.md |less && sleep 2 && "$removeit" ;;
		4) echo -e "\033[1m ${white}  LETS DO IT " && calculate ;;
		5) echo -e "\033[1m ${yellow} HOPE YOU ENJOY \033[0m" ;;
		*) echo -e "\033[1m ${yellow} invalid option ${red} try again\033[0m"
	esac
echo
	echo -e "\033[1m ${green} Press Enter to Continue\033[0m"
read Enter
	done