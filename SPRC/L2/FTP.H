#ifndef	__FTP_H__
#define	__FTP_H__

#define HCMD	unsigned short int
#define HMSG	unsigned short int
#define HCOUNT  unsigned short int

//Commands
#define	cmdGET			(HCMD)0x1
#define	cmdDIR			(HCMD)0x2
#define cmdEXIT			(HCMD)0x3


//Error Messages Codes
#define msgNOERROR		(HMSG)0x0
#define msgFILE_OPEN_ERROR	(HMSG)0x1
#define msgOPEN_DIR_ERROR	(HMSG)0x2


#endif