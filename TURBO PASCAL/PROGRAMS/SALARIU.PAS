program Salariu ;
uses Crt ;
type Zile = ( Luni, Marti, Miercuri, Joi, Vineri, Simbata, Duminica );
const a=' Ore de lucru ';
     linie = '-------------------------------------------------';
var
   plata : real ;
   zi    : zile ;
   S     : real ;
   oreluni,oremarti,oremierc,orejoi,orevin,oresim,oredum : integer ;
   lu, ma, mi, jo, vi, si, du : real ;
begin
   ClrScr ;
   write(' Calcul de salariu ' );   writeln;  writeln(linie);
   write ( ' Plata pe ora = '); read(plata);  writeln(linie);
   write (a, ' - Luni     = ' ); read (oreluni);
   write (a, ' - Marti    = '); read (oremarti);
   write (a, ' - Miercuri = ');read(oremierc);
   write (a, ' - Joi      = '); read(orejoi);
   write (a, ' - Vineri   = ');read(orevin);
   write (a, ' - Simbata  = ');read(oresim);
   write (a, ' - Duminica = ');read(oredum);
    for zi := Luni to Duminica do
      case Zi of
       Luni    : lu := plata * oreluni ;
       Marti   : ma := plata * oremarti;
       Miercuri: mi := plata * oremierc;
       Joi     : jo := plata * orejoi ;
       Vineri  : vi := plata * orevin ;
       Simbata : si := plata * oresim * 1.5;
       Duminica: du := plata * oredum * 2;
    end;
     S := lu+ma+mi+jo+vi+si+du ;
     writeln(linie);
     writeln(' Salariul pe saptamina aceasta : ',S:8:2,' lei ');
     writeln(linie);
     repeat until KeyPressed ;
   end.
