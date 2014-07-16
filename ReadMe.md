# ABOUT
	       	==============================================
	       	+-------- Current Version:  1.2-BETA --------+
	       	==============================================
	       	
	       * This is made to install archlinux with base base/devel
			
			* And then optionally setup a WM/Environment afterwards 
			
	       	
	       
				[ NOTICE ]
					- CURRENTLY UNDER DEVELOPMENT
					- RUN AT YOUR OWN RISK
		

		---------- Grub Working    as of   6-10-2014   ------------

	___________________________________________________________________
	===================================================================


		              :: Authors ::
			
			 	*  i3-Arch
			  	* trewchainz
			  	*  t60r
			
			
		-----------THIS IS A WORK IN PROGRESS -----------

             i. ** FIRST YOU WILL NEED THE OFFICIAL ARCHLINUX IMAGE **
	 	i. ** BOOT INTO LIVE ARCH IMAGE **
			  
			  
	1. :DOWNLOAD: 
		       
		       wget https://goo.gl/4v5IyX -O menu.sh
		       		
		       		-or-
	
		       	wget is.gd/iTNqig -O menu.sh
		       		
		       
		       ** If Shortened URL is 404 **
		       
		       ** Run This ** 
                       wget https://raw.githubusercontent.com/i3-Arch/Arch-Installer/master/menu.sh
           
               
                2. :RUN: 

                        source menu.sh


# POST INSTALL
		
		1a. run dhcpcd
			then systemctl enable dhcpcd@device ( to enable dhcpcd at boot )

		
			1. 
				wget https://goo.gl/YQ0Sxa -O Post-Install.sh


				** If Shortened URL is 404 **
				
				** Run This **
				wget https://raw.githubusercontent.com/i3-Arch/Arch-Installer/master/Post-Install.sh
			

			2. source Post-Install.sh



			** WM/DE's to ADD **
		    	  * Not in order *
		  	 ___________________
		        |                   |
		        |    Herbstluftwm   |
		        |      Spectrwm     |
		        |      Awesome      |
		        |      Openbox      |
		        |       Gnome       |
		        |        Dwm        |
		        |        Kde        |
		        |___________________|

# CURRENT OBJECTIVES
	
	1. Make a menu that makes things easier  --COMPLETE--

	2. Add More Options In General

	3. Misc
		i. LUKS

	4. Cleanup

	5. Release

	       
	.... .........    .       . .. .....  .I.......  ..      .                     
	.... .......                       .  I7?.                                     
	............                    . .  .7I7=. .     .                            
	............                         IIII?. .                                  
	... ......                         .=IIIII?       .                            
	... .......                .   .  ..IIIIII?~.     .                            
	... .......                       .IIIIIIII?.                                  
	... ... ..                        .?IIIIIIII+..   .                            
	... ........                    ..?..II?IIII??.   .                            
	... .......                     .??IIIIII??????.                               
	... .......                   ..????????II????+..                               
	... ........                  .?????II?II??????+...                            
	... ........                 .:++???+?77IIIII7??+.                             
	... .......      .           .++?IIIIIIIIIIIIIII7?.      .                     
	............               ..+IIIIIIIIIIIIIIIIIIII?                            
	... ........               .7IIIIIIII?....IIIIIIIII,.                          
	... .......               .IIIIIIIII..    .IIIIIIIII.                          
	............              IIIIIIIII?       .IIIIIIII7..                        
	... .......             .=IIIIIIIII.  .    .IIIIII7III.                        
	............           .,7IIIIIIIII   .    .7IIIIII~.7I.                       
	............          ..IIIIIIIIII7        .7IIIIIIII7..                       
	... . . ..           ..IIIIIIIII7I7.       .II77IIIIIIII..                     
	... ......           .IIIII7I7..  .            ..7IIIIIII.                     
	... ........       ..III7I,                        .,7I7II...                  
	... ........       .III,.                             ..77I                    
	... ........      .?~.                    .       .       ,I.  
