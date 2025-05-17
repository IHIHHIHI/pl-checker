/*
 * SNU 4190.310 Programming Languages 
 *
 * Parser of xexp for Homework "Continuation Passing Style"
 */

%{
exception IncorrectSelection
let whichSel = function (e, 1) -> Xexp.Fst e
      | (e, 2) -> Xexp.Snd e
      | _ -> raise IncorrectSelection
%}

%token IF THEN ELSE FN RARROW DOT
%token PLUS MINUS LP RP REC COMMA EOF RAISE HANDLE
%token <int> NUM
%token <string> ID


%right FN RARROW DOT REC
%left NUM
%nonassoc IF THEN ELSE
%left PLUS MINUS ID
%nonassoc LP
%left APP

%start program
%type <Xexp.xexp> program
%type <Xexp.xexp> expr

%%
program: expr EOF {$1}
    ;
expr: 
  | LP expr RP {$2}
  | NUM {Xexp.Num $1}
  | ID {Xexp.Var ($1)}
  | FN ID RARROW expr {Xexp.Fn($2,$4)}
  | REC ID ID RARROW expr {Xexp.Fnr($2, $3, $5)}
  | expr expr %prec APP {Xexp.App($1,$2)}
  | expr PLUS expr {Xexp.Add($1,$3)}
  | expr DOT NUM {whichSel ($1,$3)}
  | IF expr THEN expr ELSE expr {Xexp.Ifp($2,$4,$6)}
  | LP expr COMMA expr RP {Xexp.Pair ($2, $4)}
  | RAISE expr {Xexp.Raise $2}
  | expr HANDLE ID expr {Xexp.Handle ($1, $3, $4)}
    ;
%%
