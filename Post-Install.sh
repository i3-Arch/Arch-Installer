#!/bin/bash
#
#	 POST INSTALL SCRIPT
# 				-  i3-Arch
lemmeknow() {
	if [ $(id -u) -eq 0 ]
		then
    		needpass
		else
		printf " \n Moving on since you already have a user account \n"
	fi
}

needpass() {
	clear
	printf " \n Would you like to set a root password ?\n \n"
	printf " [Y|N] \n"
	printf " \n \n Answer: "
	read wutdawg
	if [ "$wutdawg" = Y -o "$wutdawg" = y ]
		then
		passwd
		usersetup
		else
		printf " \n Ok, Moving on then.... \n "
		usersetup
	fi
}

usersetup() {
	if [ $(id -u) -eq 0 ]
		then
			printf " \n Would you like to setup a USER now ? \n \n"
			printf " \n [Y|N] \n "
			printf " \n \n Answer: "
			read usernowbro
			if	[ "$usernowbro" = Y -o "$usernowbro" = y ]
				then
				printf " \n \n Enter The Username to Create ! \n"
				printf " \n Username: "
				read thenameuneed
				$(useradd -m -G disk,audio,network,video $thenameuneed)
				printf " \n \n Set a Password for this USER ? \n \n"
				printf " [Y|N] \n \n"
				read cuzuwanna
				if	[ "$cuzuwanna" = Y -o "$cuzuwanna" = y ]
					then
					passwd $thenameuneed
					else
					printf "\n Moving on \n"
				fi
			fi
		else
		printf " \n Sorry You Are Not Root \n "
	fi
}

main() {
	lemmeknow
}
main
