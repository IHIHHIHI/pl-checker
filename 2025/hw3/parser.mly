/*
 * SNU 4190.310 Programming Languages 2024 Spring
 *  K-- Interpreter
 */

%{
type declLet = string * K.K.exp

exception EmptyBinding
exception ParsingError

let rec desugarLet : declLet * K.K.exp -> K.K.exp =
 fun (l, e) -> match l with x, e' -> K.K.LETV (x, e', e)

let rec desugarVars : declLet list -> (K.K.id * K.K.exp) list =
 fun l ->
  match l with
  | [] -> []
  | a :: r -> ( match a with x, e' -> (x, e') :: desugarVars r)
%}

%token UNIT
%token <int> NUM
%token TRUE FALSE
%token <string> ID
%token PLUS MINUS STAR SLASH EQUAL LB RB LBLOCK RBLOCK NOT COLONEQ SEMICOLON COMMA PERIOD IF THEN ELSE END
%token WHILE DO LET IN READ WRITE PROC
%token LP RP LC RC
%token EOF

%nonassoc IN
%left SEMICOLON
%nonassoc DO
%nonassoc THEN
%nonassoc ELSE
%right COLONEQ
%right WRITE
%left EQUAL LB
%left PLUS MINUS
%left STAR SLASH
%right NOT
%left PERIOD

%start program
%type <K.K.exp> program

%%

program:
    expr EOF { $1 }
  ;

expr:
    LP expr RP { $2 }
	| UNIT {K.K.UNIT}
  | MINUS NUM { K.K.NUM (-$2) }
  | NUM { K.K.NUM ($1) }
  | TRUE { K.K.TRUE }
  | FALSE { K.K.FALSE }
  | LP RP { K.K.UNIT }
  | ID { K.K.VAR ($1) }
  | expr PLUS expr { K.K.ADD ($1, $3) }
  | expr MINUS expr  {K.K.SUB ($1,$3) }
  | expr STAR expr { K.K.MUL ($1,$3) }
  | expr SLASH expr { K.K.DIV ($1,$3) }
  | expr EQUAL expr { K.K.EQUAL ($1,$3) }
  | expr LB expr { K.K.LESS ($1,$3) }
  | NOT expr { K.K.NOT ($2) }
  | ID COLONEQ expr { K.K.ASSIGN ($1,$3) }
  | expr SEMICOLON expr { K.K.SEQ ($1,$3) }
  | IF expr THEN expr ELSE expr { K.K.IF ($2, $4, $6) }
  | WHILE expr DO expr { K.K.WHILE ($2, $4) }
  | LET decl IN expr { desugarLet($2, $4) }
  | READ ID { K.K.READ ($2) }
  | WRITE expr { K.K.WRITE ($2) }
  ;
vardecl:
    ID COLONEQ expr { ($1, $3) }
	;
decl:
    vardecl { $1 }
  ;
exprs:
    expr { [$1] }
	| expr COMMA exprs { $1::$3 }
	;
%%
