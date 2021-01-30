MRTGBits:: A NAGIOS core plug converting MRTG Bytes to Bits
v1::1/30/2021
https://github.com/mjkatona/MRTGBits/releases

What does this do?
MRTG can display in Bits but records everything in Bytes
When importing MRTG data in other applications as Bits, it must first be converted
This NAGIOS core plugin will convert, import, and set threadsholds as Bits

Why do you care about Bytes or Bits?
Bytes represent storage AKA Datacenter speak
Bits represent bandwidth AKA Network speak

How to install?
You must have perl install ( check via: perl -v )
Place this file into your ~/nagios/libexec directory and chmod 755
the /nagios/libexec is where all your other check_this and check_that reside

In your NAGIOS config:
define service{
use generic-service
host_name <# Hostname >
servicegroups <# If you use Servicegroups >
service_description <# Whatever you call it >
check_command MRTGBits!<# MRTG PWD and Logfile>
}

Here is my working example where my MRTG pushes logfiles to a network "/share" drive and Nagios picks them up

define service{
use generic-service
host_name CORE-1
servicegroups NETWORK
service_description Primary Internet Interface
check_command MRTGBits!/share/temp/192.168.10.4_23.log
}

And of course restart nagios!

To do list
A better install guide
warning and critical levels defined by user or default to 0
check to make sure warning is always lower than critical
auto build nagios config based on MRTG logs
threashold for age of MRTG poll
Exceeds threashold by x amount

=cut
