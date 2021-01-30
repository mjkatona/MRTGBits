MRTGBits:: A NAGIOS core plug converting MRTG Bytes to bits<br>
v1::1/30/2021<br>
https://github.com/mjkatona/MRTGBits/releases<br>

What does this do?<br>
MRTG can display in bits but records everything in Bytes<br>
When importing MRTG data in other applications as Bits, it must first be converted<br>
This NAGIOS core plugin will convert, import, and set threadsholds as Bits<br>
<br>
Flow<br>
MRTG writes log file to a dir which NAGIOS Core can read<br>
NAGIO Core calls MRTGBits.pl via the device.cfg file pointing to the MRTG Log file<br>
MRTGBits.pl does wonderful perl magic can tells NAGIOS Core<br>
NAGIOS Core displays wonderful perl magic causing python lovers to cry<br>
<br>

Why do you care about Bytes or Bits?<br>
Bytes represent storage AKA Datacenter speak<br>
Bits represent bandwidth AKA Network speak<br>
<br>
How to install?<br>
You must have perl install ( check via: perl -v )<br>
Place this file into your ~/nagios/libexec directory and chmod 755<br>
the /nagios/libexec is where all your other check_this and check_that reside<br>
<br>
In your NAGIOS config:<br>
define service{<br>
use generic-service<br>
host_name <# Hostname ><br>
servicegroups <# If you use Servicegroups ><br>
service_description <# Whatever you call it ><br>
check_command MRTGBits!<# MRTG PWD and Logfile><br>
}<br>
<br>
Here is my working example where my MRTG pushes logfiles to a network "/share" drive and Nagios picks them up<br>
<br>
define service{<br>
use generic-service<br>
host_name CORE-1<br>
servicegroups NETWORK<br>
service_description Primary Internet Interface<br>
check_command MRTGBits!/share/temp/192.168.10.4_23.log<br>
}<br>
<br>
And of course restart nagios!<br>
<br>
To do list<br>
A better install guide<br>
warning and critical levels defined by user or default to 0<br>
check to make sure warning is always lower than critical<br>
auto build nagios config based on MRTG logs<br>
threashold for age of MRTG poll<br>
Exceeds threashold by x amount<br>
<br>
=cut<br>
