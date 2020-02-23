#include <stdio.h>
#include <stdlib.h>
#include <conio.h>
#include <string.h>
#define usint unsigned int
#define uschar unsigned char
#define NS 60

usint stari[28];
uschar senzori[NS];
uschar iesiri[53];
char  *semnificatie[NS]={"START","A1","A2","B1","C1","D1","DC","DD","DS","F1","G1","GJ","GS","I1","J1","JS","JJ","H1","H2","K1","K2","EPI1","EPI2","EPE1","EPE2","TE1S","TE1J","TI1S","TI1J","TE2S","TE2J","TI2S","TI2J","P1","P2","L1","L2","R1","RS","RJ","M1","MS","MJ","N1","S1","T1","TS","TC","U1","V1","E1","3d0","3d1","3d2","FC0","FC1","FC2","EP","NEP","POZC"};
char *siesiri[53]={"AVRA","AVRB","AVRC","AVRD","ROTD","STGD","DRD","AVRE","AVRF","AVRG","DOWNG","UPG","AVLH","UPTI1","DWNTI1","STOC1","AVRI","AVRJ","DOWNJ","UPJ","AVLK","UPTI2","DWNTI2","STOC2","DWNTE2","UPTE2","AVLL","DWNTE1","UPTE1","AVRN","AVLP","AVRS","AVRR","DOWNR","UPR","AVRT","ROTT","STGT","DRT","AVRU","AVRV","DOWNM","UPM","AVRM","SENSX","VM","Vm","Vn","SENSY","VYN","TELS","TELD","BRAT"};
char *sstari[28]={"SA","SB","SC","SD","SE","SF","SG","SH","SI","SJ","SK","SL","SM","SN","SP","SR","SS","ST","SU","SV","SI1","SI2","SE1","SE2","AP1","ADX1","ADY1","AMT1"};
char *sbufstoc[16]={"AX0","AX1","AX2","AX3","AX4","AX5","","","AY0","AY1","AY2","AY3","","","SR","SC"};
char *scerere[16]={"AX0","AX1","AX2","AX3","AX4","AX5","","","AY0","AY1","AY2","AY3","L","E","SR","SC"};
char *strad[16]={"Ax0","Ax1","Ax2","Ax3","Ax4","Ax5","BPx","ETx","LY0","LY1","Ay0","Ay1","Ay2","Ay3","BPy","ETy"};
uschar tradxy[16];
uschar bufstoc[13][16];
uschar cerere[16];
uschar adrt[16];
int ind;
int nsenzor,nstoc,nout,nstari;
int tasta;
int xit;
int l1,l2,sr,pozc,dx3,dx13,dx1,dx0,dy0,dx,dy,stoc,liv;
uschar adrse[16]={0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0};

int stare_senzori(int senzor){
return(senzori[senzor]);
}

void dellinie(int y){
int i;
for(i=1;i<80;i++){
 gotoxy(i,y);
 putch(' ');
 }
}

void inversenzor(int senzor){
senzori[senzor]=1-senzori[senzor];
}

void inverstoc(int senzor){
cerere[senzor]=1-cerere[senzor];
}

void display(void){
int i;
for(i=0;i<16;i++){
   dellinie(i+1);
   gotoxy(1,i+1);cputs(siesiri[nout+i]);
   gotoxy(8,i+1);if(iesiri[nout+i]) putch('1');
                 else             putch('0');
   gotoxy(40,i+1);cputs(sstari[nstari+i]);
   gotoxy(41+strlen(sstari[nstari+i]),i+1);printf("%d",stari[nstari+i]);
 }
}
void afisenzor(void){
int i,j;
for(i=0;i<NS;i++){
    textcolor(6);
    if(i==nsenzor) textcolor(12);
    gotoxy(i+1,20);
    if(stare_senzori(i)) putch('1');
        else
            putch('0');
    }
    dellinie(21);
    gotoxy(nsenzor+1,21);
    cputs(semnificatie[nsenzor]);
}

void afistoc(int v){
int i,j;
for(i=0;i<16;i++){
    textcolor(6);
    if(i==nstoc) textcolor(12);
    gotoxy(i+1,22);
    if(cerere[i]) putch('1');
        else
            putch('0');
    }
    dellinie(23);
    gotoxy(nstoc+1,23);
    if(v==2) puts(strad[nstoc]);
    if(v==1) puts(scerere[nstoc]);
    if(v==0) puts(sbufstoc[nstoc]);
}


void citsenzor(void){
do{
afisenzor();
if(tasta==72||tasta==80||tasta==152||tasta==160||tasta==13)
                display();
tasta=getch();
if(tasta==' ') inversenzor(nsenzor);
if(tasta==27) xit=1;
if(tasta==0){
 tasta=getch();
 if(tasta==72){
     nout=nout-1;
     if(nout<0) nout=0;
     }
 if(tasta==80){
     nout=nout+1;
     if(nout>37) nout=37;
     }
 if(tasta==152){
     nstari=nstari-1;
     if(nstari<0) nstari=0;
     }
 if(tasta==160){
     nstari=nstari+1;
     if(nstari>12) nstari=12;
     }
 if(tasta==75){
      nsenzor=nsenzor-1;
      if(nsenzor<0) nsenzor=NS-1;
      }
 if(tasta==77){
      nsenzor=nsenzor+1;
      if(nsenzor>NS-1) nsenzor=0;
      }
 }
 }while(tasta!=13&&tasta!=27);
}

void citstoc(int var){
do{
afistoc(var);
tasta=getch();
if(tasta==' ') inverstoc(nstoc);
if(tasta==0){
 tasta=getch();
 if(tasta==75){
      nstoc=nstoc-1;
      if(nstoc<0) nstoc=15;
      }
 if(tasta==77){
      nstoc=nstoc+1;
      if(nstoc>15) nstoc=0;
      }
 }
 }while(tasta!=13);
}

void viteza(void){
int a,b,c;
a=0;
b=0;
c=1;
for(ind=0;ind<6;ind++){
a=a+adrt[ind]*c;
b=b+tradxy[ind]*c;
c=c*2;
}
dx=a-b;
if(abs(a-b)>3) dx3=1;
   else
               dx3=0;
if((abs(a-b)<=3)&&(abs(a-b)>1)) dx13=1;
else
               dx13=0;
if(abs(a-b)==1) dx1=1;
else
               dx1=0;
if(abs(a-b)==0) dx0=1;
else
               dx0=0;
c=1;a=0;b=0;
for(ind=0;ind<4;ind++){
a=a+adrt[ind+8]*c;
b=b+tradxy[ind+10]*c;
c=c*2;
}
dy=a-b;
if(abs(a-b)==0) dy0=1;
else
                dy0=0;
if(tradxy[8]&&!tradxy[9]) l1=1;
else l1=0;
if(!tradxy[8]&&tradxy[9]) l2=1;
else l2=0;
}

void transtoc(int sursa,int dest){
int i;
for(i=0;i<16;i++)
     if(sursa==-1) bufstoc[dest][i]=cerere[i];
     else
     bufstoc[dest][i]=bufstoc[sursa][i];
}

void run_aut(void){
pozc=senzori[59];
if((stari[25]!=0)||(stari[26]!=0)) {
                 for(ind=0;ind<16;ind++)
                    cerere[ind]=tradxy[ind];
                 citstoc(2);
                 for(ind=0;ind<16;ind++)
                    tradxy[ind]=cerere[ind];
                    cerere[13]=cerere[12]=0;
                 }
if(senzori[0]&&!senzori[1]&&(stari[24]==0)) {senzori[0]=0;citstoc(1);}
switch(stari[0]){                //automatul A
case 0: if(senzori[0]&&senzori[1]) {senzori[0]=0;citstoc(0);transtoc(-1,0);stari[0]=1;}break;
case 1: if(senzori[2]&&(stari[1]==0)) stari[0]=3;
        if(senzori[2]&&(stari[1]!=0)) stari[0]=2;break;
case 2: if(stari[1]==0) stari[0]=3;break;
case 3: if(!senzori[2]) stari[0]=0;break;
}
iesiri[0]=((stari[0]==1)||(stari[0]==3));

switch(stari[1]){                //automatul B
case 0: if(senzori[2]) {transtoc(0,1);stari[1]=1;}break;
case 1: if(senzori[54]||senzori[55]||senzori[56]) bufstoc[1][6]=1;
        if(senzori[3]&&(stari[2]==0)) stari[1]=3;
        if(senzori[3]&&(stari[2]!=0)) stari[1]=2;break;
case 2: if(stari[2]==0) stari[1]=3;break;
case 3: if(!senzori[3]) stari[1]=0;break;
}
iesiri[1]=((stari[1]==1)||(stari[1]==3));

switch(stari[2]){                //automatul C
case 0: if(senzori[3]) {transtoc(1,2);stari[2]=1;}break;
case 1: if(senzori[4]&&(stari[3]==0)) stari[2]=3;
        if(senzori[4]&&(stari[3]!=0)) stari[2]=2;break;
case 2: if(stari[3]==0) stari[2]=3;break;
case 3: if(!senzori[4]) stari[2]=0;break;
}
iesiri[2]=((stari[2]==1)||(stari[2]==3));

switch(stari[3]){                //automatul D
case 0: if(senzori[4]) {transtoc(2,3);stari[3]=1;}break;
case 1: if(senzori[5]&&(bufstoc[3][6])) stari[3]=6;  //bufstoc[3][6]=GAB
        if(senzori[5]&&(!bufstoc[3][6])) stari[3]=2;break;
case 2: if(senzori[8]&&(stari[5]==0)) stari[3]=4;
        if(senzori[8]&&(stari[5]!=0)) stari[3]=3;break;
case 3: if(stari[5]==0) stari[3]=4;break;
case 4: if(!senzori[5]) stari[3]=5;break;
case 5: if(senzori[6]) stari[3]=0;break;
case 6: if(senzori[7]&&(stari[4]==0)) stari[3]=8;
        if(senzori[7]&&(stari[4]!=0)) stari[3]=7;break;
case 7: if(stari[4]==0) stari[3]=8;break;
case 8: if(!senzori[5]) stari[3]=9;break;
case 9: if(senzori[6]) stari[3]=0;break;
}
iesiri[3]=((stari[3]==1)||(stari[3]==4)||(stari[3]==8));
iesiri[4]=((stari[3]==2)||(stari[3]==5)||(stari[3]==6)||(stari[3]==9));
iesiri[5]=((stari[3]==2)||(stari[3]==9));
iesiri[6]=((stari[3]==6)||(stari[3]==5));

switch(stari[4]){                //automatul E
case 0: if(stari[3]==8) stari[4]=1;break;
case 1: if(senzori[50]) stari[4]=2;break;
case 2: if(!senzori[50]) stari[4]=0;break;
}
iesiri[7]=(stari[4]==1);

switch(stari[5]){                //automatul F
case 0: if(stari[3]==4) {transtoc(3,4);stari[5]=1;}break;
case 1: if(senzori[9]&&(stari[6]==0)) stari[5]=3;
        if(senzori[9]&&(stari[6]!=0)) stari[5]=2;break;
case 2: if(stari[6]==0) stari[5]=3;break;
case 3: if(!senzori[9]) stari[5]=0;break;
}
iesiri[8]=((stari[5]==1)||(stari[5]==3));

switch(stari[6]){               //automatul G
case 0: if(senzori[9]) {transtoc(4,5);stari[6]=1;}break;
case 1: if(senzori[10]&&(bufstoc[6][15])&&(stari[7]!=0)) stari[6]=5;
        if(senzori[10]&&(!bufstoc[6][15])&&(stari[8]!=0)) stari[6]=6;
        if(senzori[10]&&(!bufstoc[6][15])&&(stari[8]==0)) stari[6]=7;break;
case 2: if(senzori[11]) stari[6]=3;break;
case 3: if((stari[7]==0)||(stari[7]==3)) stari[6]=4;break;
case 4: if(senzori[12]) stari[7]=0;break;
case 5: if(stari[7]==0) stari[6]=2;break;
case 6: if(stari[8]==0) stari[6]=7;break;
case 7: if(!senzori[10]) stari[6]=0;break;
}
iesiri[9]=((stari[6]==1)||(stari[6]==7));
iesiri[10]=(stari[6]==2);
iesiri[11]=(stari[6]==4);

switch(stari[7]){              //automatul H
case 0: if((stari[6]==3)&&((stari[20]==0)||(stari[20]==2))) {transtoc(5,6);stari[7]=1;}break;
case 1: if(senzori[17]&&(stari[20]==0)) stari[7]=2;
        if(senzori[17]&&(stari[20]!=0)) stari[7]=3;break;
case 2: if(senzori[18]) stari[7]=0;break;
case 3: if(stari[20]==0) stari[7]=2;break;
}
iesiri[12]=((stari[7]==1)||(stari[7]==2));

switch(stari[8]){             //automatul I
case 0: if(stari[6]==7) {transtoc(5,7);stari[8]=1;}break;
case 1: if(senzori[13]&&(stari[9]==0)) stari[8]=3;
        if(senzori[13]&&(stari[9]!=0)) stari[8]=2;break;
case 2: if(stari[9]==0) stari[8]=3;break;
case 3: if(!senzori[13]) stari[8]=0;break;
}
iesiri[16]=((stari[8]==1)||(stari[8]==3));

switch(stari[9]){            //automatul J
case 0: if(senzori[13]) {transtoc(7,8);stari[9]=1;}break;
case 1: if(senzori[14]&&(stari[10]==0)) stari[9]=2;
        if(senzori[14]&&(stari[10]!=0)) stari[9]=5;break;
case 2: if(senzori[16]) stari[9]=3;break;
case 3: if((stari[10]==0)||(stari[10]==3)) stari[9]=4;break;
case 4: if(senzori[15]) stari[9]=0;break;
case 5: if(stari[10]==0) stari[9]=2;break;
}
iesiri[17]=(stari[9]==1);
iesiri[18]=(stari[9]==2);
iesiri[19]=(stari[9]==4);

switch(stari[10]){          //automatul K
case 0: if((stari[9]==3)&&((stari[21]==0)||(stari[21]==2))) {transtoc(8,9);stari[10]=1;}break;
case 1: if(senzori[19]&&(stari[21]==0)) stari[10]=2;
        if(senzori[19]&&(stari[21]!=0)) stari[10]=3;break;
case 2: if(senzori[20]) stari[10]=0;break;
case 3: if(stari[21]==0) stari[10]=2;break;
}
iesiri[20]=((stari[10]==1)||(stari[10]==2));

switch(stari[11]){           //automatul L
case 0: if((stari[23]==2)&&!senzori[36]) stari[11]=1;break;
case 1: if(senzori[35]) stari[11]=2;break;
case 2: if(stari[12]==2) stari[11]=3;break;
case 3: if(senzori[36]) stari[11]=0;break;
}
iesiri[26]=((stari[11]==1)||(stari[11]==3));

switch(stari[12]){         //automatul M
case 0: if(senzori[35]) stari[12]=1;break;
case 1: if(senzori[42]) stari[12]=2;break;
case 2: if(senzori[36]) stari[12]=3;break;
case 3: if(senzori[41]&&(stari[13]==0)) stari[12]=4;
        if(senzori[41]&&(stari[13]!=0)) stari[12]=5;break;
case 4: if(!senzori[40]) stari[12]=0;break;
case 5: if(stari[13]==0) stari[12]=4;break;
}
iesiri[41]=(stari[12]==1);
iesiri[42]=(stari[12]==3);
iesiri[43]=(stari[12]==4);

switch(stari[13]){        //automatul N
case 0: if(senzori[40]) stari[13]=1;break;
case 1: if(senzori[43]&&(stari[15]==0)) stari[13]=3;
        if(senzori[43]&&(stari[15]!=0)) stari[13]=2;break;
case 2: if(stari[15]==0) stari[13]=3;break;
case 3: if(!senzori[43]) stari[13]=0;break;
}
iesiri[29]=((stari[13]==1)||(stari[13]==3));


switch(stari[14]){        //automatul P
case 0: if((stari[22]==2)&&!senzori[34]) stari[14]=1;break;
case 1: if(senzori[33]) stari[14]=2;break;
case 2: if(stari[12]==2) stari[14]=3;break;
case 3: if(senzori[34]) stari[14]=0;break;
}
iesiri[30]=((stari[14]==1)||(stari[14]==3));

switch(stari[15]){       //automatul R
case 0: if(senzori[33]) stari[15]=3;
        if(!senzori[33]&&senzori[43]) stari[15]=1;break;
case 1: if(senzori[37]&&(stari[16]==0)) stari[15]=2;
        if(senzori[37]&&(stari[16]!=0)) stari[15]=6;break;
case 2: if(!senzori[37]) stari[15]=0;break;
case 3: if(senzori[39]) stari[15]=4;break;
case 4: if(senzori[34]) stari[15]=5;break;
case 5: if(senzori[38]) stari[15]=1;break;
case 6: if(stari[16]==0) stari[15]=2;break;
}
iesiri[32]=((stari[15]==1)||(stari[15]==2));
iesiri[33]=(stari[15]==3);
iesiri[34]=(stari[15]==5);

switch(stari[16]){       //automatul S
case 0: if(senzori[37]) stari[16]=1;break;
case 1: if(senzori[44]&&(stari[17]==0)) stari[16]=3;
        if(senzori[44]&&(stari[17]!=0)) stari[16]=2;break;
case 2: if(stari[17]==0) stari[16]=3;break;
case 3: if(!senzori[44]) stari[16]=0;break;
}
iesiri[31]=((stari[16]==1)||(stari[16]==3));

switch(stari[17]){       //automatul T
case 0: if(senzori[44]) stari[17]=1;break;
case 1: if(senzori[45]) stari[17]=2;break;
case 2: if(senzori[46]&&(stari[18]==0)) stari[17]=3;
        if(senzori[46]&&(stari[18]!=0)) stari[17]=5;break;
case 3: if(!senzori[45]) stari[17]=4;break;
case 4: if(senzori[47]) stari[17]=0;break;
case 5: if(stari[18]==0) stari[17]=3;break;
}
iesiri[35]=((stari[17]==1)||(stari[17]==3));
iesiri[36]=((stari[17]==2)||(stari[17]==4));
iesiri[37]=(stari[17]==2);
iesiri[38]=(stari[17]==4);

switch(stari[18]){       //automatul U
case 0: if(senzori[46]) stari[18]=1;break;
case 1: if(senzori[48]&&(stari[19]==0)) stari[18]=3;
        if(senzori[48]&&(stari[19]!=0)) stari[18]=2;break;
case 2: if(stari[19]==0) stari[18]=3;break;
case 3: if(!senzori[48]) stari[18]=0;break;
}
iesiri[39]=((stari[18]==1)||(stari[18]==3));

switch(stari[19]){       //automatul V
case 0: if(senzori[48]) stari[19]=1;break;
case 1: if(senzori[49]) stari[19]=2;break;
case 2: if(!senzori[49]) stari[19]=0;break;
}
iesiri[40]=(stari[19]==1);

switch(stari[20]){       //automatul SI1
case 0: if(senzori[18]) {transtoc(6,10);stari[20]=1;}break;
case 1: if(senzori[27]) stari[20]=2;break;
case 2: if(!senzori[21]) stari[20]=3;break;
case 3: if(senzori[28]) stari[20]=0;break;
}
iesiri[13]=(stari[20]==1);
iesiri[14]=(stari[20]==3);
iesiri[15]=(stari[20]==2);


switch(stari[21]){       //automatul SI2
case 0: if(senzori[20]) {transtoc(9,11);stari[21]=1;}break;
case 1: if(senzori[31]) stari[21]=2;break;
case 2: if(!senzori[22]) stari[21]=3;break;
case 3: if(senzori[32]) stari[21]=0;break;
}
iesiri[21]=(stari[21]==1);
iesiri[22]=(stari[21]==3);
iesiri[23]=(stari[21]==2);

switch(stari[22]){       //automatul SE1
case 0: if(!senzori[33]&&senzori[23]&&senzori[51]) stari[22]=1;break;
case 1: if(senzori[26]) stari[22]=2;break;
case 2: if(senzori[33]) stari[22]=3;break;
case 3: if(senzori[25]) stari[22]=0;break;
}
iesiri[27]=(stari[22]==1);
iesiri[28]=(stari[22]==3);

switch(stari[23]){       //automatul SE2
case 0: if(!senzori[35]&&senzori[24]&&senzori[51]) stari[23]=1;break;
case 1: if(senzori[30]) stari[23]=2;break;
case 2: if(senzori[35]) stari[23]=3;break;
case 3: if(senzori[29]) stari[23]=0;break;
}
iesiri[24]=(stari[23]==1);
iesiri[25]=(stari[23]==3);

switch(stari[24]){       //automatul AP1
case 0: stoc=(stari[20]==2);liv=cerere[12];
        if(liv||stoc) stari[24]=1;
        if(stoc&&!liv) {
                   transtoc(10,12);
                   for(ind=0;ind<16;ind++)
                        adrt[ind]=0;
                   }
        if(liv){
                      cerere[12]=0;
                      for(ind=0;ind<16;ind++)
                       adrt[ind]=cerere[ind];
                       }
        sr=adrt[14];break;
case 1: viteza();
        if((stari[25]==4)&&(stari[26]==3)) stari[24]=2;break;
case 2: if(stari[27]==10) stari[24]=3;
        if(stoc&&!liv) {
                   for(ind=0;ind<16;ind++)
                        adrt[ind]=bufstoc[12][ind];
                   }
        if(liv){
                      cerere[12]=0;
                      for(ind=0;ind<16;ind++)
                       adrt[ind]=adrse[ind];
                       }
        sr=adrt[14];break;
case 3: viteza();
        if((stari[25]==4)&&(stari[26]==3)&&pozc) stari[24]=4;
        if(!pozc) stari[24]=5;break;
case 4: if(stari[27]==9) stari[24]=6;
        if(stari[27]==11) stari[24]=0;break;
case 5: if(cerere[13]) stari[24]=3;break;
case 6: if(cerere[13]) stari[24]=3;break;
}
iesiri[44]=(dx>0);


switch(stari[25]){       //automatul ADX1
case 0: if(((stari[24]==1)||(stari[24]==3))&&dx0&&senzori[59]) stari[25]=4;
        if(((stari[24]==1)||(stari[24]==3))&&dx3&&senzori[59]) stari[25]=1;
        if(((stari[24]==1)||(stari[24]==3))&&dx13&&senzori[59]) stari[25]=2;
        if(((stari[24]==1)||(stari[24]==3))&&dx1&&senzori[59]) stari[25]=3;break;
case 1: if(dx13) stari[25]=2;break;
case 2: if(dx1) stari[25]=3;break;
case 3: if(dx0&&tradxy[7]) stari[25]=4;break; //tradx[7]=ETx
case 4: if((stari[24]==2)||(stari[24]==4)) stari[25]=0;break;
}
iesiri[45]=(stari[25]==1);
iesiri[46]=(stari[25]==2);
iesiri[47]=(stari[25]==3);

switch(stari[26]){       //automatul ADY1
case 0: if((((stari[24]==1)&&dy0&&l1)||((stari[24]==3)&&dy0&&l2))&&pozc)
           stari[26]=3;
        if(((((stari[24]==1)&&dy0&&l2)||((stari[24]==3)&&dy0&&l1))&&pozc)||(stari[27]==2)||(stari[27]==7))
           stari[26]=2;
        if(((stari[24]==1)||(stari[24]==3))&&!dy0&&pozc)
           stari[26]=1;break;
case 1: if(dy0) stari[26]=2;break;
case 2: if((((stari[24]==1)||(stari[27]==7))&&l1)||(((stari[24]==3)||(stari[27]==2))&&l2)) stari[26]=3;break;
case 3: if((stari[24]==2)||(stari[24]==4)) stari[26]=0;break;
}
iesiri[48]=((dy>0)||(dy==0)&&((stari[24]==3)||(stari[27]==2)));
iesiri[49]=(stari[26]==1);
}
void run_amt(void){
switch(stari[27]){       //automatul AMT1
case 0: if(stari[24]==2) stari[27]=1;
        if(stari[24]==4) stari[27]=4;break;
case 1: if((!sr&&senzori[52])||(sr&&senzori[53])) stari[27]=2;break;
case 2: if(stari[26]==3) stari[27]=3;break;
case 3: if(senzori[51]) stari[27]=10;break;
case 4: if(senzori[57]) stari[27]=5;
        if(senzori[58]) stari[27]=9;break;
case 5: if(1) stari[27]=6;break;
case 6: if((!sr&&senzori[52])||(sr&&senzori[53])) stari[27]=7;break;
case 7: if(stari[26]==3) stari[27]=8;break;
case 8: if(senzori[51]) stari[27]=11;break;
case 9: if(cerere[13]) stari[27]=0;break;
case 10: if(stari[24]==3) stari[27]=0;break;
case 11: if(stari[24]==0) stari[27]=0;break;
}
iesiri[50]=((stari[27]==1)||(stari[27]==3)||(stari[27]==6)||(stari[27]==8))*sr;
iesiri[51]=((stari[27]==1)||(stari[27]==3)||(stari[27]==6)||(stari[27]==8))*!sr;
if(stari[27]==4) iesiri[52]=0;
if(stari[27]==5) iesiri[52]=1;
}

void main(void){
nsenzor=0;
nstoc=0;
nout=0;
nstari=0;
for(ind=0;ind<28;ind++) stari[ind]=0;
xit=0;
clrscr();
do{
citsenzor();
run_aut();
run_amt();
}while(!xit);
}