(* lab1/repeat.p *)

begin
  i := 0;
  repeat
    i := i + 1; 
    i := i * i;
    print i; newline
  until i mod 5 = 0 ;

  i := 0;
  repeat
    print i; newline;
  until i mod 5 = 0 ;

  repeat
  until 1 ;
end.

(*<<
 1
 4
 25
 0
>>*)
