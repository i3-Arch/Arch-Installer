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
			printf "\n Did you use our Arch-Installer ?\n\n"
			printf "\n\n [Y/N]"
			printf "\n Answer: "
			read wutUdoBro
				if	[ "$wutUdoBro" == Y -o "$wutUdoBro" == y ]
					then
						printf "\n\n Option 1: Install default xfce setup \n"
						printf "\n\n Option 2: Install our CUSTOM i3 setup\n\n"
						printf "\n Choose 1 or 2: "
						read DemChoice
						if [ "$DemChoice" == 1 ]
							then
								pacman -Syy zsh wget xorg-server xorg-server-utils xorg-font-util xorg-xinit xterm ttf-dejavu xf86-video-vesa xf86-input-synaptics firefox rxvt-unicode urxvt-perls --noconfirm
							else
					pacman -Syy zsh wget xorg-server xorg-server-utils feh xorg-font-util xorg-xinit xterm i3-wm i3status dmenu ttf-dejavu xf86-video-vesa xf86-input-synaptics firefox rxvt-unicode urxvt-perls --noconfirm
					printf " \n You will need to create a user and move these dotfiles \n"
					printf " to your user's home dir \n"
					printf " \n .Xresources \n .xinitrc \n .zshrc \n .vimrc \n"
						fi
			fi
		else
		printf "\n\n Option 1: Install Default XFCE Setup \n\n"
		printf "\n\n Option 2: Install CUSTOM i3 Setup \n\n"
		printf "\n Choose 1 or 2: "
		read DoYouEven
			if [ "$DoYouEven" == 1 ]
				then
					printf "\n\n Enter Password for root ( installing packages ) \n\n"
					printf "\n Enter Pass: "
					su root
					pacman -Syy base-devel zsh xorg-server wget xorg-server-utils xorg-font-util xorg-xinit xterm ttf-dejavu xf86-video-vesa xf86-input-synaptics firefox rxvt-unicode urxvt-perls --noconfirm
				else
		printf " \n \n Enter Password for root ( installing packages ) \n"
		printf "\n Enter Pass: "
		su root
		pacman -Syy base-devel zsh xorg-server wget xorg-server-utils feh xorg-font-util xorg-xinit xterm i3-wm i3status dmenu ttf-dejavu xf86-video-vesa xf86-input-synaptics firefox rxvt-unicode urxvt-perls --noconfirm	
		exit
		  	fi
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
		if [ "$DoYouEven" == 2 -o "$DemChoice" == 2 ] 
			then
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
		fi
}

i3fin() {
	if [ "$DoYouEven" == 2 ]
		then
			printf " \n Setting up .Xresources, .vimrc and .xinitrc \n "
			wget https://raw.githubusercontent.com/i3-Arch/i3config/master/.Xresources
			wget https://raw.githubusercontent.com/i3-Arch/i3config/master/.xinitrc
			wget https://raw.githubusercontent.com/i3-Arch/i3config/master/.zshrc
			wget https://raw.githubusercontent.com/i3-Arch/i3config/master/.vimrc
	fi
}

guestbro() {
	printf "\n Are you using virtualbox ? \n\n"
	printf " \n [Y/N] \n"
	printf " \n Answer: "
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
	printf " \n EXTRA TIP :: In the future you will need to Run ' startx :: \n "
}

main
