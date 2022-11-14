(* lab2/dict.ml *)
(* Copyright (c) 2017 J. M. Spivey *)

(* Environments are implemented using a library module that 
   represents mappings by balanced binary trees. *)

type ident = string

type ptype = 
    Integer 
  | Boolean 
  | Array of int * ptype
  | Void

(* |def| -- definitions in environment *)
type def = 
  { d_tag: ident;               (* Name *)
    d_type: ptype;              (* Type *)
    d_lab: string }             (* Global label *)

module IdMap = Map.Make(struct type t = ident  let compare = compare end)

type environment = Env of def IdMap.t

let can f x = try f x; true with Not_found -> false

(* |define| -- add a definition *)
let define d (Env e) = 
  if can (IdMap.find d.d_tag) e then raise Exit;
  Env (IdMap.add d.d_tag d e)

(* |lookup| -- find definition of an identifier *)
let lookup x (Env e) = IdMap.find x e

(* |init_env| -- empty environment *)
let init_env = Env IdMap.empty

let rec type_size p = 
  match p with 
    Integer         -> 4
  | Boolean         -> 1
  | Array (x,y)     -> x * type_size y
  | Void            -> 0

let is_array p =
  match p with 
    Integer         -> false 
  | Boolean         -> false
  | Array _         -> true
  | Void            -> false

let rec base_type p = 
  match p with 
    Integer         -> Integer
  | Boolean         -> Boolean
  | Array (x,y)     -> base_type y
  | Void            -> Void
