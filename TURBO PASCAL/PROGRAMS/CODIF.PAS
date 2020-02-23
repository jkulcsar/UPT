 program Codificare;
 uses Crt;
  const n=5; linie='--------------------------------------------------------';
 type MatNum  = array[1..n,1..n] of integer ;
      MatCar  = array[1..n,1..n] of char;
      tipsir     = array[1..8] of integer ;
      tipsirch   = array[1..10] of char;
  var i,j,k      : byte;
       Num       : MatNum;
       Car       : MatCar;
       Msg       : tipsirch; tasta:char;
  procedure CitMatNum( var m : MatNum ; ch : char );
  begin
   writeln('Introduceti elementele matricii : ');
   for i:=1 to n do begin
    for j:=1 to n do begin
      if (i=1) or (j=1) or (i=n) or (j=n) then m[i,j]:=1000 else begin
                                                write(' ',ch,'[ ',i-1,j-1,']= ');
                                                readln(m[i,j]); end;
   end;
    end;
  end; { CitMatNum }

   procedure CitMatCar( var p : MatCar ; ch : char );
  begin
   writeln('Introduceti elementele matricii : ');
   for i:=1 to n do begin
    for j:=1 to n do begin
      if (i=1) or (j=1) or (i=n) or (j=n) then p[i,j]:='0' else begin
                                             write(' ',ch,'[ ',i-1,j-1,']= ');
                                             readln(p[i,j]); end;

    end;  end;end;

  procedure AlegeMin(var m:MatNum);
  var s:tipsir; aux:integer;   t,z:byte;
  begin
   for t:=1 to 8 do s[t]:=0;
     s[1]:=m[i-1,j-1]; s[2]:=m[i,j-1]; s[3]:=m[i+1,j+1];
     s[4]:=m[i-1,j]; s[5]:=m[i,j+1]; s[6]:=m[i+1,j];
     s[7]:=m[i-1,j-1];s[8]:=m[i+1,j+1];
     aux:=MaxInt;
   for t:=1 to 8 do begin
     if s[t]<=aux then aux:=s[t]; end;
   write(aux:5);
  end; { AlegeMin }

  procedure CitSirCodif( var Msg:TipSirCh);
  begin
   writeln('Introduceti sirul de codificat : ');
   for k:=1 to 10 do begin write('El. ',k:2,'.',' '); readln(Msg[k]);end;
   end; { CitSirCodif }

   procedure Codifica( var m:MatNum; var p:Matcar; var Msg:tipsirch );
   var s:tipsir;
   begin
   writeln(' Sirul codificat : ');
   for k:=1 to 10 do begin
     for i:=2 to n-1 do begin
       for j:=2 to n-1 do begin
         if (Msg[k]=p[i,j]) then  AlegeMin(Num);
       end;
     end;
   end;
  end; { Codifica }


  procedure AfisMatNum( var m:MatNum );
  begin
    for i:=2 to n-1 do begin
     writeln;
     for j:=2 to n-1 do write(m[i,j]:6); end;
   end; { AfisMat }

  procedure AfisMatCar( var p:MatCar );
  begin
    for i:=2 to n-1 do begin
     writeln;
     for j:=2 to n-1 do write(p[i,j]:6); end;
   end; { AfisMat }

   procedure AfisSirCodif( var Msg:tipsirch );
   var p:byte;
   begin
     for p:=1 to 10 do write(Msg[p]:2);
   end;  { AfisSirCodif }

   begin  { main }
    repeat
    ClrScr;CitMatNum(Num,'N');
    ClrScr;CitMatCar(Car,'C');
    ClrScr;CitSirCodif(Msg);
    ClrScr;AfisMatNum(Num);writeln;write(linie); AfisMatCar(Car);writeln;writeln(linie);
    AfisSirCodif(Msg);writeln;writeln(linie); Codifica(Num,Car,Msg);writeln;writeln(linie);
    writeln('Doriti sa codificati inca un sir? (y/n) ');read(tasta);
    until tasta='n'
   end.   { main }


