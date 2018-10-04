unit switchs;

interface

const
  ELF_ROOT_NODE                       : integer = 0;
  ELF_SECTION_NODE                    : integer = 1;
  ELF_SIZE_NODE                       : integer = 2;
  ELF_LMA_NODE                        : integer = 3;
  
  //Commun au deux
  UPLOAD_SW                           : string = ' -u';
  UPLOAD_EXECUTE                      : string = ' -x';
  DOWNLOAD_SW                         : string = ' -d';

  ADDRESS_SW                          : string = ' -a';
  DOWNLOAD_SIZE                       : string = ' -s';

  DONT_ATTACH_CONSOLE_AND_FILESERVER  : string = ' -n';
  DONT_CLEAR_SCREEN_BEFORE_DOWNLOAD   : string = ' -q';

  CHROOT_TO_PATH                      : string = ' -c';
  ENABLE_CDFS_REDIRECTION             : string = ' -i';
  
  //Change en fonction du dc-tool utilisé
  DEVICE_PORT                         : string = ' -t'; //IP ou ComPort

  //dc-tool serial uniquement
  BAUDRATE_SW                         : string = ' -b';
  ALTERNATE_BAUD                      : string = ' -e';

  USE_DUMB_TERMINAL                   : string = ' -p';

  //dc-tool-ip uniquement
  RESET_DC_TOOL                       : string = ' -r';

implementation

end.
