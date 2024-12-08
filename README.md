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

Step one: install all requirements with (option 1)
Step two: Clean all current confs (option 6)
Step Three: made the conf interface (option 2)
Step four: Do the conf of DHCP/DNS and Fake AP (option 3 and 4)
Step five: Enable traffic rules (option 5)
Step six: Conf apache2 (option 7)
Step seven (optional): start/stop captive portal (option 8)
