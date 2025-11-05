{
module Grammars where

import Lex
}

%name parse
%tokentype { Token }
%error { parseError }

%token
  '('        { TokenLParen }
  ')'        { TokenRParen }
  '['        { TokenLBracket }
  ']'        { TokenRBracket }
  '+'        { TokenAdd }
  '-'        { TokenSub }
  '*'        { TokenMul }
  '/'        { TokenDiv }
  add1       { TokenAdd1 }
  sub1       { TokenSub1 }
  sqrt       { TokenSqrt }
  expt       { TokenExpt }
  '='        { TokenEq }
  '<'        { TokenLt }
  '>'        { TokenGt }
  '<='       { TokenLte }
  '>='       { TokenGte }
  '!='       { TokenNeq }
  and        { TokenAnd }
  or         { TokenOr }
  not        { TokenNot }
  pair       { TokenPair }
  fst        { TokenFst }
  snd        { TokenSnd }
  if         { TokenIf }
  if0        { TokenIf0 }
  cond       { TokenCond }
  '=>'       { TokenArrow }
  lambda     { TokenLambda }
  let        { TokenLet }
  let_star   { TokenLetStar }
  letrec     { TokenLetrec }
  nil        { TokenNil }
  num        { TokenNum $$ }
  bool       { TokenBool $$ }
  id         { TokenId $$ }

%left or
%left and
%left '=' '<' '>' '<=' '>=' '!='
%left '+' '-'
%left '*' '/'
%left add1 sub1 sqrt expt not

%%

Program :: { SASA }
  : Expr                        { $1 }

Expr :: { SASA }
  : num                         { SNum $1 }
  | bool                        { SBoolean $1 }
  | nil                         { SNil }
  | id                          { SId $1 }
  | '(' '+' ExprList ')'        { SAdd $3 }
  | '(' '-' ExprList ')'        { SSub $3 }
  | '(' '*' ExprList ')'        { SMul $3 }
  | '(' '/' ExprList ')'        { SDiv $3 }
  | '(' add1 Expr ')'           { SAdd1 $3 }
  | '(' sub1 Expr ')'           { SSub1 $3 }
  | '(' sqrt Expr ')'           { SSqrt $3 }
  | '(' expt Expr Expr ')'      { SExpt $3 $4 }
  | '(' '=' ExprList ')'        { SEq $3 }
  | '(' '<' ExprList ')'        { SLt $3 }
  | '(' '>' ExprList ')'        { SGt $3 }
  | '(' '<=' ExprList ')'       { SLte $3 }
  | '(' '>=' ExprList ')'       { SGte $3 }
  | '(' '!=' ExprList ')'       { SNeq $3 }
  | '(' and ExprList ')'        { SAnd $3 }
  | '(' or ExprList ')'         { SOr $3 }
  | '(' not Expr ')'            { SNot $3 }
  | '(' pair Expr Expr ')'      { SPair $3 $4 }
  | '(' fst Expr ')'            { SFst $3 }
  | '(' snd Expr ')'            { SSnd $3 }
  | '[' ExprList ']'            { SList $2 }
  | '(' if Expr Expr Expr ')'   { SIf $3 $4 $5 }
  | '(' if0 Expr Expr Expr ')'  { SIf0 $3 $4 $5 }
  | '(' cond CondClauses ')'    { SCond $3 }
  | '(' lambda '(' IdList ')' Expr ')' { SLambda $4 $6 }
  | '(' let '(' BindingList ')' Expr ')' { SLet $4 $6 }
  | '(' let_star '(' BindingList ')' Expr ')' { SLetStar $4 $6 }
  | '(' letrec '(' id Expr ')' Expr ')' { SLetrec $4 $5 $7 }
  | '(' AppExpr ')'             { SApp (head $2) (tail $2) }

AppExpr :: { [SASA] }
  : Expr Expr                   { [$1, $2] }
  | AppExpr Expr                { $1 ++ [$2] }

ExprList :: { [SASA] }
  : Expr                        { [$1] }
  | ExprList Expr               { $1 ++ [$2] }

IdList :: { [String] }
  : id                          { [$1] }
  | IdList id                   { $1 ++ [$2] }

BindingList :: { [(String, SASA)] }
  : '(' id Expr ')'             { [($2, $3)] }
  | BindingList '(' id Expr ')' { $1 ++ [($3, $4)] }

CondClauses :: { [(SASA, SASA)] }
  : '(' Expr Expr ')'           { [($2, $3)] }
  | CondClauses '(' Expr Expr ')' { $1 ++ [($3, $4)] }

{

-- ============================================================
-- SINTAXIS DE SUPERFICIE (SASA)
-- ============================================================

data SASA
  = SNum Int
  | SBoolean Bool
  | SNil
  | SId String
  -- Operadores aritméticos variádicos
  | SAdd [SASA]
  | SSub [SASA]
  | SMul [SASA]
  | SDiv [SASA]
  | SAdd1 SASA
  | SSub1 SASA
  | SSqrt SASA
  | SExpt SASA SASA
  -- Predicados variádicos
  | SEq [SASA]
  | SLt [SASA]
  | SGt [SASA]
  | SLte [SASA]
  | SGte [SASA]
  | SNeq [SASA]
  -- Operadores lógicos
  | SAnd [SASA]
  | SOr [SASA]
  | SNot SASA
  -- Pares y listas
  | SPair SASA SASA
  | SFst SASA
  | SSnd SASA
  | SList [SASA]
  -- Condicionales
  | SIf SASA SASA SASA
  | SIf0 SASA SASA SASA
  | SCond [(SASA, SASA)]
  -- Funciones
  | SLambda [String] SASA
  | SApp SASA [SASA]
  -- Vinculación
  | SLet [(String, SASA)] SASA
  | SLetStar [(String, SASA)] SASA
  | SLetrec String SASA SASA
  deriving (Show, Eq)

parseError :: [Token] -> a
parseError tokens = error $ "Parse error: " ++ show tokens

}
