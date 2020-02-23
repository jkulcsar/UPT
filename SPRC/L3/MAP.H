#ifndef __MAP_H__
#define __MAP_H__

#define MAX_STR		512
#define MAP_SIZE	3 
#define POSITION	void*

typedef struct tagCell
{
    char m_sKey[MAX_STR];
    char m_sValue[MAX_STR];
}CCell;

typedef struct tagList
{
	CCell	m_Data;
	struct tagList *m_pUrm;
}CList;

typedef CList CMap[MAP_SIZE];



BOOL	CellInit(CCell*, char* key, char* value);

BOOL	 ListInit(CList*);
BOOL	 ListAdd(CList*, char* key, char* value);
CCell*	 ListGet(CList*, char* key, char* value);
BOOL	 ListRemove(CList*, char* key);
BOOL	 ListRemoveAll(CList*);
BOOL	 ListIsEmpty(CList*);


void	 MapInit(CMap);
BOOL 	 MapSetAt(CMap map, char* key, char* value);
BOOL 	 MapGetAt(CMap map, char* key, char* value);
BOOL 	 MapRemoveKey(CMap map, char* key);
POSITION MapGetStartPos(CMap map);
void 	 MapGetNextAssoc(CMap map, POSITION* p_pos, char* key, char* value);
void	 MapRemoveAll(CMap);

#endif
