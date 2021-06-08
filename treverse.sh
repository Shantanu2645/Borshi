cd $(pwd)
printf "Enter a url to check: "
read url_check 
printf "Enter file name to log fetched urls: "
read gau_fetched_file
gau -o $gau_fetched_file $url_check
sed -i 's|http://||g' $gau_fetched_file 
sed -i 's|https://||g' $gau_fetched_file 
cat $gau_fetched_file | httprobe | tee live_links_$gau_fetched_file
sed -i 's| |%20|g' live_links_$gau_fetched_file


EyeWitness_func(){
	echo -e "[~] Generating report With EyeWitness"
	sed -i 's| |%20|g' live_links_$gau_fetched_file
	$>yes N | python3 EyeWitness/Python/EyeWitness.py -f live_links_$gau_fetched_file --web > /dev/null
	echo -e "[+] Generated report and screenshot With EyeWitness"
	}

while true
do
	echo
 	read -r -p "[~] Do you wants to take screenshot and report using EyeWitness? [Y/n] " input
	case $input in
	    [yY][eE][sS]|[yY])
		EyeWitness_func
	break
	;;
	    [nN][oO]|[nN])

	echo -e "[+] File fetched with gau      : $url_check"
	echo -e "[+] File fetched with httprobe : live_links_$gau_fetched_file"
	break
	       ;;
	     *)
	echo "[*] Invalid input..."
	;;
	esac
done

