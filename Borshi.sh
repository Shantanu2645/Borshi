banner(){
	clear
	echo -e "\e[33m ____   ____  _____   _____ _    _ _____ 
|  _ \ / __ \|  __ \ / ____| |  | |_   _|
| |_) | |  | | |__) | (___ | |__| | | |  
|  _ <| |  | |  _  / \___ \|  __  | | |  
| |_) | |__| | | \ \ ____) | |  | |_| |_ 
|____/ \____/|_|  \_\_____/|_|  |_|_____|\e[0m"
	echo -e ""
	                                                                               
	
	echo -e "\e[33mtools used    : gau, httprobe, EyeWitness\e[0m"
	echo -e "\e[33mLanguage used : bash, python3 , go \e[0m"
	echo -e "\e[33mAuthor        : Shantanu Dey Anik  ( https://github.com/Shantanu2645 ) \e[0m"
	echo -e ""
	echo -e "This script needs sudo permission to work further."
	echo -e "----------------------------------------------"

}
python(){

	sudo apt update -y > /dev/null
	if [[ $(which python3) == "" ]]; then
		sudo apt install python3 -y > /dev/null
 		$(which python3) -m pip install --upgrade pip
 		$(which python) -m pip install --upgrade pip

	fi
}
golang(){	
	if [[ $(which go) != "" ]]; then		
		echo -e "\e[32m[+] go language installed\e[0m"		
	else
		echo -e "\e[31m[-] Installing go language\e[0m"
		sudo apt install golang -y	
		echo -e "\e[32m[+] go language installed\e[0m"		
	fi
}

gau(){
	if [[ $(which gau) != "" ]]; then
		echo -e "\e[32m[+] gau installed\e[0m"
	else
		echo -e "\e[31m[-] Installing gau\e[0m"
		go get -u -v github.com/lc/gau
		sudo mv ~/go/bin/gau /usr/bin
		echo -e "\e[32m[+] gau installed\e[0m"		
	fi
}

httprobe(){	
	if [[ $(which httprobe) != "" ]]; then
		echo -e "\e[32m[+] httprobe installed\e[0m"			
	else
		echo -e "\e[31m[-] Installing httprobe\e[0m"
		go get -u github.com/tomnomnom/httprobe
		sudo mv ~/go/bin/httprobe /usr/bin	
		echo -e "\e[32m[+] httprobe installed\e[0m"	
	fi
}

eyewithness(){
 	if [ -d "EyeWitness" ]; then
 		echo -e "\e[32m[+] EyeWitness is already available\e[0m"
 		echo -e "[~] Checking for update"
 		rm -rf EyeWitness
 		git clone https://github.com/FortyNorthSecurity/EyeWitness > /dev/null
 		chmod +x EyeWitness/Python/setup/setup.sh
 		sudo ./EyeWitness/Python/setup/setup.sh > /dev/null
 		clear
 		banner
 		echo -e "\e[32m[+] EyeWitness installed\e[0m" 		
 	else 	
 		echo -e "\e[31m[-] EyeWitness is Installing\e[0m"
	 	git clone https://github.com/FortyNorthSecurity/EyeWitness > /dev/null
	 	chmod +x EyeWitness/Python/setup/setup.sh
	 	sudo ./EyeWitness/Python/setup/setup.sh > /dev/null

	 	clear
	 	banner
	 	echo -e "\e[32m[+] EyeWitness installed\e[0m"	 	
	fi
}



tool_availability(){
	banner
	python
	if [[ $(sudo id -u) == "0" ]]; then
		eyewithness
		golang
		httprobe
		gau

		chmod +x treverse.sh 
		./treverse.sh
	else
		echo "Sudo not allowed"
		echo " exiting"
		sleep 3
	fi
		

}
	
tool_availability

