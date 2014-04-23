#!/bin/bash 
#
#  Made To Setup i3
#
#  Author: i3-Arch
#
###############################################
greetz() {
	cd ~
	printf " \n \n   :: Lets Do This ::  \n \n   "
	printf " \n \n 		#SWAG	      \n \n  "
}


makeitbro() {
	pacman -Syyu --noconfirm
	pacman -S base-devel xorg-server xorg-server-utils feh xorg-font-util xorg-xinit xterm i3-wm i3status dmenu ttf-dejavu xf86-video-vesa xf86-input-synaptics firefox rxvt-unicode urxvt-perls --noconfirm
}


xseti3() {
	X -configure
	if [ "$HOME/xorg.conf.new" ]
		then
			$(cp $HOME/xorg.conf.new $HOME/xorg.conf)
			$(rm $HOME/xorg.conf.new)
		else
			echo
			echo " where is xorg.conf.new ? -- skipping"
	fi

		printf " \n Setting Up i3 config in ~/.i3/config \n "
	
	wget https://raw.githubusercontent.com/i3-Arch/i3config/master/.i3/config
	
	if [ "$HOME/.i3/config" ]
		then
			echo " $(rm -rf ~/.i3) "
			echo " $(mkdir ~/.i3) "
			echo " $(mv config ~/.i3/config) "
		else 
			echo " $(mkdir ~/.i3) "
			echo " $(mv config ~/.i3/config) "
	fi
}


i3fin() {
	printf " \n Setting up .Xresources, .vimrc and .xinitrc \n "
		
		wget https://raw.githubusercontent.com/i3-Arch/i3config/master/.Xresources
		wget https://raw.githubusercontent.com/i3-Arch/i3config/master/.xinitrc
		wget https://raw.githubusercontent.com/i3-Arch/i3config/master/.zshrc
		wget https://raw.githubusercontent.com/i3-Arch/i3config/master/.vimrc

	printf " \n NOW STARTING X \n"
	printf " \n TIP :: In the future you will need to Run ' startx :: \n "
		
		sleep 3 &&
		$(startx)
}


main() {
	greetz
	makeitbro
	xseti3
	i3fin
}
main
