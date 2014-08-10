#!/bin/bash
#
# MENU FOR POST-INSTALL
#
# i3-Arch
##############################
setfont Lat2-Terminus16
red="$(tput setaf 1)"
white="$(tput setaf 7)"
green="$(tput setaf 2)"
yellow="$(tput setaf 3)"

# SETTING THINGS UP FIRST
cd "$HOME"
clear
DATCHOICE=4
until [ "$DATCHOICE" -eq 5 ]
do
	clear
	echo -e "\033[1m ${red} \n\n TAKE YOUR PICK \n\033[0m"
	echo -e "\033[1m ${green}\n\n  Make Sure You ${red}RUN ${yellow}Post-Install ${red}Before Installing ${yellow}'${green}ANOTHER${yellow}' ${green}WM${white}/${green}DE\n\n\033[0m"
	echo -e " \033[1m ${red}1)${white}\033[1m VIEW Post-Install Script \n\033[0m"
	echo -e " \033[1m ${red}2)${white}\033[1m RUN Post-Install script \n\033[0m"
	echo -e " \033[1m ${red}3)${white}\033[1m VIEW another.sh \n\033[0m"
	echo -e " \033[1m ${red}4)${white}\033[1m Install Another WM/DE \n\033[0m"
	echo -e " \033[1m ${red}5)${white}\033[1m Exit \033[0m"
	echo -en "\033[1m \n\n${yellow}Choice: ${white}\033[0m"
	read DATCHOICE

case "$DATCHOICE" in
	1) echo -e "\033[1m ${yellow} #${white}Paranoid\033[0m" && cat post-install.sh|less ;;
	2) echo -e "\033[1m ${yellow} #${white}Swag\033[0m" && source post-install.sh ;;
	3) echo -e "\033[1m ${yellow} #${white}Paranoid\033[0m" && cat another.sh|less ;;
	4) echo -e "\033[1m ${yello2} #${white}StillSwaggin\033[0m" && source another.sh ;;
	5) echo -e "\033[1m ${yellow} HOPE YOU ENJOY... Rebooting Now\033[0m" && sleep 3 && rm post-install.sh another.sh post-menu.sh && $(reboot) ;;
	*) echo -e "\033[1m ${yellow} invalid option ${red} try again\033[0m"
esac

echo -e "\033[1m ${green}\n\nPress ${red}Enter${green} to Continue\033[0m"
read Enter
done
