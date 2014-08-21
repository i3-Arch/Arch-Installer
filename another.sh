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
			rm -f index.html
			pacman -Syyu --noconfirm
		else
			printf "\033[1m \n\n${red}Offline ${white}- ${yellow}wait 8 seconds...\n\033[0m"
			sleep 8
			wget -q --tries=5 --timeout=20 https://google.com
			if [[ "$?" -eq 0 ]]
				then
				printf "\033[1m ${green} \n\n  Cool... Lets do this \n\n\033[0m"
				rm -f index.html
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
			pacman -Syy xfce4 xfce4-goodies --noconfirm
		elif [ "$DemChoice" -eq "2" ]
			then
			pacman -Syy conky vimpager zsh zsh-syntax-highlighting xcompmgr transset-df xscreensaver vim feh i3-wm i3status dmenu rxvt-unicode urxvt-perls --noconfirm
		
		elif [ "$DemChoice" -eq "3" ]
			then
			pacman -Syy cinnamon --noconfirm
		
		elif [ "$DemChoice" -eq "4" ]
			then
			pacman -Syy feh abs dmenu --noconfirm
		
		elif [ "$DemChoice" -eq "5" ]
			then
			pacman -Syy awesome --noconfirm
		
		elif [ "$DemChoice" -eq "6" ]
			then
			pacman -Syy gnome gnome-extra --noconfirm
		elif [ "$DemChoice" -eq "7" ]
			then
			pacman -Syy kde --noconfirm
		
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
		wget https://raw.githubusercontent.com/i3-Arch/i3config/master/.i3/conky-i3bar
		wget https://raw.githubusercontent.com/i3-Arch/i3config/master/.i3/.conkyrc
		if [ -f "$HOME/.i3/config" ]
			then
			rm -rf ~/.i3
			mkdir -pv ~/.i3/conky
			mv config ~/.i3/config
			mv .conkyrc ~/.i3/conky/
			mv conky-i3bar ~/.i3/conky/
		else
			mkdir -pv ~/.i3/conky
			mv .conkyrc ~/.i3/conky/
			mv conky-i3bar ~/.i3/conky/
			mv config ~/.i3/config
		fi
	fi
}


envset() {
		chown "$namebro":"$namebro" /home/"$namebro"/.xinitrc
		if [ "$DemChoice" -eq "1" ]
			then
			if [ -f /home/"$namebro"/.xinitrc ]
				then
				printf "\033[1m \n\n ${yellow}Commenting Out Stuff for 2nd WM/DE in .xinitrc \n\033[0m"
				sleep 4
				sed -i '13i\ ' /home/"$namebro".xinitrc
				sed -i '14i #exec startxfce4' /home/"$namebro"/.xinitrc
			fi
		elif [ "$DemChoice" -eq "2" ]
			then
			if [ -f /home/"$namebro"/.xinitrc ]
				then
				if [ ! -f /home/"$namebro"/.Xresources ]
					then
					wget https://raw.githubusercontent.com/i3-Arch/i3config/master/.Xresources
				fi
				wget https://raw.githubusercontent.com/i3-Arch/i3config/master/.zshrc
				wget https://raw.githubusercontent.com/i3-Arch/i3config/master/.vimrc
				cp .Xresources .zshrc .vimrc /home/"$namebro"/
				cp -r .i3 /home/"$namebro"/
				chmod +x /home/"$namebro"/.i3/conky-i3bar
				chmod +x /home/"$namebro"/.i3/.conkyrc
				chown "$namebro":"$namebro" /home/"$namebro"/.i3/conky
				chown "$namebro":"$namebro" /home/"$namebro"/.i3/conky/conky-i3bar
				chown "$namebro":"$namebro" /home/"$namebro"/.i3/conky/.conkyrc
				chown "$namebro":"$namebro" /home/"$namebro"/.i3
				chown "$namebro":"$namebro" /home/"$namebro"/.i3/config
				chown "$namebro":"$namebro" /home/"$namebro"/.Xresources
				chown "$namebro":"$namebro" /home/"$namebro"/.vimrc
				chown "$namebro":"$namebro" /home/"$namebro"/.zshrc
				printf "\033[1m \n\n ${yellow}Commenting Out Stuff for i3-Setup in .xinitrc \n\033[0m"
				sleep 4
				sed -i '13i\ ' /home/"$namebro"/.xinitrc
				sed -i '14i #UNCOMMENT -> xscreensaver ; xcompmgr ; xrdb ; if planning to use i3' /home/"$namebro"/.xinitrc
				sed -i '15i #exec xscreensaver &' /home/"$namebro"/.xinitrc
				sed -i '16i #xcompmgr -c -f -r 28 D 10 &' /home/"$namebro"/.xinitrc
				sed -i '17i #xrdb -merge .Xresources' /home/"$namebro"/.xinitrc
				sed -i '18i #exec i3' /home/"$namebro"/.xinitrc
			fi
		elif [ "$DemChoice" -eq "3" ]
			then
			if [ -f /home/"$namebro"/.xinitrc ]
				then
				printf "\033[1m\n\n ${yellow} Commenting Out 2nd WM/DE in .xinitrc \n\033]0m"
				sleep 4
				sed -i '13i\ ' /home/"$namebro"/.xinitrc
				sed -i '14i #exec cinnamon-session' /home/"$namebro"/.xinitrc
			fi
		elif [ "$DemChoice" -eq "4" ]
			then
			if [ -f /home/"$namebro"/.xinitrc ]
				then
				printf "\033[1m \n\n ${yellow} Commenting Out 2nd WM/DE in .xinitrc \n\033[0m"
				sleep 4
				sed -i '13i\ ' /home/"$namebro"/.xinitrc
				sed -i '14i #exec dwm' /home/"$namebro"/.xinitrc
				sed -i '15i #xrdb -merge .Xresources' /home/"$namebro"/.xinitrc
				if [ ! -f /home/"$namebro"/.Xresources ] 
					then
					wget https://raw.githubusercontent.com/i3-Arch/i3config/master/.Xresources
				fi
				mv ~/.Xresources /home/"$namebro"/
				chown "$namebro":"$namebro" /home/"$namebro"/.Xresources
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
				sed -i '13i\ ' /home/"$namebro"/.xinitrc
				sed -i '14i #exec awesome' /home/"$namebro"/.xinitrc
			fi
		elif [ "$DemChoice" -eq "6" ]
			then
			if [ -f /home/"$namebro"/.xinitrc ]
				then
				printf "\033[1m \n\n ${yellow}Commenting Out 2nd WM/DE in .xinitrc \n\033[0m"
				sleep 4
				sed -i '13i\ ' /home/"$namebro"/.xinitrc
				sed -i '14i #exec gnome-session' /home/"$namebro"/.xinitrc
			fi	
		elif [ "$DemChoice" -eq "7" ]
			then
			if [ -f /home/"$namebro"/.xinitrc ]
				then
				printf "\033[1m \n\n ${yellow}Commenting Out 2nd WM/DE in .xinitrc \n\033[0m"
				sleep 4
				sed -i '13i\ ' /home/"$namebro"/.xinitrc
				sed -i '14i #exec startkde' /home/"$namebro"/.xinitrc
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
	printf "\033[1m ${yellow}You Most Likely Need To Reboot \n\n\033[0m"
	sleep 3
}


main

#EOF
