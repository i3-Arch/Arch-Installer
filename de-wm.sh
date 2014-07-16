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
		printf "\033[1m \n\n ${green}Option 1: ${yellow}Install Default Xfce Setup \n \033[0m"
		printf "\033[1m \n\n ${green}Option 2: ${yellow}Install Our CUSTOM i3 Setup\n \033[0m"
		printf "\033[1m \n\n ${green}Option 3: ${yellow}Install Default Cinnamon Setup \n\n \033[0m" 
		printf "\033[1m \n\n ${green}Option 4: ${yellow}Install Default Dwm Setup \n\n \033[0m"
		printf "\033[1m\n ${green}Choose ${red}1${white},${red}2${white},${red}3${white} or 4${white}: \033[0m"
		read DemChoice
		if [ "$DemChoice" == 1 ]
			then
			pacman -Syy zsh xfce4 xfce4-goodies xorg-server xorg-server-utils xorg-font-util xorg-xinit xterm ttf-dejavu xf86-video-vesa xf86-input-synaptics firefox rxvt-unicode urxvt-perls --noconfirm
		elif [ "$DemChoice" == 2 ]
			then
			pacman -Syy vim xcompmgr xscreensaver zsh xorg-server vim xorg-server-utils feh xorg-font-util xorg-xinit xterm i3-wm i3status dmenu ttf-dejavu xf86-video-vesa xf86-input-synaptics firefox rxvt-unicode urxvt-perls --noconfirm
		elif [ "$DemChoice" == 3 ]
			then
				pacman -Syy zsh cinnamon xorg-server xorg-server-utils xorg-font-util xorg-xinit xterm ttf-dejavu xf86-video-vesa xf86-input-synaptics firefox rxvt-unicode urxvt-perls --noconfirm
		elif [ "$DemChoice" == 4 ]
			then
			pacman -Syy zsh xorg-server xorg-server-utils xorg-font-util xorg-xinit xterm ttf-dejavu xf86-video-vesa xf86-input-synaptics firefox abs dmenu rxvt-unicode urxvt-perls --noconfirm
		else
			printf "\033[1m Choice not understood\033[0m"
			sleep 2
		fi
	else
		printf "\033[1m \n\n ${green}Option 1: ${yellow}Install Default XFCE Setup \n\n \033[0m"
		printf "\033[1m \n\n ${green}Option 2: ${yellow}Install CUSTOM i3 Setup \n\n \033[0m"
		printf "\033[1m \n\n ${green}Option 3: ${yellow}Install Default Cinnamon Setup \n\n \033[0m"
		printf "\033[1m \n\n ${green}Option 4: ${yellow}Install Default Dwm Setup	\n\n \033[0m"
		printf "\033[1m\n ${green}Choose ${red}1,${white}${red}2,${red}3, ${white}or ${red}4 ${white} \n\n\033[0m"
		printf "\n\n ${yellow}Choice: ${white}"
		read DoYouEven
		if [ "$DoYouEven" == 1 ]
			then
			printf "\033[1m \n\n ${red}Enter Password for root ( installing packages ) \n\n \033[0m"
			printf "\033[1m\n ${green}Enter Pass: ${white}\033[0m"
			su root
			pacman -Syy base-devel zsh xfce4 xfce4-goodies xorg-server xorg-server-utils xorg-font-util xorg-xinit xterm ttf-dejavu xf86-video-vesa xf86-input-synaptics firefox rxvt-unicode urxvt-perls --noconfirm
			exit
		elif [ "$DoYouEven" == 2 ]
			then
			printf "\033[1m \n\n ${green}Enter Password for root ${red}( installing packages ) \n \033[0m"
			printf "\033[1m \n ${green}Enter Pass: ${white}\033[0m"
			su root
			pacman -Syy xscreensaver vim xcompmgr base-devel zsh xorg-server xorg-server-utils feh xorg-font-util xorg-xinit xterm i3-wm i3status dmenu ttf-dejavu xf86-video-vesa xf86-input-synaptics firefox rxvt-unicode urxvt-perls --noconfirm	
			exit
		elif [ "$DoYouEven" == 3 ]
			then
			printf "\033[1m ${green}Enter Password for root ${red}( installing packages ) \n \033[0m"	
			printf "\033[1m ${green}Enter Pass: ${white}\033[0m"
			su root
			pacman -Syy cinnamon zsh base-devel xorg-server xorg-server-utils xorg-font-util xorg-xinit xterm ttf-dejavu xf86-video-vesa xf86-input-synaptics xterm firefox rxvt-unicode urxvt-perls --noconfirm
			exit
		elif [ "$DoYouEven" == 4 ]
			then
			pacman -Syy zsh base-devel xorg-server xorg-server-utils xorg-font-util xorg-xinit xterm ttf-dejavu xf86-video-vesa xf86-input-synaptics xterm firefox rxvt-unicode urxvt-perls --noconfirm
		else
			printf "\033[1m ${red}lolwut${white}.... ${yellow}NOT UNDERSTOOD \033[0m"
			sleep 2
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
		printf "\033[1m \n ${red} Did you make the right choice ? \n\n ${yellow}Where is xorg.conf.new ? -- skipping \n \033[0m"
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
	if [ "$DoYouEven" == 2 -o "$DemChoice" == 2 ]
		then
		printf "\033[1m \n ${green}Setting up ${red} .Xresources, .vimrc and .xinitrc \n \033[0m"
		wget https://raw.githubusercontent.com/i3-Arch/i3config/master/.Xresources
		wget https://raw.githubusercontent.com/i3-Arch/i3config/master/.xinitrc
		wget https://raw.githubusercontent.com/i3-Arch/i3config/master/.zshrc
		wget https://raw.githubusercontent.com/i3-Arch/i3config/master/.vimrc
	fi
}

guestbro() {
	if [ $(id -u) -eq 0 ]
		then
		printf "\033[1m \n\n ${green}Are you using Virtualbox ? \n\n \033[0m"
		printf "\033[1m \n\n ${white}[${green}Y${white}|${red}N${white}] \n \033[0m"
		printf "\033[1m \n\n ${green}Answer: ${white}\033[0m"
		read wutUsay
		if [ "$wutUsay" == Y -o "$wutUsay" == y ]
			then
			pacman -S virtualbox-guest-utils --noconfirm
			modprobe -a vboxguest vboxsf vboxvideo
			echo "vboxguest" > /etc/modules-load.d/virtualbox.conf 2> /dev/null
			echo "vboxvideo" >> /etc/modules-load.d/virtualbox.conf 2> /dev/null
			echo "vboxsf" >> /etc/modules-load.d/virtualbox.conf 2> /dev/null
		elif [ "$wutUsay" == N -o "$wutUsay" == n ]
			then 
			printf "\033[1m \n\n ${green}Are you using VMWARE ? \033[0m"
			printf "\033[1m \n\n ${white}[${green}Y${white}|${red}N${white}] \033[0m"
			printf "\033[1m \n\n ${green}Answer: ${white}\033[0m"
			read VMwut
			if [ "$VMwut" == Y -o "$VMwut" == y ]
				then
				pacman -S svga-dri xf86-input-vmmouse xf86-video-vmware open-vm-tools --noconfirm
			fi
		else
			printf "\033[1m \n\n${red}Did you type a ${yellow}'y' ${white}or a ${yellow}'n'${red} ? \033[0m"
			sleep 2
		fi
	else
		printf "\033[1m	\n\n ${green}Are you using Virtualbox ?\033[0m"
		printf "\033[1m \n\n ${white}[${green}Y${white}|${red}N${white}] \n\033[0m"
		printf "\033[1m \n\n ${green}Answer: ${white} \033[0m"
		read userfag
		if [ "$userfag" == Y -o "$userfag" == y ]
			then
			printf "\033[1m \n\n ${red}Enter Pass for ROOT \n\n \033[0m"
			su root
			pacman -S virtualbox-guest-utils --noconfirm
			modprobe -a vboxguest vboxsf vboxvideo
			echo "vboxguest" > /etc/modules-load.d/virtualbox.conf 2> /dev/null
			echo "vboxvideo" >> /etc/modules-load.d/virtualbox.conf 2> /dev/null
			echo "vboxsf" >> /etc/modules-load.d/virtualbox.conf 2> /dev/null
			exit
		elif [ "$userfag" == N -o "$userfag" == n ]
			then
			printf "\033[1m \n\n ${green}Are you using VMWARE ? \033[0m"
			printf "\033[1m \n\n ${white}[${green}Y${white}|${red}N${white}] \n\n\033[0m"
			printf "\033[1m \n\n ${green}Answer: ${white}\033[0m"
			read csvm
			if [ "$csvm" == Y -o "$csvm" == y ]
				then
				printf "\033[1m \n\n ${red}Enter Pass for ROOT \033[0m"
				su root
				pacman -S svga-dri xf86-input-vmmouse xf86-video-vmware open-vm-tools --noconfirm
				exit
			fi
		else
			printf "\033[1m ${red}Not Understood ${white}|${green}Moving on\033[0m"
			sleep 2
		fi
	fi
}

envset() {
	if [ $(id -u) -eq 0 ]
		then
		printf "\033[1m \n\n ${yellow}Did you create a user ? \n\n \033[0m"
		printf "\033[1m \n\n ${white}[${green}Y${white}|${red}N${white}] \n\n \033[0m"
		printf "\033[1m \n\n ${green}Answer: ${white}\033[0m"
		read DikWeed
		if [ "$DikWeed" == Y -o "$DikWeed" == y -o "$DikWeed" == YES -o "$DikWeed" == yes ]
			then
			printf "\033[1m \n\n ${green}Enter that username please \n\n \033[0m"
			printf "\033[1m ${red}Username: ${white}\033[0m"
			read yourINput
			cp /etc/skel/.xinitrc /home/"$yourINput"/
			if [ "$DemChoice" == 1 -o "$DoYouEven" == 1 ]
				then
				if [ -f /home/"$yourINput"/.xinitrc ]
					then
					echo "exec startxfce4" >> /home/"$yourINput"/.xinitrc
				fi
			elif [ "$DemChoice" == 2 -o "$DoYouEven" == 2 ]
				then
				if [ -f /home/"$yourINput"/.xinitrc ]
					then
					rm /home/"$yourINput"/.xinitrc
					cp .Xresources .zshrc .xinitrc .vimrc /home/"$yourINput"/
					cp -r .i3 /home/"$yourINput"/
				fi
			elif [ "$DemChoice" == 3 -o "$DoYouEven" == 3 ]
				then
				if [ -f /home/"$yourINput"/.xinitrc ]
					then
					echo "exec cinnamon-session" >> /home/"$yourINput"/.xinitrc
				fi
			elif [ "$DemChoice" == 4 -o "$DoYouEven" == 4 ]
				then
				if [ -f /home/"$yourINput"/.xinitrc ]
					then
					echo "exec dwm" >> /home/"$yourINput"/.xinitrc
					abs community/dwm
					cp -r /var/abs/community/dwm /home/"$yourINput"/dwm
					printf "\033[1m ${green}Enter "$yourINput" Password to set up dwm \033[0m"
					su "$yourINput"
					cd ~/dwm
					makepkg -i
					exit
				fi
		fi
			else
				printf "\033[1m ${green}  \n\nShould have used the ${red}POST-INSTALL.sh ${green}script to setup user for a WM/ENVIRONMENT \033[0m"
				printf "\033[1m ${yellow} \n\n Now you will have to cp /etc/skel/.xinitrc to your users home dir and edit it \n\n \033[0m"
				sleep 3
					
			fi
	fi
}

slimforyou() {
	printf "\033[1m \n\n ${green}Would you like to enable slim ? \n\n \033[0m"
	printf "\033[1m \n\n ${white}[${green}Y${white}|${red}N${white}] \n\n \033[0m"
	printf "\033[1m \n ${green}Answer: ${white}\033[0m"
	read slimok
	if [ "$slimok" == Y -o "$slimok" == y ]
		then
		if [ $(id -u) -eq 0 ]
			then
			pacman -S slim --noconfirm
			systemctl enable slim.service
		else
			printf "\033[1m \n ${green}Enter pass for root \n\n \033[0m"
			su root
			pacman -S slim --noconfirm
			systemctl enable slim.service
			exit
		fi
	else
		printf "\033[1m \n ${yellow}EXTRA TIP ${green}:: ${red}In the future you will need to Run  ${yellow}startx ${green}:: \n \033[0m"
	fi	
}


main() {
	banner
	greetz
	guestbro
	makeitbro
	xseti3
	i3fin
	envset
	slimforyou
	rm Post-Install.sh de-wm.sh
}

main

#EOF
