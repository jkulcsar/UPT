



	typedef unsigned char       BYTE;
	typedef unsigned short      WORD;
	typedef unsigned long       DWORD;
	typedef unsigned int        UINT;


	#define LOBYTE(w)           ((BYTE)(w))
	#define HIBYTE(w)           ((BYTE)((UINT)(w) >> 8))
	#define LOWORD(l)           ((WORD)(l))
	#define HIWORD(l)           ((WORD)((DWORD)(l) >> 16))
