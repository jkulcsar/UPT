#ifndef	__DB_H__
#define	__DB_H__

#define HCMD	unsigned short int
#define HMSG	unsigned short int
#define HCOUNT  unsigned short int

//Commands
#define cmdERROR		(HCMD)0x0
#define cmdEXIT			(HCMD)0x1
#define	cmdPUT			(HCMD)0x2
#define	cmdGET			(HCMD)0x3
#define	cmdDEL			(HCMD)0x4
#define	cmdENUM			(HCMD)0x5



//Error Messages Codes
#define msgNOERROR		(HMSG)0x0
#define msgNO_KEY		(HMSG)0x1
#define msgNO_MEM		(HMSG)0x2
#define msgWRONG_ID		(HMSG)0x3

#define	MAP_COUNT	2

#endif