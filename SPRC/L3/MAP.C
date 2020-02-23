#include <stdio.h>
#include <string.h>
#include "miki.h"
#include "map.h"

int hash(char* key)
{
	int ret;
	ret  = (key[0] + key[strlen(key)-1]*11
		+ 26*strlen(key)) % MAP_SIZE;
	return ret;
}


/*Map operators*/
void MapInit(CMap map)
{
	int i;
	for(i=0; i<MAP_SIZE; i++)
	{
		ListInit(&map[i]);
	}
}

BOOL MapSetAt(CMap map, char* key, char* value)
{
	int i;
	i = hash(key);
	return ListAdd(&map[i], key, value);
}

BOOL MapGetAt(CMap map, char* key, char* value)
{
	CCell* p_cell;
	int i;
	char sBuffer[MAX_STR];
	i = hash(key);
	if(ListGet(&map[i], key, value))
		return TRUE;
	else
		return FALSE;
}

BOOL MapRemoveKey(CMap map, char* key)
{
	int i;
	i = hash(key);
	return ListRemove(&map[i], key);
}

void MapRemoveAll(CMap map)
{
	int i;
	for(i=0; i<MAP_SIZE; i++)
	{
		ListRemoveAll(&map[i]);
	}
}

POSITION MapGetStartPos(CMap map)
{
	POSITION pos;
	int i;
	for(i=0; i<MAP_SIZE; i++)
	{
		if(ListIsEmpty(&map[i]))
			continue;
		else
			pos = (POSITION)(map[i].m_pUrm);
			return pos; 
	}
	return NULL;
}

void MapGetNextAssoc(CMap map, POSITION* p_pos, char* key, char* value)
{
	CList* p_list;
	int i;
	if(*p_pos==NULL)
	{
		printf("Null pointer assignement\n");
		exit(0);
	}

	p_list = (CList*)(*p_pos);
	strcpy(key, p_list->m_Data.m_sKey);
	strcpy(value, p_list->m_Data.m_sValue);
	
	if(p_list->m_pUrm!=NULL)
	{/* we have other keys in the same list*/
		*p_pos = (POSITION)p_list->m_pUrm;
		return;
	}
	
	/*we must find the first non-empty list*/
	for(i=hash(key)+1; i<MAP_SIZE; i++)
	{
		if(ListIsEmpty(&map[i]))
			continue;
		else
			*p_pos =  (POSITION)(map[i].m_pUrm);
			return;
	}
	*p_pos = (POSITION)NULL;
}


/*List operators*/
BOOL ListInit(CList* p_list)
{	if(p_list==NULL)
		return FALSE;
	p_list->m_pUrm = NULL;
}

BOOL ListIsEmpty(CList* p_list)
{
	return p_list->m_pUrm==NULL; 
}

CCell* ListGet(CList* p_list, char* key, char* value)
{
	CList* p_listCrt;
	for(p_listCrt = p_list->m_pUrm; p_listCrt != NULL;
		 	p_listCrt = p_listCrt->m_pUrm)
	{
		if(!strcmp(p_listCrt->m_Data.m_sKey,  key))
		{
			strcpy(value, p_listCrt->m_Data.m_sValue);
			return &p_listCrt->m_Data;
		}	
	}
	return NULL;
}

BOOL ListAdd(CList* p_list, char* key, char* value)
{
	CCell* p_cell;
	CList* p_newList;
	char sBuffer[MAX_STR];
	/*is key in p_list*/
	if(p_cell=ListGet(p_list, key, sBuffer))
	{
		/*yes it is, overwrite it*/
		printf("overwriteing..\n");
		strcpy(p_cell->m_sValue, value);
	}
	else
	{/* no it isn't, create a new cell*/
		p_newList = (CList*)malloc(sizeof(CList));
		if(!p_newList)
		{
			printf("Out of memory\n");
			return FALSE;
		}
		p_newList->m_pUrm = p_list->m_pUrm;
		p_list->m_pUrm = p_newList;
		CellInit(&p_newList->m_Data, key, value);
	}
}

BOOL ListRemove(CList* p_list, char* key)
{
	CList* p_listCrt;
	CList* p_listDel;
	for(p_listCrt = p_list; p_listCrt->m_pUrm != NULL;
		 	p_listCrt = p_listCrt->m_pUrm)
	{
		if(!strcmp(p_listCrt->m_pUrm->m_Data.m_sKey,  key))
		{/*urm points now to the item we want to delete*/
			p_listDel = p_listCrt->m_pUrm;
			p_listCrt->m_pUrm = p_listDel->m_pUrm;
			free(p_listDel);
			return TRUE;
		}	
	}
	return FALSE;
}

BOOL ListRemoveAllRec(CList* p_list)
{
	if(p_list)
	{
		ListRemoveAllRec(p_list->m_pUrm);
		free(p_list);
	}
}

BOOL ListRemoveAll(CList* p_list)
{
	ListRemoveAllRec(p_list->m_pUrm);
	p_list->m_pUrm = NULL;
}



/*Cell opeartors*/
BOOL CellInit(CCell* p_cell, char* key, char* value)
{
	if(p_cell==NULL || strlen(key)>MAX_STR || strlen(value)>MAX_STR)
		return FALSE;
	strcpy(p_cell->m_sKey, key);		
	strcpy(p_cell->m_sValue, value);
}


/*-------------------------- DEBUGGING ---------------------------*/
int ListGetLength(CList *p_list)
{
	int count;
	CList* p_listCrt;
	count = 0;
	for(p_listCrt = p_list->m_pUrm; p_listCrt != NULL;
		 	p_listCrt = p_listCrt->m_pUrm)
	{
		count++;
	}
	return count;
}

void MapCount(CMap map)
{
	int i;
	for(i=0; i<MAP_SIZE; i++)
	{
		if(ListGetLength(&map[i]))
		{
			printf("list <%3d> contains <%2d> entries \n", i, ListGetLength(&map[i]));
		}
	}

}