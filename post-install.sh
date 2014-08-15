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

intelinside() {
	printf "\033[1m \n\n${green}Are you using intel ?? \033[0m"	
	printf "\033[1m \n ${white}[${green}Y${white}|${red}N${white}] \033[0m"
	printf "\033[1m \n\n${yellow}Answer: ${white}\033[0m"
	read intelstuff
	if [ "$intelstuff" == Y -o "$intelstuff" == y ]
		then
		pacman -S intel-dri xf86-video-intel --noconfirm
	
	else
		printf "\033[1m \n\n ${green}Are you using AMD ? \n\033[0m"
		printf "\033[1m \n ${white}[${green}Y${white}|${red}N${white}] \033[0m"
		printf "\033[1m \n ${yellow}Answer: ${white}\033[0m"
		read amdstuff
		if [ "$amdstuff" == Y -o "$amdstuff" == y ]
			then
			pacman -S ati-dri xf86-video-ati
		fi
	fi
}


mirrorselect() {
		printf "\033[1m ${green} \n\n Select Your Mirrors ?\n\n \033[0m"
		printf "\033[1m ${white}[${green}Y${white}|${red}N${white}]\033[0m"
		printf "\033[1m \n\n${yellow}Choice: ${white}\033[0m"
		read mirrorsyo
		if [ "$mirrorsyo" == Y -o "$mirrorsyo" == y ]
			then
			if [ -f /etc/pacman.d/mirrorlist.pacnew ]
				then
				cp /etc/pacman.d/mirrorlist.pacnew /etc/pacman.d/mirrorlist
			fi
			printf "\033[1m${red}\n ctrl+x to exit nano \n\n\033[0m"
			sleep 3
			nano /etc/pacman.d/mirrorlist
		else
			printf "\033[1m ${green} Ok... Skipping \033[0m"
			sleep 1
		fi
}


needpass() { 
	clear
	printf "\033[1m \n ${yellow} Set a ROOT password \n\n \033[0m"
	passwd
}


usersetup() {
		clear
		printf "\033[1m \n\n ${green} Lets create a user ! \n \033[0m"
		printf "\033[1m \n\n ${yellow} Enter username you want to create \n \033[0m"
		printf "\033[1m \n Username:${white} \033[0m"
		read namebro
		$(useradd -m -G adm,disk,audio,network,video "$namebro")
		printf "\033[1m \n\n ${yellow} Set a Password for this USER now \n\n \033[0m"
		passwd "$namebro"
		printf "\033[1m \n\n ${yellow}Would you like to add this user to sudoers? ( user ALL=(ALL) ALL ) \033[0m"
		printf "\033[1m \n\n ${white}[${green}Y${white}|${red}N${white}] \033[0m"
		printf "\033[1m\n\n ${red}Answer: ${white}\033[0m"
		read anot
		if [ "$anot" == Y -o "$anot" == y -o "$anot" == yes -o "$anot" == YES ]
			then
			echo -n "$namebro" "ALL=(ALL)" "ALL" >> /etc/sudoers
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
		printf "\033[1m \n\n  ${red} Understood... Have fun with ARCH ! \n\n \033[0m"
	fi
}


thankyoubro() {
	clear
	printf "\033[1m \n ${green} Thanks for being lazy and using our script ! \n \033[0m"
	printf "\033[1m \n ${yellow} If you have any problems afterwards \n \033[0m"
	printf "\033[1m \n ${red} Search The ARCHWIKI \n \n \033[0m"
	sleep 3
}


banner() {
cat <<"EOT"
     _____________________________
    !\___________________________/\
    !!                           !!\
    !!                           !! \
    !!        ARCHLINUX          !! !
    !!         IS DAT            !! !
    !!       MASTER RACE         !! !
    !!                           !! !
    !! lulz@arch~> hue	         !! !
    !! zsh:command not found:hue !! /
    !! 				 !!/
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
cd "$HOME"
printf "\033[1m \n\n ${green}  :: Lets Do This ::  \n\n\033[0m"
printf "\033[1m \n\n ${yellow}	#ARCHLINUX-SWAG	      \n\n\033[0m"
sleep 2
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
			pacman -Syy zsh vimpager conky zsh-syntax-highlighting xcompmgr transset-df xscreensaver xorg-server vim xorg-server-utils feh xorg-font-util xorg-xinit xterm i3-wm i3status dmenu ttf-dejavu xf86-video-vesa xf86-input-synaptics firefox rxvt-unicode urxvt-perls --noconfirm
		
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
		wget https://raw.githubusercontent.com/i3-Arch/i3config/master/.i3/conky/conky-i3bar
		wget https://raw.githubusercontent.com/i3-Arch/i3config/master/.i3/conky/.conkyrc
		if [ -f "$HOME/.i3/config" ]
			then
			rm -rf ~/.i3
			mkdir -pv ~/.i3/conky
			mv config ~/.i3/
			mv .conkyrc ~/.i3/conky/
			mv conky-i3bar ~/.i3/conky/
		else
			mkdir -pv ~/.i3/conky
			mv config ~/.i3/
			mv .conkyrc ~/.i3/conky/
			mv conky-i3bar ~/.i3/conky/
		fi
	fi
}


guestbro() {
		clear
		printf "\033[1m \n\n ${green}Are you using Virtualbox ? \n\n \033[0m"
		printf "\033[1m \n\n ${white}[${green}Y${white}|${red}N${white}] \n \033[0m"
		printf "\033[1m \n\n ${green}Answer: ${white}\033[0m"
		read wutUsay
		if [ "$wutUsay" == Y -o "$wutUsay" == y ]
			then
			pacman -Syy virtualbox-guest-utils --noconfirm
			depmod
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
				pacman -Syy svga-dri xf86-input-vmmouse xf86-video-vmware open-vm-tools --noconfirm
				cat /proc/version > /etc/arch-release
				systemctl start vmtoolsd
				systemctl enable vmtoolsd
			fi
		else
			printf "\033[1m \n\n${red}Did you type a ${yellow}'y' ${white}or a ${yellow}'n'${red} ? \033[0m"
			printf "\033[1m \n ${red}Moving on....\033[0m"
			sleep 2
		fi
}


envset() {
		cp /etc/skel/.xinitrc /home/"$namebro"/
		chown "$namebro":"$namebro" /home/"$namebro"/.xinitrc
		if [ "$DemChoice" -eq "1" ]
			then
			if [ -f /home/"$namebro"/.xinitrc ]
				then
				echo "exec startxfce4" >> /home/"$namebro"/.xinitrc
			
			fi
		elif [ "$DemChoice" -eq "2" ]
			then
			if [ -f /home/"$namebro"/.xinitrc ]
				then
				rm /home/"$namebro"/.xinitrc
				wget https://raw.githubusercontent.com/i3-Arch/i3config/master/.Xresources
				wget https://raw.githubusercontent.com/i3-Arch/i3config/master/.xinitrc
				wget https://raw.githubusercontent.com/i3-Arch/i3config/master/.zshrc
				wget https://raw.githubusercontent.com/i3-Arch/i3config/master/.vimrc
				cp .Xresources .zshrc .xinitrc .vimrc /home/"$namebro"/
				cp -r .i3 /home/"$namebro"/
				chmod +x /home/"$namebro"/.i3/conky/conky-i3bar
				chmod +x /home/"$namebro"/.i3/conky/conky-i3bar
				chown "$namebro":"$namebro" /home/"$namebro"/.i3
				chown "$namebro":"$namebro" /home/"$namebro"/.i3/config
				chown "$namebro":"$namebro" /home/"$namebro"/.i3/conky
				chown "$namebro":"$namebro" /home/"$namebro"/.i3/conky/.conkyrc
				chown "$namebro":"$namebro" /home/"$namebro"/.i3/conky/conky-i3bar
				chown "$namebro":"$namebro" /home/"$namebro"/.Xresources
				chown "$namebro":"$namebro" /home/"$namebro"/.vimrc
				chown "$namebro":"$namebro" /home/"$namebro"/.zshrc
				chown "$namebro":"$namebro" /home/"$namebro"/.xinitrc
			fi
		elif [ "$DemChoice" -eq "3" ]
			then
			if [ -f /home/"$namebro"/.xinitrc ]
				then
				echo "exec cinnamon-session" >> /home/"$namebro"/.xinitrc
			fi
		elif [ "$DemChoice" -eq "4" ]
			then
			if [ -f /home/"$namebro"/.xinitrc ]
				then
				echo "exec dwm" >> /home/"$namebro"/.xinitrc
				echo "xrdb merge .Xresources" >> /home/"$namebro"/.xinitrc
				wget https://raw.githubusercontent.com/i3-Arch/i3config/master/.Xresources
				mv ~/.Xresources /home/"$namebro"/
				abs community/dwm
				cp -r /var/abs/community/dwm /home/"$namebro"/dwm
				chown "$namebro":"$namebro" /home/"$namebro"/dwm
				chown "$namebro":"$namebro" /home/"$namebro"/dwm/*
				chown "$namebro":"$namebro" /home/"$namebro"/.Xresources
				su "$namebro" -c "cd /home/"$namebro"/dwm && makepkg"
				pacman -U /home/"$namebro"/dwm/*.tar.xz --noconfirm
			fi
		elif [ "$DemChoice" -eq "5" ]
			then
			if [ -f /home/"$namebro"/.xinitrc ]
				then
				echo "exec awesome" >> /home/"$namebro"/.xinitrc
			fi
		elif [ "$DemChoice" -eq "6" ]
			then
			if [ -f /home/"$namebro"/.xinitrc ]
				then
				echo "exec gnome-session" >> /home/"$namebro"/.xinitrc
			fi	
		elif [ "$DemChoice" -eq "7" ]
			then
			if [ -f /home/"$namebro"/.xinitrc ]
				then
				echo "exec startkde" >> /home/"$namebro"/.xinitrc
			fi
		
		fi
}


loginmanage() {
	if [ "$DemChoice" -eq "1" -o "$DemChoice" -eq "2" -o "$DemChoice" -eq "3" -o "$DemChoice" -eq "4" -o "$DemChoice" -eq "5" ]
		then
		clear
		printf "\033[1m \n\n ${green}Would you like to enable slim ? \n\n \033[0m"
		printf "\033[1m \n\n ${white}[${green}Y${white}|${red}N${white}] \n\n \033[0m"
		printf "\033[1m \n ${green}Answer: ${white}\033[0m"
		read slimok
		if [ "$slimok" == Y -o "$slimok" == y ]
			then
			pacman -Syy slim --noconfirm
			systemctl enable slim.service
			printf "\033[1m ${red}\nReboot to take effect \n\n\033[0m"
			sleep 1
		else
			printf "\033[1m \n ${yellow}EXTRA TIP ${green}:: ${red}In the future you will need to Run  ${yellow}startx ${green}:: \n \033[0m"
		fi	
	elif [ "$DemChoice" -eq "6" ]
		then
		clear
		printf "\033[1m \n\n ${green}Would you like to enable Gdm ? \n\n\033[0m"
		printf "\033[1m \n\n ${white}[${green}Y${white}|${red}N${white}] \n\n\033[0m"
		printf "\033[1m \n ${green}Answer: ${white}\033[0m"
		read gdmok
		if [ "$gdmok" == Y -o "$gdmok" == y ]
			then
			systemctl enable gdm.service
			printf "\033[1m ${red}\n Reboot to take effect \n\n\033[0m"
			sleep 1
		fi
	elif [ "$DemChoice" -eq "7" ]
		then
		clear
		printf "\033[1m \n\n ${green} Would you like to enable Kdm ?\n\n\033[0m"
		printf "\033[1m \n\n ${white}[${green}Y${white}|${red}N${white}] \n\n\033[0m"
		printf "\033[1m \n ${green}Answer: ${white}\033[0m"
		read kdmok
		if [ "$kdmok" == Y -o "$kdmok" == y ]
			then
			systemctl enable kdm.service
			printf "\033[1m ${red}\nReboot to take effect \033[0m" 
			sleep 1
		fi	
	fi

}


bobthebuilder() {  
	clear
	printf "\033[1m\n\n ${green}Would you like to setup pacaur ? \n\033[0m"
	printf "\033[1m\n\n ${white}It's an ${red}AUR ${white}helper with cower backend \n\n\033[0m"
	printf "\033[1m\n\n${white}[${green}Y${white}|${red}N${white}]\n\n\033[0m"
	printf "\033[1m\n\n${red}Answer: ${white}\033[0m"
	read thatquestion
	if [ "$thatquestion" == Y -o "$thatquestion" == y ]
		then
		printf "\033[1m\n\n ${green}Setting up pacaur for future use \n\n\033[0m"
		pacman -Syy expac yajl --noconfirm
		su "$namebro" -c "mkdir /home/"$namebro"/build-dir"
		su "$namebro" -c "cd /home/"$namebro"/build-dir && wget https://aur.archlinux.org/packages/co/cower/cower.tar.gz && tar xzvf cower.tar.gz"
		su "$namebro" -c "cd /home/"$namebro"/build-dir/cower && makepkg -s"
		pacman -U /home/"$namebro"/build-dir/cower/*.xz --noconfirm
		su "$namebro" -c "cd /home/"$namebro"/build-dir && wget https://aur.archlinux.org/packages/pa/pacaur/pacaur.tar.gz && tar xzvf pacaur.tar.gz"
		su "$namebro" -c "cd /home/"$namebro"/build-dir/pacaur && makepkg -s"
		pacman -U /home/"$namebro"/build-dir/pacaur/*.xz --noconfirm
		rm -rf /home/"$namebro"/build-dir
	else
		printf "\033[1m\n\n ${yellow}You entered no\n\033[0m"
		printf "\033[1m ${yellow}or an unexpected character \n\033[0m"
		printf "\033[1m\n ${red}Moving on... \n\033[0m"
		sleep 2
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


main2() {
	banner
	guestbro
	makeitbro
	xseti3
	envset
	loginmanage 
	bobthebuilder
	urxvtstuff
	intelinside
	printf "\033[1m ${red} You Most Likely Need To Reboot For Changes To Take Effect\n\033[0m"
}


main() {
	checkroot
	thankyoubro
	needpass
	usersetup
	mirrorselect
	uwantme
	sed -i '13i namebro="$namebro"' another.sh
}

main

#EOF
