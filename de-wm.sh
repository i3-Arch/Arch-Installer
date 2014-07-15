#!/bin/bash
#
#  Made To Setup i3
#
#  Author: i3-Arch
#
###############################################

# COLORS
red=$(tput setaf 1)
white=$(tput setaf 7)
green=$(tput setaf 2)
yellow=$(tput setaf 3)

banner() {
cat <<"EOT"
     _____________________________
    !\___________________________/\
    !!                           !!\
    !!                           !! \
    !!   ARCHLINUX   IS          !! !
    !!                           !! !
    !!       MASTER RACE         !! !
    !!                           !! !
    !! lulz@arch~> hue	         !! !
    !! zsh:command not found:hue !! /
    !! 			         !!/
    !!___________________________!!
    !/________________________\!/
       __\_________________/__/!_
      !_______________________!/ )
    ________________________    (__
   /oooo  oooo  oooo  oooo /!   _  )_
  /ooooooooooooooooooooooo/ /  (_)_(_)
 /ooooooooooooooooooooooo/ /    (o o)
/C=_____________________/_/    ==\o/==

EOT
sleep 3
}

greetz() {
	cd "$HOME"
	printf "\033[1m \n\n ${green}  :: Lets Do This ::  \n\n \033[0m"
	printf "\033[1m \n\n ${yellow}	#SWAG	      \n\n \033[0m"
}

makeitbro() {
	if [ $(id -u) -eq 0 ]
		then
			printf "\033[1m \n\n ${green}Option 1: ${yellow}Install default xfce setup \n \033[0m"
			printf "\033[1m \n\n ${green}Option 2: ${yellow}Install our CUSTOM i3 setup\n\n \033[0m"
			printf "\033[1m\n ${green}Choose ${red}1 ${white}or ${red}2${white}: \033[0m"
				read DemChoice
					if [ "$DemChoice" == 1 ]
						then
							pacman -Syy zsh xfce4 xfce4-goodies wget xorg-server xorg-server-utils xorg-font-util xorg-xinit xterm ttf-dejavu xf86-video-vesa xf86-input-synaptics firefox rxvt-unicode urxvt-perls --noconfirm
					elif [ "$DemChoice" == 2 ]
						then
							pacman -Syy zsh wget xorg-server vim xorg-server-utils feh xorg-font-util xorg-xinit xterm i3-wm i3status dmenu ttf-dejavu xf86-video-vesa xf86-input-synaptics firefox rxvt-unicode urxvt-perls --noconfirm
							printf "\033[1m ${yellow}\n You will need to move these dotfiles \n \033[0m"
							printf "\033[1m ${yellow}to your user's home directory \n \033[0m"
							printf "\033[1m ${red}\n .Xresources \n .xinitrc \n .zshrc \n .vimrc \n \033[0m"
					fi
		else
		printf "\033[1m \n\n ${green}Option 1: ${yellow}Install Default XFCE Setup \n\n \033[0m"
		printf "\033[1m \n\n ${green}Option 2: ${yellow}Install CUSTOM i3 Setup \n\n \033[0m"
		printf "\n ${green}Choose ${red}1 ${white}or ${red}2${white}: "
		read DoYouEven
			if [ "$DoYouEven" == 1 ]
				then
					printf "\033[1m \n\n ${red}Enter Password for root ( installing packages ) \n\n \033[0m"
					printf "\033[1m\n ${green}Enter Pass: ${white}\033[0m"
					su root
					pacman -Syy base-devel zsh xfce4 xfce4-goodies xorg-server wget xorg-server-utils xorg-font-util xorg-xinit xterm ttf-dejavu xf86-video-vesa xf86-input-synaptics firefox rxvt-unicode urxvt-perls --noconfirm
			elif [ "$DoYouEven" == 2 ]
				then
					printf "\033[1m \n\n ${green}Enter Password for root ( installing packages ) \n \033[0m"
					printf "\033[1m \n ${green}Enter Pass: ${white}\033[0m"
					su root
					pacman -Syy base-devel zsh xorg-server wget xorg-server-utils feh xorg-font-util xorg-xinit xterm i3-wm i3status dmenu ttf-dejavu xf86-video-vesa xf86-input-synaptics firefox rxvt-unicode urxvt-perls --noconfirm	
		exit
		    	else
					printf "\033[1m ${red}lolwut.... ${yellow}NOT UNDERSTOOD \033[0m"
			fi
	fi
}

xseti3() {
	X -configure 2> /dev/null
	if [ -f "$HOME/xorg.conf.new" ]
		then
			cp "$HOME/xorg.conf.new" "$HOME/xorg.conf"
			rm "$HOME/xorg.conf.new"
		else
			printf "\033[1m \n ${red}Where is xorg.conf.new ? -- skipping \n \033[0m"
	fi
		if [ "$DoYouEven" == 2 -o "$DemChoice" == 2 ] 
			then
			printf "\033[1m \n ${yellow}Setting Up i3 config in ~/.i3/config \n \033[0m"
			wget https://raw.githubusercontent.com/i3-Arch/i3config/master/.i3/config
			if [ -f "$HOME/.i3/config" ]
				then
					rm -rf ~/.i3
					mkdir ~/.i3
					mv config ~/.i3/config
				else
					mkdir ~/.i3
					mv config ~/.i3/config
			fi
		fi
}

i3fin() {
	if [ "$DoYouEven" == 2 -o "$DoYouEven" == 2 ]
		then
			printf "\033[1m \n ${green}Setting up ${red} .Xresources, .vimrc and .xinitrc \n \033[0m"
			wget https://raw.githubusercontent.com/i3-Arch/i3config/master/.Xresources
			wget https://raw.githubusercontent.com/i3-Arch/i3config/master/.xinitrc
			wget https://raw.githubusercontent.com/i3-Arch/i3config/master/.zshrc
			wget https://raw.githubusercontent.com/i3-Arch/i3config/master/.vimrc
	fi
}

guestbro() {
	printf "\033[1m \n ${green}Are you using virtualbox ? \n\n \033[0m"
	printf "\033[1m \n ${white}[${green}Y${white}/${red}N${white}] \n \033[0m"
	printf "\033[1m \n ${green}Answer: ${white}\033[0m"
	read wutUsay
	if [ "$wutUsay" == Y -o "$wutUsay" == y ]
		then
			pacman -S virtualbox-guest-utils --noconfirm
			modprobe -a vboxguest vboxsf vboxvideo
			echo "vboxguest" > /etc/modules-load.d/virtualbox.conf 2> /dev/null
			echo "vboxvideo" >> /etc/modules-load.d/virtualbox.conf 2> /dev/null
			echo "vboxsf" >> /etc/modules-load.d/virtualbox.conf 2> /dev/null
			printf "\n Done ! \n"
	fi
}

main() {
	banner
	greetz
	guestbro
	makeitbro
	xseti3
	i3fin
	printf "\033[1m \n ${yellow}EXTRA TIP ${green}:: ${red}In the future you will need to Run  ${yellow}startx ${green}:: \n \033[0m"
}

main
