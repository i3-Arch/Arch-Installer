#/bin/bash
###############
##  i3-Arch  ##
###############

CheckIt() {
	if [ "$(id -u)" -ne 0 ]
		then
		printf "\n\nYou need to be root\n\n"
		sleep 5
		exit
	fi
}


Greet() {
	printf "####################################################"
	printf "##  Lets connect to your Wireless Access Point  \n##"
	printf "##	    Choosing WPA/WPA2 by Default        \n##"
	printf "##   	       * May Update Later * 	        \n##"
	printf "####################################################"
}

ProName(){
	printf "	Enter what you want your profile to be called\n"
	printf "\n		Profile Name: "
	read profileName
	touch /etc/netctl/"$profileName"
}

IpType() {
	printf "Would you like to use DHCP or STATIC Address?\n"
	printf "			*Default is DHCP*\n"
	printf "\nChoices:   [1] Static \n"
	printf "			 [2] DHCP"
	printf "\nAddress Type: "
	read addressType
		if [ "$addressType" -eq "1" ]
			then
			printf "\nEnter Static IP with Subnet mask\n"
			printf "\nExample: 192.168.0.100/24"
			printf "\n\n	My IP: "
			read myAddress
			echo "IP=static" >> /etc/netctl/"$profileName"
			echo "Address='$myAddress'" >> /etc/netctl/"$profileName"
			printf "\nEnter your Gateway\n"
			printf "\nExample: 192.168.0.1 \n"
			printf "Gateway: "
			read gateWay
			echo "Gateway='"$gateWay"'" >> /etc/netctl/"$profileName"
			printf "Enter DNS server \n"
			printf "Example:   8.8.8.8 \n"
			printf "DNS: "
			read datDns
			echo "DNS=('"$datDns"')" >> /etc/netctl/"$profileName"
		else
			echo "IP=dhcp" >> /etc/netctl/"$profileName"		
		fi	
}

NetworkStuff() {
	printf "\n\n	Enter your SSID: "
	read yourSSID
	printf "\n\n is your SSID hidden? \n"		
	printf "Choices:    [1] Yes\n"
	printf "			[2] No \n"
	printf "\nChoice: "
	read datch
		if [ "$datch" -eq "1" ] 
			then
			echo "Hidden=yes" >> /etc/netctl/"$profileName"
		fi
	echo "Interface=wlp2s0" >> /etc/netctl/"$profileName"
	echo "Connection=wireless" >> /etc/netctl/"$profileName"
	echo "ESSID='"$yourSSID"'" >> /etc/netctl/"$profileName"
	echo "Security=wpa" >> /etc/netctl/"$profileName"
	printf "Enter the key for your network \n\n"
	printf "Key: "
	read -s yourKey
	echo "Key='"$yourKey"'" >> /etc/netctl/"$profileName"

}

AutoStart() {
	printf "\nWould you like to autostart this network at boot? \n"
	printf "Choices:	[1] Yes\n"
	printf "			[2] No\n"
	read yourChoi
		if [ "$yourChoi" -eq "1" ]
			then
			netctl start "$profileName"
			netctl enable "$profileName"
		else
			netctl start "$profileName"
		fi
}

Main() {
	CheckIt
	Greet
	ProName
	IpType
	NetworkStuff
	AutoStart
}

Main

#EOF
