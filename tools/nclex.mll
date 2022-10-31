(* nclex.mll *)
(* Copyright (c) 2017 J. M. Spivey *)

{
open Ncparse 
open String 
open Lexing
open Print

let qflag = ref false
let fname = ref "standard input"

let line_no = ref 1
let synced = ref false

let unsync () =
  synced := false

let sync () =
  if not !synced && not !qflag then begin
    printf "# $ \"$\"\n" [fNum !line_no; fStr !fname];
    synced := true
  end
}

rule token =
  parse
      "<"(['A'-'Z''a'-'z']+|'('[^')']+')' as s)  { OPEN s }
    | "#<"(['A'-'Z''a'-'z']+|'('[^')']+')' as s)  { GOPEN s }
    | [^'<''>''('')'',''@'' ''#''\n']+ as s  { WORD s }
    | "(*"[^'\n']*"*)" as s     { WORD s }
    | "->" as s                 { WORD s }
    | ">"                       { CLOSE }
    | "("                       { LPAREN }
    | ")"                       { RPAREN }
    | ","" "* as s              { COMMA s }
    | "@"                       { ATSIGN }
    | "\n"                      { incr line_no; NL }
    | _ as c                    { CHAR c }
    | eof                       { EOF }

