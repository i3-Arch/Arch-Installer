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


checkroot() {
	if [ "$(id -u)" -eq 0 ]
		then
		clear
		printf "\033[1m \n\n ${green}  Almost Ready to start ! \n\n \033[0m"
		wget -q --tries=10 --timeout=20 https://google.com
		if [[ "$?" -eq 0 ]]
			then   
			printf "\033[1m ${green}\n\n Online... ${yellow}Lets do this...\033[0m"
			rm index.html
			pacman -Syyu --noconfirm
		else
			printf "\033[1m \n\n${red}Offline ${white}- ${yellow}wait 8 seconds...\n\033[0m"
			sleep 8
			wget -q --tries=5 --timeout=20 https://google.com
			if [[ "$?" -eq 0 ]]
				then
				printf "\033[1m ${green} \n\n  Cool... Lets do this \n\n\033[0m"
				rm index.html
				pacman -Syyu --noconfirm
			else
				printf "\033[1m ${red} \n\n  DID YOU RUN DHCPCD ??? \033[0m"
				printf "\033[1m \n\n${green}  Connect to internet.. Then try again \n\n\033[0m"
				printf "\033[1m ${red} EXITING \033[0m"
				sleep 5
				exit
			fi	
		fi
	else
		clear
		printf "\033[1m \n\n ${yellow}You need to be ${green}root ${yellow}to run this script \n\n \033[0m"
		printf "\033[1m ${red}EXITING NOW /n/n \033[0m"
		sleep 2
		exit
	fi
}

banner() {
cd "$HOME"
printf "\033[1m \n\n ${green}  :: Lets Do This ::  \n\n\033[0m"
printf "\033[1m \n\n ${yellow}	#ARCHLINUX-SWAG	      \n\n\033[0m"
}


makeitbro() {
		clear
		printf "\033[1m \n ${green}Option 1: ${yellow}Install Default Xfce Setup \n \033[0m"
		printf "\033[1m \n ${green}Option 2: ${yellow}Install Our CUSTOM i3 Setup\n \033[0m"
		printf "\033[1m \n ${green}Option 3: ${yellow}Install Default Cinnamon Setup \n \033[0m" 
		printf "\033[1m \n ${green}Option 4: ${yellow}Install Default Dwm Setup \n \033[0m"
		printf "\033[1m \n ${green}Option 5: ${yellow}Install Default Awesome Setup \n \033[0m"
		printf "\033[1m \n ${green}Option 6: ${yellow}Install Default Gnome Setup \n \033[0m"
		printf "\033[1m \n ${green}Option 7: ${yellow}Install Default Kde Setup \n\n \033[0m"
		printf "\033[1m\n${white}Choose a number  ${red}1${white}-${red}7\033[0m"
		printf "\033[1m \n\n ${yellow}Choice${white}: ${white}\033[0m"
		read DemChoice
		if [ "$DemChoice" -eq "1" ]
			then
			pacman -Syy xfce4 xfce4-goodies xorg-server xorg-server-utils xorg-font-util xorg-xinit xterm ttf-dejavu xf86-video-vesa xf86-input-synaptics firefox --noconfirm
		elif [ "$DemChoice" -eq "2" ]
			then
			pacman -Syy zsh zsh-syntax-highlighting xcompmgr transset-df xscreensaver xorg-server vim xorg-server-utils feh xorg-font-util xorg-xinit xterm i3-wm i3status dmenu ttf-dejavu xf86-video-vesa xf86-input-synaptics firefox rxvt-unicode urxvt-perls --noconfirm
		
		elif [ "$DemChoice" -eq "3" ]
			then
			pacman -Syy cinnamon xorg-server xorg-server-utils xorg-font-util xorg-xinit xterm ttf-dejavu xf86-video-vesa xf86-input-synaptics firefox --noconfirm
		
		elif [ "$DemChoice" -eq "4" ]
			then
			pacman -Syy xorg-server feh xorg-server-utils xorg-font-util xorg-xinit xterm ttf-dejavu xf86-video-vesa xf86-input-synaptics firefox abs dmenu --noconfirm
		
		elif [ "$DemChoice" -eq "5" ]
			then
			pacman -Syy awesome xorg-server xorg-server-utils xorg-font-util xorg-xinit xterm ttf-dejavu xf86-video-vesa xf86-input-synaptics firefox  --noconfirm
		
		elif [ "$DemChoice" -eq "6" ]
			then
			pacman -Syy gnome gnome-extra xorg-server xorg-server-utils xorg-font-util xorg-xinit xterm ttf-dejavu xf86-video-vesa xf86-input-synaptics firefox  --noconfirm
		elif [ "$DemChoice" -eq "7" ]
			then
			pacman -Syy kde xorg-server xorg-server-utils xorg-font-util xorg-xinit xterm ttf-dejavu xf86-video-vesa xf86-input-synaptics firefox --noconfirm
		
		else
			printf "\033[1m ${yellow}Choice not understood... ${red}Exiting \033[0m"
			sleep 5
			exit
		fi
}


xseti3() {
	X -configure 2> /dev/null
	if [ -f "$HOME/xorg.conf.new" ]
		then
		cp "$HOME/xorg.conf.new" "$HOME/xorg.conf"
		rm "$HOME/xorg.conf.new"
	fi
	if [ "$DemChoice" -eq "2" ] 
		then
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


envset() {
		cp /etc/skel/.xinitrc /home/"$namebro"/
		chown "$namebro":"$namebro" /home/"$namebro"/.xinitrc
		if [ "$DemChoice" -eq "1" ]
			then
			if [ -f /home/"$namebro"/.xinitrc ]
				then
				printf "\033[1m \n\n ${yellow}Commenting Out Stuff for 2nd WM/DE in .xinitrc \n\033[0m"
				sleep 4
				sed -i '13i #exec startxfce4' /home/"$namebro"/.xinitrc
			fi
		elif [ "$DemChoice" -eq "2" ]
			then
			if [ -f /home/"$namebro"/.xinitrc ]
				then
				wget https://raw.githubusercontent.com/i3-Arch/i3config/master/.Xresources
				wget https://raw.githubusercontent.com/i3-Arch/i3config/master/.zshrc
				wget https://raw.githubusercontent.com/i3-Arch/i3config/master/.vimrc
				cp .Xresources .zshrc .xinitrc .vimrc /home/"$namebro"/
				cp -r .i3 /home/"$namebro"/
				chown "$namebro":"$namebro" /home/"$namebro"/.i3
				chown "$namebro":"$namebro" /home/"$namebro"/.i3/config
				chown "$namebro":"$namebro" /home/"$namebro"/.Xresources
				chown "$namebro":"$namebro" /home/"$namebro"/.vimrc
				chown "$namebro":"$namebro" /home/"$namebro"/.zshrc
				chown "$namebro":"$namebro" /home/"$namebro"/.xinitrc
				printf "\033[1m \n\n ${yellow}Commenting Out Stuff for i3-Setup in .xinitrc \n\033[0m"
				sleep 4
				sed -i '13i #UNCOMMENT pa-applet ; xscreensaver ; xcompmgr ; xrdb ; exec i3 ; if planning to use i3' /home/"$namebro"/.xinitrc
				sed -i '14i #exec pa-applet &' /home/"$namebro"/.xinitrc
				sed -i '15i #exec xscreensaver &' /home/"$namebro"/.xinitrc
				sed -i '16i #xcompmgr -c -f -r 28 D 10 &' /home/"$namebro"/.xinitrc
				sed -i '17i #xrdb merge ./.Xresources' /home/"$namebro"/.xinitrc
				sed -i '18i #exec i3' /home/"$namebro"/.xinitrc
			fi
		elif [ "$DemChoice" -eq "3" ]
			then
			if [ -f /home/"$namebro"/.xinitrc ]
				then
				printf "\033[1m\n\n ${yellow} Commenting Out 2nd WM/DE in .xinitrc \n\033]0m"
				sleep 4
				sed -i '13i #exec cinnamon-session' /home/"$namebro"/.xinitrc
			fi
		elif [ "$DemChoice" -eq "4" ]
			then
			if [ -f /home/"$namebro"/.xinitrc ]
				then
				printf "\033[1m \n\n ${yellow} Commenting Out 2nd WM/DE in .xinitrc \n\033[0m"
				sleep 4
				sed -i '13i #exec dwm' /home/"$namebro"/.xinitrc
				abs community/dwm
				cp -r /var/abs/community/dwm /home/"$namebro"/dwm
				chown "$namebro":"$namebro" /home/"$namebro"/dwm
				chown "$namebro":"$namebro" /home/"$namebro"/dwm/*
				su "$namebro" -c "cd /home/"$namebro"/dwm && makepkg"
				pacman -U /home/"$namebro"/dwm/*.tar.xz --noconfirm
			fi
		elif [ "$DemChoice" -eq "5" ]
			then
			if [ -f /home/"$namebro"/.xinitrc ]
				then
				printf "\033[1m \n\n ${yellow}Commenting Out 2nd WM/DE in .xinitrc \n\033[0m"
				sleep 4
				sed -i '13i #exec awesome' /home/"$namebro"/.xinitrc
			fi
		elif [ "$DemChoice" -eq "6" ]
			then
			if [ -f /home/"$namebro"/.xinitrc ]
				then
				printf "\033[1m \n\n ${yellow}Commenting Out 2nd WM/DE in .xinitrc \n\033[0m"
				sleep 4
				sed -i '13i #exec gnome-session' /home/"$namebro"/.xinitrc
			fi	
		elif [ "$DemChoice" -eq "7" ]
			then
			if [ -f /home/"$namebro"/.xinitrc ]
				then
				printf "\033[1m \n\n ${yellow}Commenting Out 2nd WM/DE in .xinitrc \n\033[0m"
				sleep 4
				sed -i '13i #exec startkde' /home/"$namebro"/.xinitrc
			fi
		
		fi
}



urxvtstuff() {
	clear
	if [ "$DemChoice" -eq 2 ]
		then
		clear
		printf "\033[1m\n\n${green}Setting up urxvt for custom i3 setup\n\033[0m"
		printf "\033[1m\n ${yellow}And changing shell to zsh for your user\n\033[0m"
		sleep 2
		if [ ! -d /home/"$namebro"/build-dir ]
			then
			su "$namebro" -c "mkdir /home/"$namebro"/build-dir"
		fi
		pacman -Syy git xorg-xlsfonts flac  gtk3 json-c libasyncns libnotify libogg libpulse libsndfile libvorbis --noconfirm
		su "$namebro" -c "cd /home/"$namebro"/build-dir && wget https://aur.archlinux.org/packages/ur/urxvt-tabbedex/urxvt-tabbedex.tar.gz && tar xzvf urxvt-tabbedex.tar.gz"
		su "$namebro" -c "cd /home/"$namebro"/build-dir/urxvt-tabbedex && makepkg -s"
		pacman -U /home/"$namebro"/build-dir/urxvt-tabbedex/*.xz --noconfirm
		su "$namebro" -c "cd /home/"$namebro"/build-dir && wget https://aur.archlinux.org/packages/oh/oh-my-zsh-git/oh-my-zsh-git.tar.gz && tar xzvf oh-my-zsh-git.tar.gz"
		su "$namebro" -c "cd /home/"$namebro"/build-dir/oh-my-zsh-git && makepkg -s"
		pacman -U /home/"$namebro"/build-dir/oh-my-zsh-git/*.xz --noconfirm
		su "$namebro" -c "cd /home/"$namebro"/build-dir && wget https://aur.archlinux.org/packages/ur/urxvt-vtwheel/urxvt-vtwheel.tar.gz && tar xzvf urxvt-vtwheel.tar.gz"
		su "$namebro" -c "cd /home/"$namebro"/build-dir/urxvt-vtwheel && makepkg -s"
		pacman -U /home/"$namebro"/build-dir/urxvt-vtwheel/*.xz --noconfirm
		su "$namebro" -c "cd /home/"$namebro"/build-dir && wget https://aur.archlinux.org/packages/ur/urxvt-font-size-git/urxvt-font-size-git.tar.gz && tar xzvf urxvt-font-size-git.tar.gz"
		su "$namebro" -c "cd /home/"$namebro"/build-dir/urxvt-font-size-git && makepkg -s"
		pacman -U /home/"$namebro"/build-dir/urxvt-font-size-git/*.xz --noconfirm
		su "$namebro" -c "cd /home/"$namebro"/build-dir && wget https://aur.archlinux.org/packages/pa/pa-applet-git/pa-applet-git.tar.gz && tar xzvf pa-applet-git.tar.gz"
		su "$namebro" -c "cd /home/"$namebro"/build-dir/pa-applet-git && makepkg -s"
		pacman -U /home/"$namebro"/build-dir/pa-applet-git/*.xz --noconfirm
		su "$namebro" -c "cd /home/"$namebro"/build-dir && wget https://aur.archlinux.org/packages/pr/prezto-git/prezto-git.tar.gz && tar xzvf prezto-git.tar.gz"
		su "$namebro" -c "cd /home/"$namebro"/build-dir/prezto-git && makepkg -s"
		pacman -U /home/"$namebro"/build-dir/prezto-git/*.xz --noconfirm
		su "$namebro" -c "cd /home/"$namebro"/build-dir && wget https://aur.archlinux.org/packages/xc/xcursor-ecliz-arch/xcursor-ecliz-arch.tar.gz && tar xzvf xcursor-ecliz-arch.tar.gz"
		su "$namebro" -c "cd /home/"$namebro"/build-dir/xcursor-ecliz-arch && makepkg -s"
		if [ $(uname -m) = x86_64 ]
			then
			pacman -U /home/"$namebro"/build-dir/xcursor-ecliz-arch/*x86_64*.xz --noconfirm
		else
			pacman -U /home/"$namebro"/build-dir/xcursor-ecliz-arch/*i686*.xz --noconfirm
		fi
		clear
		printf "\033[1m\n${green}Enter your ${red}USER PASSWORD${yellow} ( Changing Shell to ZSH )\n\033[0m"
		su "$namebro" -c "chsh -s $(which zsh)"
		rm -rf /home/"$namebro"/build-dir
		printf "\033[1m \n\n ${green}Setting up wallpaper in ${red} /home/"$namebro"/.wallpapers \033[0m"
		su "$namebro" -c "mkdir /home/"$namebro"/.wallpapers && cd /home/"$namebro"/.wallpapers && wget https://raw.githubusercontent.com/i3-Arch/i3config/master/wallpaper.png"
		su "$namebro" -c "cd /home/"$namebro" && echo "'feh --bg-scale ~/.wallpapers/wallpaper.png'" > .fehbg"
	fi
}


main() {
	checkroot
	banner
	makeitbro
	xseti3
	envset
	urxvtstuff
	rm another.sh
	printf "\033[1m ${yellow}Rebooting now \n\n\033[0m"
	sleep 2
	printf "\033[1m\n ${red}3${white}...\n\033[0m"
	sleep 1
	printf "\033[1m ${red}2${white}..\n\033[0m"
	sleep 1
	printf "\033[1m ${red}1${white}.\n\033[0m"
	$(reboot)
}


main

#EOF
