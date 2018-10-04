#include <stdarg.h>

#include <dream.h>
#undef printf
#define	printf _printf

#include "dcload-syscalls.h"

extern int serial_disabled;

static int logfd = -1;

int _printf(char *fmt,...)
{
	static char buf[2048];
	va_list args;
	int ret;

	va_start(args,fmt);
	ret = vsprintf(buf,fmt,args);
	va_end(args);

	write(1,buf,strlen(buf));
	if (logfd) write(logfd,buf,strlen(buf));

	return ret;
}

int memzero(unsigned char *buf,int size)
{
	int i;
	for(i=0;i<size;i++) 
		if (buf[i]) return 1;
	return 0;
}

#define	N	1

#if 1
#define open2 open
#define	close2 close
#define write2 write
#else

static int compress_fd = -1;
static int zero_count;
int open2(char *file,int flags)
{
	int fd = open(file,flags);
	if (flags&0x80000000) {
		compress_fd = fd;
		zero_count = 0;
	}
	return fd;
}

int write2(int fd,unsigned char *buf,long size)
{
	int i,ret;

	if (fd!=compress_fd) return write(fd,buf,size);

	if (memzero(buf,i)==0) {
		zero_count+=size;
	} else {
		int count = 0x80000000 + size;
		char save[4];
		if (zero_count) {
			ret = write(fd,&zero_count,4);
			zero_count = 0;
		}
		buf-=4;
		memcpy(save,buf,4);
		buf[0]=count;
		buf[1]=count>>8;
		buf[2]=count>>16;
		buf[3]=count>>24;
		ret = write(fd,buf,size+4);
		memcpy(buf,save,4);
	}
	if (ret!=-1) ret = size;
	return ret;
}

int close2(int fd)
{
	if (fd==compress_fd) {
		compress_fd = -1;
		if (zero_count) {
			write(fd,&zero_count,4);
			zero_count = 0;
		}
	}
	return close(fd);
}
#endif

void track_save(int no,int first,int size,int type)
{
	int i,fd;
	char file[40];
	char secbuf[2352*N];
	const static char data_hdr[12] = {
		0x00,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0x00
	};
#if 1
	int compress = 0;
#else
	int compress = 0x80000000;
#endif
	int prev,sizemb,secbyte;

	sprintf(file,"track%02d.%s",no,type==4?"iso":"raw");
//	strcpy(file,"tmp");
	_printf("%s\n",file);
	fd = open2(file,O_WRONLY|O_CREAT|O_TRUNC|compress);
	if (fd<0) {
		_printf("open err");
		return;
	}

	secbyte = (type==4?2048:2352);
	sizemb = size*secbyte/1000000;

	prev = -1;
	for(i=0;i<size;i+=N) {
		int mega = i*secbyte/1000000;
		if (prev!=mega) {
			_printf(" %4d/%dM %d%\r",mega,sizemb,i*100/size);
			prev = mega;
		}
		if (cdrom_read_sectors(secbuf,first+i,N)) {
			_printf("read err");
			close2(fd);
			return;
		}
		if (type==4) {
			/* data */
			if (memcmp(secbuf,data_hdr,10/*sizeof(data_hdr)*/)){
				break;
			}
			write2(fd,secbuf+16,secbyte);
		} else {
			/* audio? */
			if (memzero(secbuf,secbyte)==0) continue;
			/* skip all zero */
			write2(fd,secbuf,secbyte);
		}
	}
	_printf(" %4d/%d %d%\r",sizemb,sizemb,100);
	close2(fd);
}


#define MAKE_SYSCALL(rs, p1, p2, idx) \
	uint32 *syscall_bc = (uint32*)0x8c0000bc; \
	int (*syscall)() = (int (*)())(*syscall_bc); \
	rs syscall((p1), (p2), 0, (idx));

/* Reset system functions */
static void gdc_init_system() {	MAKE_SYSCALL(/**/, 0, 0, 3); }

/* Submit a command to the system */
static int gdc_req_cmd(int cmd, void *param) { MAKE_SYSCALL(return, cmd, param, 0); }

/* Check status on an executed command */
static int gdc_get_cmd_stat(int f, void *status) { MAKE_SYSCALL(return, f, status, 1); }

/* Execute submitted commands */
static void gdc_exec_server() { MAKE_SYSCALL(/**/, 0, 0, 2); }

/* Check drive status and get disc type */
static int gdc_get_drv_stat(void *param) { MAKE_SYSCALL(return, param, 0, 4); }

/* Set disc access mode */
static int gdc_change_data_type(void *param) { MAKE_SYSCALL(return, param, 0, 10); }



/* Re-init the drive, e.g., after a disc change, etc */
int _cdrom_reinit(int n) {
	int	rv = ERR_OK;
	int	i, r = -1, cdxa;
	uint32	params[4];

	/* Try a few times; it might be busy. If it's still busy
	   after this loop then it's probably really dead. */
	for (i=0; i<8; i++) {
		if (!(r = cdrom_exec_cmd(24, NULL)))
			break;
	}
	if (i >= 8) { rv = r; goto exit; }
	
	/* Check disc type and set parameters */
	gdc_get_drv_stat(params);
	cdxa = params[1] == 32;
	params[0] = 0;				/* 0 = set, 1 = get */
	params[1] = (n?4096:8192);			/* 8192 ? */
	params[2] = 0; //cdxa ? 2048 : 1024;		/* CD-XA mode 1/2 */
	params[3] = (n?2352:2048);			/* sector size */
	if (gdc_change_data_type(params) < 0) { rv = ERR_SYS; goto exit; }

exit:
	return rv;
}

void dump(unsigned char *buf,int size)
{
	int i;
	for(i=0;i<size;i++) {
		printf("%02x ",buf[i]);
		if ((i&15)==15) printf("\n");
	}
		if ((i&15)==15) printf("\n");
}

main()
{
	int fd,i,ret;
	int first,last,session;
	char secbuf[2352];
	char *p;

	CDROM_TOC toc;

	printf("\nDreamRip 2.01 by BERO\n\n");
//	exit(0);

	if (cdrom_init() || _cdrom_reinit(1)) {
		_printf("cdrom init error\n");
		exit(1);
	}

	ret = cdrom_read_sectors(secbuf,45150,1);
	if (ret) {
		_printf("ip read error\n");
		exit(1);
	}

	if (memcmp(secbuf+16,"SEGA",4)) {
		_printf("not GD\n");
		exit(1);
	}

	p = secbuf+16+0xff;
	while(*p==' ') p--;
	p[1] = 0;

  logfd = open("track.txt",O_WRONLY|O_CREAT|O_TRUNC);

	printf("%s\n\n",secbuf+16+0x80);

	_printf("no type   start   size    MB\n");

  for(session=0;session<2;session++) {

	ret = cdrom_read_toc(&toc,session);
	if (ret) {
		_printf("toc read error\n");
		exit(1);
	}

	first = TOC_TRACK(toc.first);
	last = TOC_TRACK(toc.last);

	printf("session %d\n",session+1);

	for(i=first;i<=last;i++) {
		int start,end,size;
		int type,secbyte;
		char *typestr="";

		start = TOC_LBA(toc.entry[i-1]);
		type = TOC_CTRL(toc.entry[i-1]);

		if (type==4)
			typestr = "DATA ";
		else if (type==0)
			typestr = "AUDIO";
		else "???  ";

		end = TOC_LBA((i==last?toc.dunno:toc.entry[i]));
		size = end-start;
		_printf("%2d %s %6d %6d %4dM\n",i,typestr,start-150,size,size*(type==4?2048:2352)/1000000);
	}

  }

  close(logfd);
  logfd = -1;

//	test();
//	exit(0);
/*
	_printf("\n");
	track_save(i,549300-1,100,0);

	exit(0);
*/
	printf("\n");

	for(i=first;i<=last;i++) {
		int start,end,size,type;
		type = TOC_CTRL(toc.entry[i-1]);
		start = TOC_LBA(toc.entry[i-1]);
		end = TOC_LBA(i==last?toc.dunno:toc.entry[i]);
		size = end-start;
		track_save(i,start,size,type);
	}
}
