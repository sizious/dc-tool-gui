TSynDcToolSyn   {first Identifier is considered to be the Class Name }
tk              {second Identifier is considered to be the Identifier Prefix }
IdentStart '_', 'a'..'z', 'A'..'Z':: '_', '0'..'9', 'a'..'z', 'A'..'Z'::

TOKENTYPES
Identifier Foreground=clBlack|Background=clWhite
Space Foreground=clWhite|Background=clWhite
String Foreground=clPurple|Background=clWhite
Key Foreground=clBlue|Background=clWhite|Style=[fsBold]
Failures Foreground=clRed|Background=clWhite|Style=[fsBold]
GeneralFailure Foreground=clWhite|Background=clRed|Style=[fsBold]
Devices Foreground=clGreen|Background=clWhite
|><|

KEYS
arch
cdfs
thd
maple
vid_set_mode
kernel
pvr_wait_ready
loader
pvr
fs_iso9660
fs_romdisk
|><|

KEYS Devices
PuruPuru 
Vibration 
Pack
VMU 
Puru
Mouse
Keyboard
Controller
Visual 
Memory
Dreamcast
Clock
LCD
MemoryCard
JumpPack
|><|

KEYS Failures
fails
failure
failed
error
err
erreur
panic
fail
|><|

CHARS

'A'..'Z', 'a'..'z', '_':: Ident
BeginProc
  fTokenID := IdentKind((fLine + Run));
  inc(Run, fStringLen);
  while Identifiers[fLine[Run]] do
    Inc(Run);
EndProc
|><|

ENCLOSEDBY

GeneralFailure,FailureComment,***,***
String,String,","
|><|

SAMPLESOURCE
DC-TOOL GUI 3 SERIES - by [big_fury]SiZiOUS

"Dreamcast REFUSES to DIE"

This highlighter is used with DC-TOOL GUI to recognize 
KallistiOS features and debugs log.

Some Examples... :
arch: *** Powered by SynEdit. ***
maple: *** ASSERTION FAILURE ***

Enjoy,
SiZ!

Some useful links :
http://sbibuilder.shorturl.com/
http://www.dc-france.com/
http://www.dreamcast-scene.com/
http://www.dciberia.net/
http://www.dcemulation.com/
http://www.dcemu.co.uk/
|><|

