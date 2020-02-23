#ifndef __MIKI_H__
#define __MIKI_H__

#define _ACASA
#define _DEBUG


#define BOOL int
#define TRUE	1
#define FALSE	0
#ifdef _DEBUG
	#define TRACE printf
#else 
	#define TRACE 1 ? (void) 0 : printf
#endif

#ifdef _ACASA
	#define PFILE	int
#else
	#define PFILE	FILE*
#endif


#endif