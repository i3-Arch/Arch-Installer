#!/bin/bash
#
#	 POST INSTALL SCRIPT
# 				-  i3-Arch

# FONT
setfont Lat2-Terminus16

# COLORS
red=$(tput setaf 1)
white=$(tput setaf 7)
green=$(tput setaf 2)
yellow=$(tput setaf 3)

mirrorSelect() {
	printf "\033[1m ${green} \n\n Select Your Mirrors \n\n \033[0m"
	sleep 2
	if [ -f /etc/pacman.d/mirrorlist.pacnew ]
		then
			cp /etc/pacman.d/mirrorlist.pacnew /etc/pacman.d/mirrorlist
	fi
	nano /etc/pacman.d/mirrorlist
}

lemmeknow() {  ##CALLED BY     main
	if [ $(id -u) -eq 0 ]
		then
    		needpass
		else
		printf "\033[1m \n ${red} Moving on since you already have a user account \n \033[0m"
	fi
}

needpass() { ## CALLED BY lemmeknow
	clear
	printf "\033[1m \n ${yellow} Would you like to set a root password ?\n \n \033[0m"
	printf "\033[1m ${green} [Y|N] \n \033[0m"
	printf "\033[1m \n\n ${red} Answer:${white} \033[0m"
	read wutdawg
	if [ "$wutdawg" = Y -o "$wutdawg" = y ]
		then
		passwd
		usersetup
		else
		printf "\033[1m \n ${red} Ok, Moving on then.... \n \033[0m"
		usersetup
	fi
}

usersetup() {  ## CALLED BY needpass
	if [ $(id -u) -eq 0 ]
		then
			printf "\033[1m \n ${green} Would you like to setup a USER now ? \n\n \033[0m"
			printf "\033[1m \n ${yellow} [Y|N] \n \033[0m"
			printf "\033[1m \n\n Answer:${white} \033[0m"
			read usernowbro
			if	[ "$usernowbro" = Y -o "$usernowbro" = y ]
				then
				printf "\033[1m \n\n ${green} Enter The Username to Create ! \n \033[0m"
				printf "\033[1m \n Username:${white} \033[0m"
				read thenameuneed
				$(useradd -m -G disk,audio,network,video $thenameuneed)
				printf "\033[1m \n\n ${yellow} Set a Password for this USER now \n\n \033[0m"
				printf "\033[1m \n ${red} If you dont you will not be able to use it .\n \033[0m"
				passwd $thenameuneed
				else
				printf "\033[1m \n ${green} Moving on \n \033[0m"
			fi
		else
		printf "\033[1m \n ${red} Sorry You Are Not Root \n \033[0m"
	fi
}

uwantme() {
	printf "\033[1m \n ${green} Do you want to install a WM/DE now ? \n \033[0m"
	printf "\033[1m \n\n ${red} Current Choices Are \n\n \033[0m"
	printf "\033[1m \n ${yellow} (1) Custom i3 Setup \n \033[0m"
	printf "\033[1m \n ${yellow} (2) Default XFCE Setup \n \033[0m"
	printf "\033[1m \n ${yellow} (3) NULL \n \033[0m"
	printf "\033[1m \n\n Please Enter Your Choice:${white} \033[0m"
	read wutdebro
	if [ "$wutdebro" -eq 1 ]
		then
			source i3-option.sh
		
		elif [ "$wutdebro" -eq 2 ]
			then
				source i3-option.sh
		
		else
			printf "\033[1m \n\n  ${red} Sorry Thats The Choices So Far \n\n \033[0m"
	fi
}

thankyoubro() {
	if [ $(id -u) -eq 0 ]
		then
			if [ ! -f /usr/bin/wget ]
				then
					pacman -S wget
					wget https://raw.githubusercontent.com/i3-Arch/Arch-Installer/master/i3-option.sh
				else
					wget https://raw.githubusercontent.com/i3-Arch/Arch-Installer/master/i3-option.sh
			fi
	else
			then
				if [ ! -f /usr/bin/wget ]
					then
						printf "\033[1m \n\n ${green} Enter Password for root ( Installing Packages ) \n\n \033[0m"
						printf "\033[1m ${yellow} Pass:  \033[0m"
						su root
						pacman -S wget
						wget https://raw.githubusercontent.com/i3-Arch/Arch-Installer/master/i3-option.sh
					else
						wget https://raw.githubusercontent.com/i3-Arch/Arch-Installer/master/i3-option.sh
				fi
	fi
	printf "\033[1m \n ${green} Thanks for being lazy and using our script ! \n \033[0m"
	printf "\033[1m \n ${yellow} If you have any problems afterwards \n \033[0m"
	printf "\033[1m \n ${red} Search The ARCHWIKI \n \n \033[0m"
	
}

main() {
	thankyoubro
	lemmeknow
	mirrorSelect
	uwantme
}
main
