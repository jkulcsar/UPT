
	/*  In acest fisier se gasesc definitiile functiilor care servesc
		la derularea operatiilor cu fisierele de date                 */

 #include <stdio.h>
 #include <fcntl.h>
 #include <alloc.h>
 #include "3d_types.h"

 void  read_data_file( void );
 void write_data_file( void );

 void read_data_file( void )
 {
	 FILE     *data_file;
	 obiect3d *tobiect3d;
	 int       nro;
	 int		i;
	 char     ch;


	 data_file = fopen("c:\tc\source\datafile.dat","r");
	 if( data_file )
	 {  while (!eof(data_file))
	    {
		 nro = 0;
		 tobiect3d = (obiect3d*) malloc( sizeof(obiect3d) );
		 fscanf( data_file, "%s",tobiect3d[nro]  -> nume );
		 fscanf( data_file, "%d", tobiect3d[nro] -> ltv );

	    fscanf( data_file, "%d", tobiect3d[nro] -> culoare );

	    tobiect3d[nro] -> tv = (punct3d*) malloc( (tobiect3d[nro] -> ltv)*sizeof(punct3d) );
	    for(i=0;i < (tobiect3d[nro] -> ltv); i++)
		 {
		    fscanf( data_file,"%f","%f","%f", tobiect3d[nro] -> tv[i] -> x,
									   tobiect3d[nro] -> tv[i] -> y,
									   tobiect3d[nro] -> tv[i] -> z );
		 }

	    nrp = 0;
	    tobiect3d[nro] -> tp = (poligon3d*) malloc( sizeof(poligon3d) );
	    fscanf(data_file,"%c",ch);
	    switch(ch)
		 {
		    case 'p' : {
					   nrp++;
					   fscanf(data_file,"%d",tobiect3d[nro] -> ltp);
					   tobiect3d[nro] -> tp = realloc( tobiect3d[nro] -> tp,
												nrp*sizeof(poligon3d) );
					   for(i=0;i < (tobiect3d[nro] -> ltp);i++)
					   {
						fscanf( data_file,"%d"






	    fclose( data_file );
	 }
	 else printf("\nError opening datafile for read ! ");
 }

 void write_data_file( void )
 {
	 FILE *data_file;

	 data_file = fopen("c:\tc\source\datafile.dat","w");
	 if( data_file )
	 {
		fprintf( data_file, ... );
		fclose(  data_file  );
	 }
	 else printf("\nError opening datafile for writing !");
 }

