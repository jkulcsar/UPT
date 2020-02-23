  unit QuickSor;
  interface
    type Tablou = array[1..10000] of integer;
    var A : Tablou;
    procedure Quick_Sort( stg, dr : integer );
  implementation
    procedure Quick_Sort( stg, dr : integer );
    var       i,j    : word;
              x, aux : integer;
    begin
      i := stg;
      j := dr ;
      x := a[ (stg+dr) div 2 ];
      repeat
        while a[i] < x do i := i+1;
        while a[j] > x do j := j-1;
          if i <= j then begin
            aux  := a[i];
            a[i] := a[j];
            a[j] := aux ;
               i := i+1 ;
               j := j-1 ;
          end;  { if }
       until i>j;
       if stg < j then Quick_Sort( stg,j );
       if dr  > i then Quick_Sort( i,dr  );
    end;  { Quick_Sort }

    begin
    end.


