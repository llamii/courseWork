#! /bin/bash
#
#  Bash script that helps user to download the selected files from rda.ucar.edu using Wget
#  Experienced Wget Users: add additional command-line flags here
#  Use the -r (--recursive) option with care
#  Do NOT use the -b (--background) option - simultaneous file downloads
#  can cause your data access to be blocked

cert_opt=""

#  1. Replace "xxxxxx" with your rda.ucar.edu password and email on the next uncommented line

passwd="xxxxxx"
email="xxxxxx"


#  2. You can use individual year and Wget parameters by changing opts and year variables

opts="-N"
year="2019"

#  3. If you want to download specific parameters: place '#' before the parameters you don't want to download

params=(
 "wnd10m" # download (1-hour Forecast) 10 m above ground U,V-Components of Wind [m/s]
 "prate" # download (Analysis) surface precipitation rate [kg/m^2/s]
 "dswsfc" # download (1-hour Average) Surface Downward Short-Wave Rad. Flux [W/m^2]
 "dlwsfc" # dowlnoad (1-hour Average) Surface Downward Long-Wave Rad. Flux [W/m^2]
 "tmp2m" # download (1-hour Forecast) 2 m above ground Temperature [K]
 "q2m" # download (Analysis) 2 m above ground specific humidity [kg/kg]
 "prmsl" # download (Analysis) mean sea level Pressure Reduced to MSL [Pa]
 )


#  4. If you get a certificate verification error (version 1.10 or higher), uncomment this line:

#set cert_opt = "--no-check-certificate"


#  5. NOTE: if you get 403 Forbidden errors when downloading the data files, check
#  the contents of the file 'auth_status.rda.ucar.edu'


#  6. All downloaded files will be stored in ./uploaded_files folder

num_chars=`echo $passwd |awk '{print length($0)}'`
if [[ $num_chars == 0 || $passwd == "xxxxxx" ]]; then
    echo "You need to set your password before you can continue"
    echo "  see the documentation in the script"
    exit
fi

num_chars=`echo $email |awk '{print length($0)}'`
if [[ $num_chars == 0 || $email == "xxxxxx" ]]; then
    echo "You need to set your email before you can continue"
    echo "  see the documentation in the script"
    exit
fi


newpass=""

for (( i=0; $i<${#passwd}; i=$(($i+1)) ))
do
    c=${passwd:$i:1}
    if [[ $c == '&' ]]; then
        c="%26"
    else
        if [[ $c == "?" ]]; then
            c="%3F"
        else
            if [[ $c == "=" ]]; then
                c="%3D"
            fi
        fi
    fi
    newpass=$newpass$c
done
passwd=$newpass


wget $cert_opt -O auth_status.rda.ucar.edu --save-cookies auth.rda.ucar.edu.$$ --post-data="email=$email&passwd=$passwd&action=login" https://rda.ucar.edu/cgi-bin/login

numberOfParams=$((12*${#params[@]}))
for ((i=0;i<$numberOfParams;i++))
    do
        month=$((i%12+1))
        param=${params[((i/12))]}
        wget -P ./uploaded_files $cert_opt $opts --load-cookies auth.rda.ucar.edu.$$ https://rda.ucar.edu/data/ds094.1/$year/$param.cdas1."$year"0$month.grb2
    done

rm auth.rda.ucar.edu.$$ auth_status.rda.ucar.edu
