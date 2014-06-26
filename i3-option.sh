#!/bin/bash
#
#  Made To Setup i3
#
#  Author: i3-Arch
#
###############################################
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
	printf " \n \n   :: Lets Do This ::  \n \n   "
	printf " \n \n 		#SWAG	      \n \n  "
}

makeitbro() {
	if [ $(id -u) -eq 0 ]
		then
		printf " \n You will need to create a user and move these dotfiles \n"
		printf " to your user's home dir \n"
		printf " \n .Xresources \n .xinitrc \n .zshrc \n .vimrc \n"
		pacman -Syyu --noconfirm
		pacman -S base-devel wget xorg-server xorg-server-utils feh xorg-font-util xorg-xinit xterm i3-wm i3status dmenu ttf-dejavu xf86-video-vesa xf86-input-synaptics firefox rxvt-unicode urxvt-perls --noconfirm
		else
		printf " \n Everything Seems Fine \n "
		printf " \n \n Enter Password for root ( installing packages ) \n"
		su root
		pacman -Syyu --noconfirm
		pacman -S base-devel xorg-server wget xorg-server-utils feh xorg-font-util xorg-xinit xterm i3-wm i3status dmenu ttf-dejavu xf86-video-vesa xf86-input-synaptics firefox rxvt-unicode urxvt-perls --noconfirm	
		exit
	fi
}

xseti3() {
	X -configure
	if [ -f "$HOME/xorg.conf.new" ]
		then
			cp "$HOME/xorg.conf.new" "$HOME/xorg.conf"
			rm "$HOME/xorg.conf.new"
		else
			printf " \n Where is xorg.conf.new ? -- skipping \n"
	fi

		printf " \n Setting Up i3 config in ~/.i3/config \n "

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
}

i3fin() {
	printf " \n Setting up .Xresources, .vimrc and .xinitrc \n "

		wget https://raw.githubusercontent.com/i3-Arch/i3config/master/.Xresources
		wget https://raw.githubusercontent.com/i3-Arch/i3config/master/.xinitrc
		wget https://raw.githubusercontent.com/i3-Arch/i3config/master/.zshrc
		wget https://raw.githubusercontent.com/i3-Arch/i3config/master/.vimrc
}

main() {
	banner
	greetz
	makeitbro
	xseti3
	i3fin
	
	printf " \n EXTRA TIP :: In the future you will need to Run ' startx :: \n "
}

main
