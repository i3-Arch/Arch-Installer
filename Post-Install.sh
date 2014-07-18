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

updateupgrade() {
	pacman -Syyu --noconfirm
}

mirrorselect() {
		printf "\033[1m ${green} \n\n Select Your Mirrors \n\n \033[0m"
		sleep 2
		if [ -f /etc/pacman.d/mirrorlist.pacnew ]
			then
			cp /etc/pacman.d/mirrorlist.pacnew /etc/pacman.d/mirrorlist
		fi
		nano /etc/pacman.d/mirrorlist
}


needpass() { 
	clear
	printf "\033[1m \n ${yellow} Would you like to set a root password ?\n \n \033[0m"
	printf "\033[1m ${white}[${green}Y${white}|${red}N${white}] \n \033[0m"
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
		clear
		printf "\033[1m \n ${green} Would you like to setup a USER now ? \n\n \033[0m"
		printf "\033[1m \n ${white}[${green}Y${white}|${red}N${white}] \n \033[0m"
		printf "\033[1m \n\n Answer:${white} \033[0m"
		read usernowbro
		if	[ "$usernowbro" = Y -o "$usernowbro" = y ]
			then
			printf "\033[1m \n\n ${green} Enter The Username to Create ! \n \033[0m"
			printf "\033[1m \n Username:${white} \033[0m"
			read thenameuneed
			$(useradd -m -G adm,disk,audio,network,video $thenameuneed)
			printf "\033[1m \n\n ${yellow} Set a Password for this USER now \n\n \033[0m"
			printf "\033[1m \n ${red} If you dont you will not be able to use it .\n \033[0m"
			passwd $thenameuneed
			printf "\033[1m \n\n ${yellow}Would you like to add user to sudoers? ( user ALL=(ALL) ALL ) \033[0m"
			printf "\033[1m \n\n ${white}[${green}Y${white}|${red}N${white}] \033[0m"
			printf "\033[1m\n\n ${red}Answer: ${white}\033[0m"
			read anot
			if [ "$anot" == Y -o "$anot" == y -o "$anot" == yes -o "$anot" == YES ]
				then
				echo -n "$thenameuneed" "ALL=(ALL)" "ALL" >> /etc/sudoers
			fi
		else
			printf "\033[1m \n ${green} Moving on \n \033[0m"
		fi
}

uwantme() {
	clear
	printf "\033[1m \n ${green} Do you want to install a WM/DE now ? \n \033[0m"
	printf "\033[1m \n\n ${white}[${green}Y${white}|${red}N${white}] \n\n \033[0m"
	printf "\033[1m \n\n ${red} Choice:${white} \033[0m"
	read wutdebro
	if [ "$wutdebro" == Y -o "$wutdebro" == y -o "$wutdebro" == YES -o "$wutdebro" == yes ]
		then
		main2
	else
		printf "\033[1m \n\n  ${red} Understood \n\n \033[0m"
	fi
}

thankyoubro() {
	clear
	printf "\033[1m \n ${green} Thanks for being lazy and using our script ! \n \033[0m"
	printf "\033[1m \n ${yellow} If you have any problems afterwards \n \033[0m"
	printf "\033[1m \n ${red} Search The ARCHWIKI \n \n \033[0m"
	sleep 3
}

main() {
	checkroot
	updateupgrade
	thankyoubro
	needpass
	mirrorselect
	uwantme
}

main

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
    !! 					         !!/
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
		printf "\033[1m \n\n ${green}Option 1: ${yellow}Install Default Xfce Setup \n \033[0m"
		printf "\033[1m \n\n ${green}Option 2: ${yellow}Install Our CUSTOM i3 Setup\n \033[0m"
		printf "\033[1m \n\n ${green}Option 3: ${yellow}Install Default Cinnamon Setup \n \033[0m" 
		printf "\033[1m \n\n ${green}Option 4: ${yellow}Install Default Dwm Setup \n \033[0m"
		printf "\033[1m \n\n ${green}Option 5: ${yellow}Install Default Awesome Setup \n \033[0m"
		printf "\033[1m \n\n ${green}Option 6: ${yellow}Install Default Gnome Setup \n \033[0m"
		printf "\033[1m\n${green}Choose a number  ${red}1${white}-${red}6\033[0m"
		printf "\033[1m \n\n ${yellow}Choice${white}: ${white}\033[0m"
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
		elif [ "$DemChoice" == 5 ]
			then
			pacman -Syy awesome zsh xorg-server xorg-server-utils xorg-font-util xorg-xinit xterm ttf-dejavu xf86-video-vesa xf86-input-synaptics firefox rxvt-unicode urxvt-perls --noconfirm
		elif [ "$DemChoice" == 6 ]
			then
			pacman -Syy gnome gnome-extra zsh xorg-server xorg-server-utils xorg-font-util xorg-xinit xterm ttf-dejavu xf86-video-vesa xf86-input-synaptics firefox rxvt-unicode urxvt-perls --noconfirm
		else
			printf "\033[1m ${yellow}Choice not understood... ${red}Exiting \033[0m"
			sleep 2
			exit
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
	if [ "$DemChoice" == 2 ] 
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
	if [ "$DemChoice" == 2 ]
		then
		printf "\033[1m \n ${green}Setting up ${red} .Xresources, .vimrc and .xinitrc \n \033[0m"
		wget https://raw.githubusercontent.com/i3-Arch/i3config/master/.Xresources
		wget https://raw.githubusercontent.com/i3-Arch/i3config/master/.xinitrc
		wget https://raw.githubusercontent.com/i3-Arch/i3config/master/.zshrc
		wget https://raw.githubusercontent.com/i3-Arch/i3config/master/.vimrc
	fi
}

guestbro() {
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
}

envset() {
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
			chown "$yourINput":"$yourINput" /home/"$yourINput"/.xinitrc
			if [ "$DemChoice" == 1 ]
				then
				if [ -f /home/"$yourINput"/.xinitrc ]
					then
					echo "exec startxfce4" >> /home/"$yourINput"/.xinitrc
				fi
			elif [ "$DemChoice" == 2 ]
				then
				if [ -f /home/"$yourINput"/.xinitrc ]
					then
					rm /home/"$yourINput"/.xinitrc
					cp .Xresources .zshrc .xinitrc .vimrc /home/"$yourINput"/
					cp -r .i3 /home/"$yourINput"/
					chown "$yourINput":"$yourINput" /home/"$yourINput"/.i3/*
					chown "$yourINput":"$yourINput" /home/"$yourINput"/*
				fi
			elif [ "$DemChoice" == 3 ]
				then
				if [ -f /home/"$yourINput"/.xinitrc ]
					then
					echo "exec cinnamon-session" >> /home/"$yourINput"/.xinitrc
				fi
			elif [ "$DemChoice" == 4 ]
				then
				if [ -f /home/"$yourINput"/.xinitrc ]
					then
					echo "exec dwm" >> /home/"$yourINput"/.xinitrc
					abs community/dwm
					cp -r /var/abs/community/dwm /home/"$yourINput"/dwm
					chown "$yourINput":"$yourINput" /home/"$yourINput"/dwm
					chown "$youINput":"$yourINput" /home/"$yourINput"/dwm/*
					su "$yourINput" -c "cd /home/"$yourINput"/dwm && makepkg"
					pacman -U /home/"$yourINput"/dwm/*.tar.xz
				fi
			elif [ "$DemChoice" == 5 ]
				then
				if [ -f /home/"$yourINput"/.xinitrc ]
					then
					echo "exec awesome" >> /home/"$yourINput"/.xinitrc
				fi
			elif [ "$DemChoice" == 6 ]
				then
				if [ -f /home/"$yourINput"/.xinitrc ]
					then
					echo "exec gnome-session" >> /home/"$yourINput"/.xinitrc
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
			pacman -S slim --noconfirm
			systemctl enable slim.service
	else
		printf "\033[1m \n ${yellow}EXTRA TIP ${green}:: ${red}In the future you will need to Run  ${yellow}startx ${green}:: \n \033[0m"
	fi	
}


main2() {
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

checkroot() {
	if [ "$(id -u)" -eq 0 ]
		then
		printf "\033[1m ${green}Read to start ! \033[0m"
	else
		printf "\033[1m ${yellow}You need to be ${green}root ${yellow}to run this script \033[0m"
		printf "\033[1m ${red}EXITING NOW \033[0m"
		sleep 2
		exit
	fi
}

#EOF
