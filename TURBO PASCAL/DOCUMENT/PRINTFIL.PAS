
  procedure TiparesteMatricea( var Mtr : Matrice; NrLinii : integer; NrColoane : integer );
  var i,j : byte;
  begin
       for i := 1 to NrLinii do begin
           writeln(Lst);
           for j := 1 to NrColoane do write( Lst,Mtr[i,j]:8:3 );
       end; { for i }
       writeln(Lst,' ');
  end; { TiparesteMatricea }

  procedure TiparesteVector( var V : Vector; Lungime : byte );
  var i : byte;
  begin
       writeln(Lst);writeln(Lst);
       for i := 1 to Lungime do writeln(Lst, V[i]:10:3 );
  end; { TiparesteVector }

  procedure TiparesteFunctiileInterpolare;
  var p,q : byte;
      idx : byte;
      Semn : string[2];
  begin
     for p := 1 to Grade do begin
         writeln(Lst,' Functiile de interpolare pentru cupla  ',p);
         writeln(Lst,' Segment ');
         writeln(Lst,' ');
         for q := 1 to Nmax-1 do begin
            write(Lst,'    ',q,'   F(t) =  ');
            if (q = 1) or (q = (Nmax-1)) then
            with Segment[q] do
                for idx := 1 to 5 do begin
                    if idx = 1 then write(Lst,B[idx,p]:5:3)
                       else if idx = 2 then begin
                                               if B[idx,p] >=0 then write(Lst,'+',B[idx,p]:5:3,'*t ')
                                               else write(Lst,B[idx,p]:5:3,'*t');
                                            end
                       else if B[idx,p] >= 0 then write(Lst,'+',B[idx,p]:5:3,'*t',idx-1)
                                             else write(Lst,B[idx,p]:5:3,'*t',idx-1);

                end
             else with Segment[q] do
                       for idx := 1 to 4 do begin
                           if idx = 1 then write(Lst,B[idx,p]:5:3)
                           else if idx = 2 then begin
                                                   if B[idx,p] >=0 then write(Lst,'+',B[idx,p]:5:3,'*t')
                                                   else write(Lst,B[idx,p]:5:3,'*t');
                                                end
                           else if B[idx,p] >= 0 then write(Lst,'+',B[idx,p]:5:3,'*t',idx-1)
                                                 else write(Lst,B[idx,p]:5:3,'*t',idx-1);
                       end;
             writeln(Lst,' ');
             writeln(Lst,' ');
         end;  { for q }
         writeln(Lst,' ');
     end; { for p }
     writeln(Lst,' ');
  end;

  procedure TiparesteDate;
  var  op : char;
       MarFer : word;
  begin
     Message('Pentru imprimare :    F - functiile de interpolare       D - Vectorul de timp , matricea A, matricea M');
     op := ReadKey;  op := upcase(op);
     case op of
          'D' : begin
                   writeln(Lst, ' Valorile timpilor necesari descrierii fiecarei curbe Spline :');
                   TiparesteVector(T,Nmax);
                   writeln(Lst,' ');writeln(Lst,' ');writeln(Lst,' ');
                   writeln(Lst,' Matricea M este : ');
                   writeln(Lst, ' Valorile timpilor reali necesari descrierii fiecarei curbe Spline :');
                   TiparesteVector(RealTime,Nmax);
                   writeln(Lst,' ');writeln(Lst,' ');writeln(Lst,' ');
                   TiparesteMatricea(MSalv, Nmax-2,Nmax-2);
                   writeln(Lst,' ');writeln(Lst,' ');writeln(Lst,' ');
                   writeln(Lst,' Matricea A este : ');
                   TiparesteMatricea( ASalv,Nmax-2,Grade );
                 end;
           'F' : TiparesteFunctiileInterpolare;
     end; { case }
  end; { TiparesteGrafice }