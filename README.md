# EvilTwiner

EvilTwiner its a software developed to conf automatically all you need to have and do for a evil twin attack.

The tool has two modes of attack: 

1. The standard evil twin with internet access for the victim clients
2. And the captive portal to steal wifi passwords (this last its a equivalent from a phishing but for wifi and clients can't use internet without complete the form).
   Apart of that has an essential conf that when the users send a SSID and password validates the data in real time with a connection so if he don't enter the right data gonna restart the form.

# NOTES

When you conf the FAP there is a line that writes a fake bssid to dont take youre MAC address...

1. The first time you start hostapd with this line uncommented hostapd don't gonna start so comment this line, 
2. later start hostapd with the config you make.
3. Uncomment the same line again and reload the execution of the hostapd file.


# In what order start?

1. Step one: install all requirements with (option 1)
2. Step two: Clean all current confs (option 6)
3. Step Three: made the conf interface (option 2)
4. Step four: Do the conf of DHCP/DNS and Fake AP (option 3 and 4)
5. Step five: Enable traffic rules (option 5)
6. Step six: Conf apache2 (option 7)
7. Step seven (optional): start/stop captive portal (option 8)

# Requirements

1. aircrack-ng suite
2. dnsmasq
3. net-tools
4. iptables
5. hostapd
6. apache2
7. a wireless card for monitor mode
8. a wireless card with internet connection:

7.1: For create the fake AP (DHCP)

8.2: To give internet connection to the victim clients (NAT/DNS)

Examples: ALFAAWUSACH036 wireless external card


# ATTACK 2 = EVILTWIN + CAPTIVE PORTAL postconf

requirements:

1. HTML page with custome CSS styles
2. php server = hosting youre captive portal files (HTML/CSS/PHP)
3. apache2 = for default website on youre server ip address
4. openssl = for make the ceritifacate

##############################################################

# Order to execute:

1. Step one: install all requirements with (option 1)
2. Step two: Clean all current confs (option 6)
3. Step Three: made the conf interface (option 2)
4. Step four: Do the conf of DHCP/DNS and Fake AP (option 3 and 4)
5. Step five: Enable traffic rules (option 5)
6. Step six: Conf apache2 (option 7)
8. Step seven: start/stop captive portal (option 8)

# If you already have a conf on network services then do it by this way:

1. Step six: Conf apache2 (option 7)
2. Step seven: start/stop captive portal (option 8)

And finally: 

sudo php -S 10.0.0.1:7000 = this command execute on /var/www/html

[Fri Dec 6 05:39:12 2024] PHP 8.2.24 Development Server (http://10.0.0.1:7000) started


One time you get the data from youre victim client, you should disable captive portal (option 8) cause all time victim gonna be redirected to the portal.

Or stop hostapd service if you dont want to continue with evil twin attack
