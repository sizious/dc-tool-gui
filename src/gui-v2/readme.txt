DC-TOOL GUI
===========

Serial & BBA/LAN version

Read me from the DC-TOOL Website.

1. Features:

* Upload and execute ELF, RAW BINARY, and SREC files
* Built in compression and decompression to speed up that slow serial link
* Console and fileserver (compatible with dcload-ip)
* Lame cd emulation

You MUST have both dcload (running on the dc) and dc-tool (running on the pc). 
you can't use one without the other. 

2. Changes in 1.0.3 (you must have both dcload and dc-tool 1.0.3):

* proper baudrate changing - dcload and dc-tool should always be compiled for 57600 now; 
  use the -b option to switch to 115200 at runtime.
* experimental alternate 115200 setting - "dc-tool -e -b 115200" - please email me if this works 
  better for you than the default 115200.
* added O_BINARY to all open()s in dc-tool to help cygwin users
* included same IP.BIN (with logo/disclaimer) as found in dcload-ip. Please use it if you 
  distribute either cds or cd images.

3. Contacts :
   Andrew Kieschnick for DC-TOOL original program. (adk@napalm-x.com)
   [big_fury]SiZiOUS for DC-TOOL GUI. (sizious@yahoo.fr)

<EOF>