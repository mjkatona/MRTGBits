MRTGBits:: A NAGIOS core plug converting MRTG Bytes to bits<br>
v2::1/30/2021<br>
https://github.com/mjkatona/MRTGBits/releases<br>

What does this do?<br>
MRTG can display in bits but records everything in Bytes<br>
When importing MRTG data in other applications as Bits, it must first be converted<br>
This NAGIOS core plugin will convert, import, and set alarm threadsholds as Bits<br>
<br>
Flow<br>
MRTG writes log file to a dir which NAGIOS Core can read<br>
NAGIO Core calls MRTGBits.pl via the device.cfg file pointing to the MRTG Log file<br>
MRTGBits.pl does wonderful perl magic can tells NAGIOS Core<br>
NAGIOS Core displays wonderful perl magic causing python lovers to cry<br>

<br><br>
Why do you care about Bytes or Bits?<br>
Bytes represent storage AKA Datacenter speak<br>
Bits represent bandwidth AKA Network speak<br>
<br>
How to install?<br>
You must have perl installed<br>
You must have MRTG installed<br>
You must have NAGIOS CORE<br>
<br>
Place MRTGBits.pl into your ~/nagios/libexec directory and chmod 755<br>
the /nagios/libexec is where all your other check_this and check_that reside<br>

How do you configure?<br>
In your NAGIOS objects/device/host/services/how_ever_you_do_it config:<br>
<br>
# Add the command<br>
define command{<br>
command_name MRTGBits<br>
command_line $USER1$/MRTGBits.pl $ARG1$ $ARG2$ $ARG3$<br>
}<br>
<br>
v
# Add the service<br>
define service{<br>
use generic-service<br>
host_name <# Hostname ><br>
servicegroups <# If you use Servicegroups ><br>
service_description <# Whatever you call it ><br>
check_command MRTGBits!<# MRTG PWD and Logfile>!<# Warning Exceed Threshold>!<# Warning Exceed Threshold> <br>
}<br>
<br>
<# MRTG PWD and Logfile> = This is where MRTG writes the .log files. It is the working directory in your MRTG.CFG file<br>
<# Warning Exceed Threshold> = This is the warning level in BITS when NAGIOS changes to yellow.<br>
<# Warning Exceed Threshold> = This is the critical level in BITS when NAGIOS changes to red.<br>
If you do not want to alarm on the thresholds, do not set them at all!<br>
<br>
Example:<br>
If you want to warn when the link exceeds 100Mb and critical when the link exceed 500Mb: check_command MRTGBits!<# MRTG PWD and Logfile>!100000000!500000000<br>
If you want to warn when the link exceeds 700Mb and critical when the link exceed 900Mb: check_command MRTGBits!<# MRTG PWD and Logfile>!700000000!900000000<br>
If you do not want to ever alarm so not set the warning or the critical: check_command MRTGBits!<# MRTG PWD and Logfile><br>
<br>
Here is my working example where my MRTG pushes logfiles to a network "/share" drive and Nagios picks them up<br>
<br>
define command{<br>
command_name MRTGBits<br>
command_line $USER1$/MRTGBits.pl $ARG1$ $ARG2$ $ARG3$<br>
}<br>
#<br>
define service{<br>
use generic-service<br>
host_name CORE-1<br>
servicegroups NETWORK<br>
service_description Primary Internet Interface<br>
check_command MRTGBits!/share/temp/192.168.10.4_23.log!700000000!900000000<br>
}<br>
<br>
And of course restart nagios!<br>
<br>
Last - To manually run, same concept but just replace ! with spaces:<br>
./MRTGBits.pl /share/temp/192.168.10.4_23.log 700000000 900000000<br>

To do better list
A better install guide
auto build nagios config based on MRTG logs and MRTG CFG Working DIR
threashold for age of MRTG poll
Exceeds threashold by x amount
