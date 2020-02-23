#include<stdio.h>;
#include<conio.h>;
#include<graphics.h>;
#include<stdlib.h>;
#include<dos.h>;

const sn0=2,sn1=8,sn2=15,sn3=21,sta=30,sta1=37,cz=46,cz1=58,cz2=70;
//Variabile senzori
char s,a1,a2,b1,gab,c1,d1,ds,dd,dc,e1,f1;
char g1,gs,gj,h1,h2,st1,tns1,tni1,i1;
char j1,js,jj,k1,k2,st2,tns2,tni2;
char pp1,tj1,ts1,pp2,tj2,ts2,l1,l2,m1,ms,mj;
char n1,p1,p2,r1,rs,rj,s1,t1,ts,td,u1,v1;
char d30,d31,d32,l11,l21,palp1,pc1=1;
char d302,d312,d322,l12,l22,palp2,pc2=1;
//Variabile stari
char sa,sb,sc,sd,se,sf,sg,sh,si,sj,sk,si1,si2;
char se1,se2,sl,sp,sm,sn,sr,ss,st,su,sv;
char sap1,sadx1,sady1,samt1;
char sap2,sadx2,sady2,samt2;
//Variabile comenzi
char avra,avrb,avrc,avrd,rst,rdr,avre,avrf,avrg;
char rrg,crg,avlh,rt1,ct1,avri,avrj,rrj,crj;
char avlk,rt2,ct2,rte1,cte1,rte2,cte2,avll,avlp;
char avrm,rrm,crm,avrn,avrr,rrr,crr,avrs,avrt,rstt,rdrt,avru,avrv;
char vma1,vme1,vmi1,vnom1,vmica1,tel1;
char vma2,vme2,vmi2,vnom2,vmica2,tel2;
typedef struct{
		int x1,y1,cul,cic;
		char rft,gabar;
		}dat;
dat srt,oa,ob,oc,od,of,og,oh,oi,oj,ok,osi1,osi2,liv,evac,oap1,oap2;
char ch,ch1,ciclu,xy,val;
int adx1,ady1,adtx1,adty1,dx1,dy1,sts1;
int adx2,ady2,adtx2,adty2,dx2,dy2,sts2;
int livx1,livy1,rec1,livx2,livy2,rec2;

/*void init_afis(void)           //  initializeaza sistemul grafic , deseneaza
{
    int gd,gm,err;

    detectgraph(&gd,&gm);
	 initgraph(&gd,&gm,"c:\\borlandc\\bgi");
	 err=graphresult();
	 if (err!=0) {
			 printf("\n\n\n\n\n\n\t Eroare la initializarea sistemului grafic . ( %d )",err);
			 getch();
			 exit(1);
		 }
    setbkcolor(RED);
    setcolor(RED);
    //closegraph();

}  */



void init(){
	  clrscr();
	  textcolor(YELLOW);
	  textbackground(BLUE);
	  gotoxy(1,1);cprintf("É");
	  for(xy=2;xy<80;xy++) {gotoxy(xy,1);cprintf("Í");}
	  gotoxy(80,1);cprintf("»");
	  for(xy=2;xy<80;xy++) {gotoxy(xy,24);cprintf("Í");}
	  for(xy=2;xy<24;xy++) {gotoxy(1,xy);cprintf("º");}
	  gotoxy(1,24);cprintf("È");
	  for(xy=2;xy<24;xy++) {gotoxy(80,xy);cprintf("º");}
	  gotoxy(80,24);cprintf("¼");
	  gotoxy(1,3);cprintf("Ç");
	  for(xy=2;xy<80;xy++) {gotoxy(xy,3);cprintf("Ä");}
	  gotoxy(80,3);cprintf("¶");
	  gotoxy(1,22);cprintf("Ç");
	  gotoxy(80,22);cprintf("¶");
	  for(xy=2;xy<80;xy++) {gotoxy(xy,22);cprintf("Ä");}
	  gotoxy(7,3);cprintf("Â");
	  for(xy=4;xy<22;xy++) {gotoxy(7,xy);cprintf("³");}
	  gotoxy(7,22);cprintf("Á");
	  gotoxy(14,3);cprintf("Â");
	  for(xy=4;xy<22;xy++) {gotoxy(14,xy);cprintf("³");}
	  gotoxy(14,22);cprintf("Á");
	  gotoxy(20,3);cprintf("Â");
	  for(xy=4;xy<22;xy++) {gotoxy(20,xy);cprintf("³");}
	  gotoxy(20,22);cprintf("Á");
	  gotoxy(29,1);cprintf("Ñ");
	  for(xy=2;xy<22;xy++) {gotoxy(29,xy);cprintf("³");}
	  gotoxy(29,3);cprintf("Å");
	  gotoxy(29,22);cprintf("Á");
	  gotoxy(36,3);cprintf("Â");
	  for(xy=4;xy<22;xy++) {gotoxy(36,xy);cprintf("³");}
	  gotoxy(36,22);cprintf("Á");
	  gotoxy(45,1);cprintf("Ñ");
	  for(xy=2;xy<22;xy++) {gotoxy(45,xy);cprintf("³");}
	  gotoxy(45,3);cprintf("Å");
	  gotoxy(45,22);cprintf("Á");
	  gotoxy(57,3);cprintf("Â");
	  for(xy=4;xy<22;xy++) {gotoxy(57,xy);cprintf("³");}
	  gotoxy(57,22);cprintf("Á");
	  gotoxy(69,3);cprintf("Â");
	  for(xy=4;xy<22;xy++) {gotoxy(69,xy);cprintf("³");}
	  gotoxy(69,22);cprintf("Á");
	  gotoxy(2,2);
	  textcolor(11);
	  cprintf("     Starea senzorilor     ");
	  gotoxy(30,2);
	  cprintf("  Starile A.P. ");
	  gotoxy(46,2);
	  cprintf("             Comenzi              ");
	  textcolor(10+BLINK);
	  gotoxy(2,23);cprintf("                Apasati tasta SPACE pentru introducere de date                ");
}

void citire(){
	if(kbhit())
	{
	  ch=getch();
	  if(ch!=27)
		{
		  sound(1000);
		  delay(50);
		  nosound(); 
		}
	if(ch==32)
		{
		gotoxy(2,23);cprintf("                                                                              ");
		textcolor(YELLOW);
		textbackground(BLUE);
		gotoxy(4,23);cprintf("Culoar(0/1):");
		gotoxy(16,23);scanf("%d",&srt.cul);
		gotoxy(16,23);cprintf("%d",srt.cul);
		gotoxy(20,23);cprintf("Raft(s/d):");
		gotoxy(30,23);ch1=getche();
			if(ch1=='s') srt.rft=0;
			if(ch1=='d') srt.rft=1;
		gotoxy(34,23);cprintf("X(1-62):");
		gotoxy(42,23);scanf("%d",&srt.x1);
		gotoxy(42,23);cprintf("%d",srt.x1);
		gotoxy(46,23);cprintf("Y(1-16):");
		gotoxy(54,23);scanf("%d",&srt.y1);
		gotoxy(54,23);cprintf("%d",srt.y1);
		gotoxy(59,23);cprintf("Ciclu de(S/L/E):");
		gotoxy(75,23);ciclu=getche();
			if(ciclu=='s' || ciclu=='S') {srt.gabar=0;srt.cic=1;oa=srt;}
			if(ciclu=='l' || ciclu=='L') liv=srt;
			if(ciclu=='e' || ciclu=='E')
				{evac=srt;
				 if(evac.cul==0)
					{adtx1=evac.x1;
					 adty1=evac.y1;}
				 if(evac.cul==1)
					{adtx2=evac.x1;
					 adty2=evac.y1;}
				}
		}

		switch(ch)
		{
		case '1': if(s==0) s=1;  else	s=0; break;
		case '2': if(a1==0) a1=1;	else a1=0; break;
		case '3': if(a2==0) a2=1;  else a2=0; break;
		case '5': if(b1==0) b1=1;  else b1=0; break;
		case '4': if(gab==0) gab=1;  else gab=0; break;
		case '6': if(c1==0) c1=1;  else	c1=0; break;
		case '7': if(d1==0) d1=1;	else d1=0; break;
		case '8': if(ds==0) ds=1;  else ds=0; break;
		case '9': if(dd==0) dd=1;  else dd=0; break;
		case '0': if(dc==0) dc=1;  else dc=0; break;
		case '-': if(e1==0) e1=1;  else e1=0; break;
		case '=': if(f1==0) f1=1;  else f1=0; break;
		case 'q': if(g1==0) g1=1;  else	g1=0; break;
		case 'w': if(gs==0) gs=1;	else gs=0; break;
		case 'e': if(gj==0) gj=1;  else gj=0; break;
		case 'r': if(h1==0) h1=1;  else h1=0; break;
		case 't': if(h2==0) h2=1;  else h2=0; break;
		case 'y': if(st1==0) st1=1;  else	st1=0; break;
		case 'u': if(tns1==0) tns1=1;	else tns1=0; break;
		case 'i': if(tni1==0) tni1=1;  else tni1=0; break;
		case 'o': if(i1==0) i1=1;  else i1=0; break;
		case 'p': if(j1==0) j1=1;  else j1=0; break;
		case 'a': if(js==0) js=1;  else js=0; break;
		case 's': if(jj==0) jj=1;  else jj=0; break;
		case 'd': if(k1==0) k1=1;  else k1=0; break;
		case 'f': if(k2==0) k2=1;  else k2=0; break;
		case 'g': if(st2==0) st2=1;  else	st2=0; break;
		case 'h': if(tns2==0) tns2=1;	else tns2=0; break;
		case 'j': if(tni2==0) tni2=1; else tni2=0; break;
		case 'k': if(d30==0) d30=1;  else	d30=0; break;
		case 'l': if(d31==0) d31=1;	else d31=0; break;
		case ';': if(d32==0) d32=1;  else d32=0; break;
		case 'z': if(l11==0) l11=1;  else l11=0; break;
		case 'x': if(l21==0) l21=1;  else l21=0; break;
		case 'c': if(palp1==0) palp1=1;  else palp1=0; break;
		case 'v': if(pc1==0) pc1=1;  else pc1=0; break;
		case 'b': if(d302==0) d302=1;  else d302=0; break;
		case 'n': if(d312==0) d312=1;  else d312=0; break;
		case 'm': if(d322==0) d322=1;  else	d322=0; break;
		case ',': if(l12==0) l12=1;	else l12=0; break;
		case '.': if(l22==0) l22=1; else l22=0; break;
		case '/': if(palp2==0) palp2=1;	else palp2=0; break;
		case '\\': if(pc2==0) pc2=1; else pc2=0; break;
		case 'Q': if(pp1==0) pp1=1;  else pp1=0; break;
		case 'W': if(tj1==0) tj1=1;  else tj1=0; break;
		case 'E': if(ts1==0) ts1=1;  else ts1=0; break;
		case 'R': if(pp2==0) pp2=1;  else pp2=0; break;
		case 'T': if(tj2==0) tj2=1;  else tj2=0; break;
		case 'Y': if(ts2==0) ts2=1;  else ts2=0; break;
		case 'U': if(l1==0) l1=1;	else l1=0; break;
		case 'I': if(l2==0) l2=1;  else l2=0; break;
		case 'O': if(m1==0) m1=1;  else m1=0; break;
		case 'P': if(ms==0) ms=1;  else ms=0; break;
		case 'A': if(mj==0) mj=1;  else mj=0; break;
		case 'S': if(n1==0) n1=1;  else n1=0; break;
		case 'D': if(p1==0) p1=1;  else p1=0; break;
		case 'F': if(p2==0) p2=1;  else p2=0; break;
		case 'G': if(r1==0) r1=1;  else r1=0; break;
		case 'H': if(rs==0) rs=1;	else rs=0; break;
		case 'J': if(rj==0) rj=1;  else rj=0; break;
		case 'K': if(s1==0) s1=1;  else s1=0; break;
		case 'L': if(t1==0) t1=1;  else t1=0; break;
		case 'Z': if(ts==0) ts=1;  else ts=0; break;
		case 'X': if(td==0) td=1;  else td=0; break;
		case 'C': if(u1==0) u1=1;  else u1=0; break;
		case 'V': if(v1==0) v1=1;  else v1=0; break;
		}
	}
}

void scriere(){
 textcolor(WHITE);
 gotoxy(sn0,4);cprintf("s=%d  ",s);
 gotoxy(sn0,5);cprintf("a1=%d ",a1);
 gotoxy(sn0,6);cprintf("a2=%d ",a2);
 gotoxy(sn0,8);cprintf("b1=%d ",b1);
 gotoxy(sn0,7);cprintf("gab=%d",gab);
 gotoxy(sn0,9);cprintf("c1=%d ",c1);
 gotoxy(sn0,10);cprintf("d1=%d ",d1);
 gotoxy(sn0,11);cprintf("ds=%d ",ds);
 gotoxy(sn0,12);cprintf("dd=%d ",dd);
 gotoxy(sn0,13);cprintf("dc=%d ",dc);
 gotoxy(sn0,14);cprintf("e1=%d ",e1);
 gotoxy(sn0,15);cprintf("f1=%d ",f1);
 gotoxy(sn0,16);cprintf("g1=%d ",g1);
 gotoxy(sn0,17);cprintf("gs=%d ",gs);
 gotoxy(sn0,18);cprintf("gj=%d ",gj);
 gotoxy(sn0,19);cprintf("h1=%d ",h1);
 gotoxy(sn0,20);cprintf("h2=%d ",h2);
 gotoxy(sn0,21);cprintf("st1=%d",st1);
 gotoxy(sn1,4);cprintf("tns1=%d",tns1);
 gotoxy(sn1,5);cprintf("tni1=%d",tni1);
 gotoxy(sn1,6);cprintf("i1=%d  ",i1);
 gotoxy(sn1,7);cprintf("j1=%d  ",j1);
 gotoxy(sn1,8);cprintf("js=%d  ",js);
 gotoxy(sn1,9);cprintf("jj=%d  ",jj);
 gotoxy(sn1,10);cprintf("k1=%d  ",k1);
 gotoxy(sn1,11);cprintf("k2=%d  ",k2);
 gotoxy(sn1,12);cprintf("st2=%d ",st2);
 gotoxy(sn1,13);cprintf("tns2=%d",tns2);
 gotoxy(sn1,14);cprintf("tni2=%d",tni2);
 gotoxy(sn1,15);cprintf("pp1=%d ",pp1);
 gotoxy(sn1,16);cprintf("tj1=%d ",tj1);
 gotoxy(sn1,17);cprintf("ts1=%d ",ts1);
 gotoxy(sn1,18);cprintf("pp2=%d ",pp2);
 gotoxy(sn1,19);cprintf("tj2=%d ",tj2);
 gotoxy(sn1,20);cprintf("ts2=%d ",ts2);
 gotoxy(sn1,21);cprintf("      ");
 gotoxy(sn2,4);cprintf("l1=%d ",l1);
 gotoxy(sn2,5);cprintf("l2=%d ",l2);
 gotoxy(sn2,6);cprintf("m1=%d ",m1);
 gotoxy(sn2,7);cprintf("ms=%d ",ms);
 gotoxy(sn2,8);cprintf("mj=%d ",mj);
 gotoxy(sn2,9);cprintf("n1=%d ",n1);
 gotoxy(sn2,10);cprintf("p1=%d ",p1);
 gotoxy(sn2,11);cprintf("p2=%d ",p2);
 gotoxy(sn2,12);cprintf("r1=%d ",r1);
 gotoxy(sn2,13);cprintf("rs=%d ",rs);
 gotoxy(sn2,14);cprintf("rj=%d ",rj);
 gotoxy(sn2,15);cprintf("s1=%d ",s1);
 gotoxy(sn2,16);cprintf("t1=%d ",t1);
 gotoxy(sn2,17);cprintf("ts=%d ",ts);
 gotoxy(sn2,18);cprintf("td=%d ",td);
 gotoxy(sn2,19);cprintf("u1=%d ",u1);
 gotoxy(sn2,20);cprintf("v1=%d ",v1);
 gotoxy(sn2,21);cprintf("     ");
 gotoxy(sn3,4);cprintf("3d01=%d  ",d30);
 gotoxy(sn3,5);cprintf("3d11=%d  ",d31);
 gotoxy(sn3,6);cprintf("3d21=%d  ",d32);
 gotoxy(sn3,7);cprintf("L11=%d   ",l11);
 gotoxy(sn3,8);cprintf("L21=%d   ",l21);
 gotoxy(sn3,9);cprintf("pal1=%d  ",palp1);
 gotoxy(sn3,10);cprintf("pc1=%d   ",pc1);
 gotoxy(sn3,11);cprintf("3d02=%d  ",d302);
 gotoxy(sn3,12);cprintf("3d12=%d  ",d312);
 gotoxy(sn3,13);cprintf("3d22=%d  ",d322);
 gotoxy(sn3,14);cprintf("L12=%d   ",l12);
 gotoxy(sn3,15);cprintf("L22=%d   ",l22);
 gotoxy(sn3,16);cprintf("pal2=%d  ",palp2);
 gotoxy(sn3,17);cprintf("pc2=%d   ",pc2);
 gotoxy(sn3,18);cprintf("Acx1=%2d ",adx1);
 gotoxy(sn3,19);cprintf("Acy1=%2d ",ady1);
 gotoxy(sn3,20);cprintf("Acx2=%2d ",adx2);
 gotoxy(sn3,21);cprintf("Acy2=%2d ",ady2);
//---------------------------------------
 gotoxy(sta,4);cprintf("A=%d   ",sa);
 gotoxy(sta,5);cprintf("B=%d   ",sb);
 gotoxy(sta,6);cprintf("C=%d   ",sc);
 gotoxy(sta,7);cprintf("D=%d   ",sd);
 gotoxy(sta,8);cprintf("E=%d   ",se);
 gotoxy(sta,9);cprintf("F=%d   ",sf);
 gotoxy(sta,10);cprintf("G=%d   ",sg);
 gotoxy(sta,11);cprintf("H=%d   ",sh);
 gotoxy(sta,12);cprintf("I=%d   ",si);
 gotoxy(sta,13);cprintf("J=%d   ",sj);
 gotoxy(sta,14);cprintf("K=%d   ",sk);
 gotoxy(sta,15);cprintf("SI1=%d ",si1);
 gotoxy(sta,16);cprintf("SI2=%d ",si2);
 gotoxy(sta,17);cprintf("SE1=%d ",se1);
 gotoxy(sta,18);cprintf("SE2=%d ",se2);
 gotoxy(sta,19);cprintf("      ");
 gotoxy(sta,20);cprintf("      ");
 gotoxy(sta,21);cprintf("      ");
 gotoxy(sta1,4);cprintf("L=%d     ",sl);
 gotoxy(sta1,5);cprintf("M=%d     ",sm);
 gotoxy(sta1,6);cprintf("N=%d     ",sn);
 gotoxy(sta1,7);cprintf("P=%d     ",sn);
 gotoxy(sta1,8);cprintf("R=%d     ",sr);
 gotoxy(sta1,9);cprintf("S=%d     ",ss);
 gotoxy(sta1,10);cprintf("T=%d     ",st);
 gotoxy(sta1,11);cprintf("U=%d     ",su);
 gotoxy(sta1,12);cprintf("V=%d     ",sv);
 gotoxy(sta1,13);cprintf("AP1=%d   ",sap1);
 gotoxy(sta1,14);cprintf("ADX1=%d  ",sadx1);
 gotoxy(sta1,15);cprintf("ADY1=%d  ",sady1);
 gotoxy(sta1,16);cprintf("AMT1=%2d ",samt1);
 gotoxy(sta1,17);cprintf("AP2=%d   ",sap2);
 gotoxy(sta1,18);cprintf("ADX2=%d  ",sadx2);
 gotoxy(sta1,19);cprintf("ADY2=%d  ",sady2);
 gotoxy(sta1,20);cprintf("AMT2=%2d ",samt2);
 gotoxy(sta1,21);cprintf("        ");

//--------------------------------------
 gotoxy(cz,4);cprintf("Av.r A=%d   ",avra);
 gotoxy(cz,5);cprintf("Av.r B=%d   ",avrb);
 gotoxy(cz,6);cprintf("Av.r C=%d   ",avrc);
 gotoxy(cz,7);cprintf("Av.r D=%d   ",avrd);
 gotoxy(cz,8);cprintf("Rst. D=%d   ",rst);
 gotoxy(cz,9);cprintf("Rdr. D=%d   ",rdr);
 gotoxy(cz,10);cprintf("Av.r E=%d   ",avre);
 gotoxy(cz,11);cprintf("Av.r F=%d   ",avrf);
 gotoxy(cz,12);cprintf("Av.r G=%d   ",avrg);
 gotoxy(cz,13);cprintf("Rid.r G=%d  ",rrg);
 gotoxy(cz,14);cprintf("Cob.r G=%d  ",crg);
 gotoxy(cz,15);cprintf("Av.l H=%d   ",avlh);
 gotoxy(cz,16);cprintf("Rid.t I1=%d ",rt1);
 gotoxy(cz,17);cprintf("Cob.t I1=%d ",ct1);
 gotoxy(cz,18);cprintf("Av.r I=%d   ",avri);
 gotoxy(cz,19);cprintf("Av.r J=%d   ",avrj);
 gotoxy(cz,20);cprintf("Rid.r J=%d  ",rrj);
 gotoxy(cz,21);cprintf("Cob.r J=%d  ",crj);
 gotoxy(cz1,4);cprintf("Av.l K=%d   ",avlk);
 gotoxy(cz1,5);cprintf("Rid.t I2=%d ",rt2);
 gotoxy(cz1,6);cprintf("Cob.t I2=%d ",ct2);
 gotoxy(cz1,7);cprintf("Rid.t E1=%d ",rte1);
 gotoxy(cz1,8);cprintf("Cob.t E1=%d ",cte1);
 gotoxy(cz1,9);cprintf("Rid.t E2=%d ",rte2);
 gotoxy(cz1,10);cprintf("Cob.t E2=%d ",cte2);
 gotoxy(cz1,11);cprintf("Av.l L=%d   ",avll);
 gotoxy(cz1,12);cprintf("Av.r M=%d   ",avrm);
 gotoxy(cz1,13);cprintf("Rid.r M=%d  ",rrm);
 gotoxy(cz1,14);cprintf("Cob.r M=%d  ",crm);
 gotoxy(cz1,15);cprintf("Av.r N=%d   ",avrn);
 gotoxy(cz1,16);cprintf("Av.l P=%d   ",avlp);
 gotoxy(cz1,17);cprintf("Av.r R=%d   ",avrr);
 gotoxy(cz1,18);cprintf("Rid.r R=%d  ",rrr);
 gotoxy(cz1,19);cprintf("Cob.r R=%d  ",crr);
 gotoxy(cz1,20);cprintf("Av.r S=%d   ",avrs);
 gotoxy(cz1,21);cprintf("Av.r T=%d   ",avrt);
 gotoxy(cz2,4);cprintf("Rst. T=%d  ",rstt);
 gotoxy(cz2,5);cprintf("Rdr. T=%d  ",rdrt);
 gotoxy(cz2,6);cprintf("Av.r U=%d  ",avru);
 gotoxy(cz2,7);cprintf("Av.r V=%d  ",avrv);
 gotoxy(cz2,8);cprintf("Cvmare1=%d ",vma1);
 gotoxy(cz2,9);cprintf("Cvmed1=%d  ",vme1);
 gotoxy(cz2,10);cprintf("Cvmica1=%d ",vmi1);
 gotoxy(cz2,11);cprintf("Vnom1=%d   ",vnom1);
 gotoxy(cz2,12);cprintf("Vmica1=%d  ",vmica1);
 gotoxy(cz2,13);cprintf("Telesc1=%d ",tel1);
 gotoxy(cz2,14);cprintf("Cvmare2=%d ",vma2);
 gotoxy(cz2,15);cprintf("Cvmed2=%d  ",vme2);
 gotoxy(cz2,16);cprintf("Cvmica2=%d ",vmi2);
 gotoxy(cz2,17);cprintf("Vnom2=%d   ",vnom2);
 gotoxy(cz2,18);cprintf("Vmica2=%d  ",vmica2);
 gotoxy(cz2,19);cprintf("Telesc2=%d ",tel2);
 gotoxy(cz2,20);cprintf("          ");
 gotoxy(cz2,21);cprintf("          ");
 gotoxy(cz2,19);

}

void a(){
	if((sa==0) && a1 && s) {sa=1;avra=1;}
	if((sa==1) && a2 && (sb!=0)) {sa=2;avra=0;}
	if((sa==1) && a2 && (sb==0)) sa=3;
	if((sa==2) && (sb==0)) {sa=3; avra=1;}
	if((sa==3) && !a2) {sa=0; avra=0;ob=oa;}
	}

void b(){
	if((sb==0) && a2) {sb=1;avrb=1;}
	if((sb==1) && b1 && (sc!=0)) {sb=2;avrb=0;ob.gabar=gab;}
	if((sb==1) && b1 && (sc==0)) {sb=3;ob.gabar=gab;}
	if((sb==2) && (sc==0)) {sb=3;avrb=1;}
	if((sb==3) && !b1) {sb=0;avrb=0;oc=ob;}
	}

void c(){
	if((sc==0) && b1) {sc=1;avrc=1;}
	if((sc==1) && c1 && (sd!=0)) {sc=2;avrc=0;}
	if((sc==1) && c1 && (sd==0)) sc=3;
	if((sc==2) && (sd==0)) {sc=3;avrc=1;}
	if((sc==3) && !c1) {sc=0;avrc=0;od=oc;}
	}

void d(){
	if((sd==0) && c1) {sd=1;avrd=1;}
	if((sd==1) && d1 && (od.gabar==0)) {sd=2;avrd=0;rst=1;}
	if((sd==2) && ds && (sf!=0)) {sd=3;rst=0;}
	if((sd==2) && ds && (sf==0)) {sd=4;rst=0;avrd=1;}
	if((sd==3) && (sf==0)) {sd=4;avrd=1;}
	if((sd==4) && !d1) {sd=5;avrd=0;rdr=1;of=od;}
	if((sd==5) && dc) {sd=0;rdr=0;}
	if((sd==1) && d1 && (od.gabar==1)) {sd=6;avrd=0;rdr=1;}
	if((sd==6) && dd && (se!=0)) {sd=7;rdr=0;}
	if((sd==6) && dd && (se==0)) {sd=8;rdr=0;avrd=1;}
	if((sd==7) && (se==0)) {sd=8;avrd=1;}
	if((sd==8) && !d1) {sd=9;avrd=0;rst=1;}
	if((sd==9) && dc) {sd=0;rst=0;}
	}

void e(){
	if((se==0) && dd) {se=1;avre=1;}
	if((se==1) && e1) {se=0;avre=0;}
	}

void f(){
	if((sf==0) && ds) {sf=1;avrf=1;}
	if((sf==1) && f1 && (sg!=0)) {sf=2;avrf=0;}
	if((sf==1) && f1 && (sg==0)) sf=3;
	if((sf==2) && (sg==0)) {sf=3;avrf=1;}
	if((sf==3) && !f1) {sf=0;avrf=0;og=of;}
	}

void g(){
	if((sg==0) && f1) {sg=1;avrg=1;}
	if((sg==1) && g1 && (og.cul==0) && (sh==0)) {sg=2;avrg=0;crg=1;oh=og;}
	if((sg==1) && g1 && (og.cul==0) && (sh!=0)) {sg=7;avrg=0;}
	if((sg==1) && g1 && (og.cul==1) && (si==0)) sg=5;
	if((sg==1) && g1 && (og.cul==1) && (si!=0)) {sg=6;avrg=0;}
	if((sg==2) && gj) {sg=3;crg=0;sh=1;avlh=1;}
	if((sg==3) && ((sh==0) || (sh==3))) {sg=4;rrg=1;}
	if((sg==4) && gs) {sg=0;rrg=0;}
	if((sg==7) && (sh==0)) {sg=2;crg=1;}
	if((sg==6) && (si==0)) {sg=5;avrg=1;}
	if((sg==5) && !g1) {sg=0;avrg=0;oi=og;}
	}

void h(){
	if((sh==0) && (sg==3) && ((si1==0) || (si1==2))){sh=1;avlh=1;}
	if((sh==1) && h1 && (si1==0)) sh=2;
	if((sh==1) && h1 && (si1==2)) {sh=3;avlh=0;}
	if((sh==3) && (si1==0)) {sh=2;avlh=1;}
	if((sh==2) && h2) {sh=0;avlh=0;osi1=oh;}
	}

void i(){
	if((si==0) && (sg==5)) {si=1;avri=1;}
	if((si==1) && i1 && (sj!=0)) {si=2;avri=0;}
	if((si==1) && i1 && (sb==0)) si=3;
	if((si==2) && (sb==0)) {si=3; avri=1;}
	if((si==3) && !i1) {si=0; avri=0;oj=oi;}
	}

void j(){
	if((sj==0) && i1) {sj=1;avrj=1;}
	if((sj==1) && j1 && (oj.cul==1) && (sk==0)) {sj=2;avrj=0;crj=1;ok=oj;}
	if((sj==1) && j1 && (oj.cul==1) && (sk!=0)) {sj=5;avrj=0;}
	if((sj==5) && (sk==0)) {sj=2;crj=1;}
	if((sj==2) && jj) {sj=3;crj=0;sk=1;avlk=1;}
	if((sj==3) && ((sk==0) || (sk==3))) {sj=4;rrj=1;}
	if((sj==4) && js) {sj=0;rrj=0;}
	}

void k(){
	if((sk==0) && (sj==3) && ((si2==0) || (si2==2))) {sk=1;avlk=1;}
	if((sk==1) && k1 && (si2==0)) sk=2;
	if((sk==1) && k1 && (si2==2)) {sk=3;avlk=0;}
	if((sk==3) && (si2==0)) {sk=2;avlk=1;}
	if((sk==2) && k2) {sk=0;avlk=0;osi2=ok;}
	}

void sin1(){
	if((si1==0) && h2) {si1=1;rt1=1;}
	if((si1==1) && tns1) {oap1=osi1;si1=2;rt1=0;}
	if((si1==2) && !st1) {si1=3;ct1=1;}
	if((si1==3) && tni1) {si1=0;ct1=0;}
	}

void sin2(){
	if((si2==0) && k2) {si2=1;rt2=1;}
	if((si2==1) && tns2) {oap2=osi2;si2=2;rt2=0;}
	if((si2==2) && !st2) {si2=3;ct2=1;}
	if((si2==3) && tni2) {si2=0;ct2=0;}
	}

void sen1(){
	if((se1==0) && pp1 && d30) {se1=1;rte1=1;}
	if((se1==1) && tj1) {se1=2;rte1=0;}
	if((se1==2) && p1) {se1=3;cte1=1;}
	if((se1==3) && ts1) {se1=0;cte1=0;}
	}

void sen2(){
	if((se2==0) && pp2 && d30) {se2=1;rte2=1;}
	if((se2==1) && tj2) {se2=2;rte2=0;}
	if((se2==2) && l1) {se2=3;cte2=1;}
	if((se2==3) && ts2) {se2=0;cte2=0;}
	}
void p(){
	if((sp==0) && (sr==0) && p1 && (tj1 || ts1)) { sp=1 ; avlp=1;}
	if((sp==3) && ((sr==4) || (sr==5))) { sp=0 ; }
	if((sp==1) && p2 ) { sp=3 ;}
	if((sp==0) && p1 ) { sp=2 ; avlp=1; }
	if((sp==2) && !(sr==0)  && !p1 && tj1) { sp=0 ;}
	}

void l(){
	if((sl==0) && (sm==0) && l1 && (tj2 || ts2)) { sl=1 ; avll=1;}
	if((sl==3) && ((sm==2) || (sm==3))) { sl=0 ; }
	if((sl==1) && l2 ) { sl=3 ;}
	if((sl==0) && l1 ) { sl=2 ; avll=1; }
	if((sl==2) && !(sm==0)  && !l1 && tj2) { sl=0 ;}
	}

void m(){
	if((sm==0) && (sl==2) ) { sm=1 ; rrm=1; }
	if((sm==1) && ms && (sn==0) ) { sm=2 ; avrm=1; }
	if((sm==1) && ms && !(sn==0) )  sm=3 ;
	if((sm==2) && !m1 )  { sm=4 ; crm=1; }
	if((sm==3) && (sn==0) )  { sm=2 ; avrm=1; }
	if((sm==4) && ms )   sm=0 ;
	 }
void n(){
	if((sn==0) && m1) {sn=1;avrn=1;}
	if((sn==1) && n1 && !(sr==0)) sn=2;
	if((sn==1) && n1 && (sr==0) ) { sn=3;avrn=1; }
	if((sn==3) && !n1 ) sn=0;
	if((sn==2) && (sr==0) ) { sn=3;avrn=1; }
	}
void r(){
	if((sr==0) && (sp==2) ) { sr=2 ; rrr=1; }
	if((sr==0) && n1 && !p1 && !(sp==0) ) { sr=3 ; rrr=1; }
	if((sr==2) && rs && (ss==0) ) { sr=5 ; avrr=1; }
	if((sr==2) && rs && !(ss==0))  sr=4 ;
	if((sr==3) && rs ) { sr=1 ; avrr=1; }
	if((sr==5) && !r1 && !(n1 && !p1) ) { sr=6 ; crr=1; }
	if((sr==5) && !r1 && n1 && !p1 ) { sr=1 ; avrr=1; }
	if((sr==4) && (ss==0) ) { sr=5 ; avrr=1; }
	if((sr==1) && p1 && (ss==0) ) { sr=5 ; avrr=1; }
	if((sr==1) && p1 && !(ss==0) )  sr=4 ;
	if((sr==6) && rj)  sr=0 ;
	}
void es(){           // tronson s ;
	if((ss==0) && r1) {ss=1;avrs=1;}
	if((ss==1) && s1 && !(st==0)) ss=2;
	if((ss==1) && s1 && (st==0) ) { ss=3;avrs=1; }
	if((ss==3) && !s1 ) ss=0;
	if((ss==2) && (st==0) ) { ss=3;avrs=1; }
	}
void t(){
	if((st==0) && s1 ) { st=1 ; avrt=1; }
	if((st==1) && t1 ) { st=2 ; rstt=1; }
	if((st==2) && ts && (su==0) ) { st=3 ; avrt=1; }
	if((st==2) && ts && !(su==0) ) { st=4 ; }
	if((st==3) && !t1 ) { st=5 ; rdrt=1 ; }
	if((st==4) && (su==0) ) { st=3 ; avrt=1 ; }
	if((st==5) && td ) { st=0 ; }
        }
void u(){
	if((su==0) && t1) {su=1;avru=1;}
	if((su==1) && u1 && !(sv==0)) su=2;
	if((su==1) && u1 && (sv==0) ) { su=3;avru=1; }
	if((su==3) && !u1 ) su=0;
	if((su==2) && (sv==0) ) { su=3;avru=1; }
	}
void v() {
       if((sv==0) && u1 ) { sv=1; avrv=1;}
       if((sv==1) && v1 ) { sv=2; }
       if((sv==2) && !v1 ) { sv=0; }
       }


void ap1(){
	if((livx1!=liv.x1) && (livy1!=liv.y1)) rec1=0;
	if((sap1==0) && ((si1==2) || ((ciclu=='l') && (liv.cul==0) && !rec1)))
		{sap1=1;
		 if(oap1.cic==1) {adtx1=0;adty1=0;}
		 if(ciclu=='l') {adtx1=liv.x1;adty1=liv.y1;livx1=liv.x1;livy1=liv.y1;}
		}
	if((sap1==1) && (sadx1==4) && (sady1==3)) sap1=2;
	if((sap1==2) && (samt1==4))
		{sap1=3;
		 sts1=1;
		 if(oap1.cic==1) {adtx1=oap1.x1;adty1=oap1.y1;}
		 if(ciclu=='l') {adtx1=63;adty1=0;}
		 }
	if((sap1==3) && (sadx1==4) && (sady1==3)) sap1=4;
	if((sap1==4) && (samt1==9))
			 {sap1=0;sts1=1;
			  if((ciclu=='l') && (livx1==liv.x1) && (livy1==liv.y1)) rec1=1;
				}
	if((sap1==3) && !pc1)
		{
		sap1=5;
		gotoxy(2,23);cprintf("                                                                              ");
		gotoxy(10,23);cprintf("Pozitionare incorecta la TS1.Introduceti adresa de evacuare!");
		}
	if((sap1==5) && pc1) sap1=3;
	if((sap1==4) && (samt1==10))
		{
		sap1=6;
		gotoxy(2,23);cprintf("                                                                              ");
		gotoxy(15,23);cprintf("Eroare adresa la TS1.Introduceti adresa de evacuare!");
		}
	if((sap1==6) && !palp1) {sap1=3;}
 }

int sgn(int n)
	{
	 if(n>0) return 0;
	 if(n<0) return 1;
	 }

void atdx1(){
	dx1=adtx1-adx1;
	if((sadx1==0) && ((sap1==1) || (sap1==3)) && (abs(dx1)>3) && pc1)
		{sadx1=1;
		 vma1=1;
		 if(sgn(dx1)) adx1--; else adx1++;
		 }
	if((sadx1==0) && ((sap1==1) || (sap1==3)) && ((abs(dx1)>1) && (abs(dx1)<=3)) && pc1)
		{sadx1=2;
		 vme1=1;
		 if(sgn(dx1)) adx1--; else adx1++;
		 }
	if((sadx1==0) && ((sap1==1) || (sap1==3)) && (abs(dx1)==1) && pc1)
		{sadx1=3;
		 vmi1=1;
		 if(sgn(dx1)) adx1--; else adx1++;
		 }
	if((sadx1==0) && ((sap1==1) || (sap1==3)) && (abs(dx1)==0) && pc1)
		{sadx1=4;}
	if((sadx1==1) && ((abs(dx1)>1) && (abs(dx1)<=3)))
		{sadx1=2;
		 vma1=0;
		 vme1=1;
		 if(sgn(dx1)) adx1--; else adx1++;
		 }
	if((sadx1==2) && (abs(dx1)==1))
		{sadx1=3;
		 vme1=0;
		 vmi1=1;
		 if(sgn(dx1)) adx1--; else adx1++;
		}
	if((sadx1==3) && (abs(dx1)==0))
		{sadx1=4;
		 vmi1=0;
		 }
	if((sadx1==4) && ((sap1==2) || (sap1==4))) sadx1=0;
	if((sadx1==1) && (abs(dx1)>3))
		if(sgn(dx1)) adx1--; else adx1++;
	if((sadx1==2) && ((abs(dx1)>1) && (abs(dx1)<=3)))
		if(sgn(dx1)) adx1--; else adx1++;

}

void atdy1(){
	dy1=adty1-ady1;
	if((sady1==0) && ((sap1==1) || (sap1==3)) && (abs(dy1)!=0) && pc1)
		{sady1=1;
		 if(sgn(dy1)) ady1--; else ady1++;
		 vnom1=1;
		 }
	if((sady1==0) && (((sap1==1) && (abs(dy1)==0) && l21) || ((sap1==3) && (abs(dy1)==0) && l11)) && pc1)
		{sady1=2;
		 vmica1=1;
		 }
	if((sady1==0) && (((sap1==1) && (abs(dy1)==0) && l11) || ((sap1==3) && (abs(dy1)==0) && l21)) && pc1)
		 sady1=3;
	if((sady1==1) && (abs(dy1)==0))
		 {sady1=2;
		  vnom1=0;
		  vmica1=1;
		  }
	if((sady1==2) && ((l11 && (sap1==1)) || (l21 && (sap1==3))))
		 {sady1=3;
		  vmica1=0;
		  }
	if((sady1==3) && ((sap1==2) || (sap1==4))) sady1=0;
	if((sady1==1) && (abs(dy1)!=0))
		 if(sgn(dy1)) ady1--; else ady1++;

}

void amt1(){
	if((samt1==0) && (sap1==2))
		{samt1=1;
		 tel1=1;
		}
	if((samt1==1) && (d31 || d32))
		{samt1=2;
		 tel1=0;
		 vmica1=1;
		}
	if((samt1==2) && l21)
		{samt1=3;
		 vmica1=0;
		 tel1=1;
		 st1=0;
		}
	if((samt1==3) && d30)
		{samt1=4;
		 tel1=0;
		}
	if((samt1==4) && sts1) {samt1=0;sts1=0;}
	if((samt1==0) && (sap1==4))
		{samt1=5;
		}
	if((samt1==5) && palp1) {samt1=10;}
	if((samt1==10) && (sap1==6)) samt1=0;
	if((samt1==5) && !palp1)
		{samt1=6;
		 tel1=1;
		}
	if((samt1==6) && (d31 || d32))
		{samt1=7;
		 tel1=0;
		 vmica1=1;
		}
	if((samt1==7) && l11)
		{samt1=8;
		 vmica1=0;
		 tel1=1;
		}
	if((samt1==8) && d30)
		{samt1=9;
		 tel1=0;
		}
	if((samt1==9) && sts1) {samt1=0;sts1=0;}
}



void ap2(){
	if((livx2!=liv.x1) && (livy2!=liv.y1)) rec2=0;
	if((sap2==0) && ((si2==2) || ((ciclu=='l') && (liv.cul==1) && !rec2)))
		{sap2=1;
		 if(oap2.cic==1) {adtx2=0;adty2=0;}
		 if(ciclu=='l') {adtx2=liv.x1;adty2=liv.y1;}
		}
	if((sap2==1) && (sadx2==4) && (sady2==3)) sap2=2;
	if((sap2==2) && (samt2==4))
		{sap2=3;
		 sts2=1;
		 if(oap2.cic==1) {adtx2=oap2.x1;adty2=oap2.y1;}
		 if(ciclu=='l') {adtx2=63;adty2=0;}
		 }
	if((sap2==3) && (sadx2==4) && (sady2==3)) sap2=4;
	if((sap2==4) && (samt2==9))
			{sap2=0;sts2=1;
			  if((ciclu=='l') && (livx2==liv.x1) && (livy2==liv.y1)) rec2=1;
				}

	if((sap2==3) && !pc2)
		{
		sap2=5;
		gotoxy(2,23);cprintf("                                                                              ");
		gotoxy(10,23);cprintf("Pozitionare incorecta la TS2.Introduceti adresa de evacuare!");
		}
	if((sap2==5) && pc2) sap2=3;
	if((sap2==4) && (samt2==10))
		{
		sap2=6;
		gotoxy(2,23);cprintf("                                                                              ");
		gotoxy(15,23);cprintf("Eroare adresa la TS2.Introduceti adresa de evacuare!");
		}
	if((sap2==6) && !palp2) {sap2=3;}
 }

void atdx2(){
	dx2=adtx2-adx2;
	if((sadx2==0) && ((sap2==1) || (sap2==3)) && (abs(dx2)>3) && pc2)
		{sadx2=1;
		 vma2=1;
		 if(sgn(dx2)) adx2--; else adx2++;
		 }
	if((sadx2==0) && ((sap2==1) || (sap2==3)) && ((abs(dx2)>1) && (abs(dx2)<=3)) && pc2)
		{sadx2=2;
		 vme2=1;
		 if(sgn(dx2)) adx2--; else adx2++;
		 }
	if((sadx2==0) && ((sap2==1) || (sap2==3)) && (abs(dx2)==1) && pc2)
		{sadx2=3;
		 vmi2=1;
		 if(sgn(dx2)) adx2--; else adx2++;
		 }
	if((sadx2==0) && ((sap2==1) || (sap2==3)) && (abs(dx2)==0) && pc2)
		{sadx2=4;}
	if((sadx2==1) && ((abs(dx2)>1) && (abs(dx2)<=3)))
		{sadx2=2;
		 vma2=0;
		 vme2=1;
		 if(sgn(dx2)) adx2--; else adx2++;
		 }
	if((sadx2==2) && (abs(dx2)==1))
		{sadx2=3;
		 vme2=0;
		 vmi2=1;
		 if(sgn(dx2)) adx2--; else adx2++;
		}
	if((sadx2==3) && (abs(dx2)==0))
		{sadx2=4;
		 vmi2=0;
		 }
	if((sadx2==4) && ((sap2==2) || (sap2==4))) sadx2=0;
	if((sadx2==1) && (abs(dx2)>3))
		if(sgn(dx2)) adx2--; else adx2++;
	if((sadx2==2) && ((abs(dx2)>1) && (abs(dx2)<=3)))
		if(sgn(dx2)) adx2--; else adx2++;

}

void atdy2(){
	dy2=adty2-ady2;
	if((sady2==0) && ((sap2==1) || (sap2==3)) && (abs(dy2)!=0) && pc2)
		{sady2=1;
		 if(sgn(dy2)) ady2--; else ady2++;
		 vnom2=1;
		 }
	if((sady2==0) && (((sap2==1) && (abs(dy2)==0) && l22) || ((sap2==3) && (abs(dy2)==0) && l12)) && pc2)
		{sady2=2;
		 vmica2=1;
		 }
	if((sady2==0) && (((sap2==1) && (abs(dy2)==0) && l12) || ((sap2==3) && (abs(dy2)==0) && l22)) && pc2)
		 sady2=3;
	if((sady2==1) && (abs(dy2)==0))
		 {sady2=2;
		  vnom2=0;
		  vmica2=1;
		  }
	if((sady2==2) && ((l12 && (sap2==1)) || (l22 && (sap2==3))))
		 {sady2=3;
		  vmica2=0;
		  }
	if((sady2==3) && ((sap2==2) || (sap2==4))) sady2=0;
	if((sady2==1) && (abs(dy2)!=0))
		 if(sgn(dy2)) ady2--; else ady2++;

}

void amt2(){
	if((samt2==0) && (sap2==2))
		{samt2=1;
		 tel2=1;
		}
	if((samt2==1) && (d312 || d322))
		{samt2=2;
		 tel2=0;
		 vmica2=1;
		}
	if((samt2==2) && l22)
		{samt2=3;
		 vmica2=0;
		 tel2=1;
		 st2=0;
		}
	if((samt2==3) && d302)
		{samt2=4;
		 tel2=0;
		}
	if((samt2==4) && sts2) {samt2=0;sts2=0;}
	if((samt2==0) && (sap2==4))
		{samt2=5;
		}
	if((samt2==5) && palp2) samt2=10;
	if((samt2==10) && (sap2==6)) samt2=0;
	if((samt2==5) && !palp2)
		{samt2=6;
		 tel2=1;
		}
	if((samt2==6) && (d312 || d322))
		{samt2=7;
		 tel2=0;
		 vmica2=1;
		}
	if((samt2==7) && l12)
		{samt2=8;
		 vmica2=0;
		 tel2=1;
		}
	if((samt2==8) && d302)
		{samt2=9;
		 tel2=0;
		}
	if((samt2==9) && sts2) {samt2=0;sts2=0;}
}



main(){
// init_afis();

 init();
 while(1){
 citire();
 a();
 b();
 c();
 d();
 e();
 f();
 g();
 h();
 i();
 j();
 k();
 sin1();
 sin2();
 sen1();
 sen2();
 l();
 m();
 n();
 p();
 es(); // -ilagyi
 r();
 t();
 u();  // -ros
 v();  // -ega
 ap1();
 atdx1();
 atdy1();
 amt1();
 ap2();
 atdx2();
 atdy2();
 amt2();
 scriere();
 if(ch==27) { //clrscr();
	      exit(0); }
 delay(900);
 }
}
