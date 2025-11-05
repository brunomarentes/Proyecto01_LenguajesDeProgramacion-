{
module Grammars where

import Lex (Token(..), lexer)
}

%name parse
%tokentype { Token }
%error { parseError }

%token 
      -- Identificadores y literales
      var             { TokenId $$ }
      int             { TokenNum $$ }
      bool            { TokenBool $$ }
      
      -- Delimitadores
      '('             { TokenPA }
      ')'             { TokenPC }
      '['             { TokenCL }
      ']'             { TokenCR }
      ','             { TokenComma }
      
      -- Operadores aritméticos
      '+'             { TokenSuma }
      '-'             { TokenResta }
      '*'             { TokenMul }
      '/'             { TokenDiv }
      add1            { TokenAdd1 }
      sub1            { TokenSub1 }
      sqrt            { TokenSqrt }
      expt            { TokenExpt }
      
      -- Comparadores
      '='             { TokenEQ }
      '<'             { TokenLT }
      '>'             { TokenGT }
      '<='            { TokenLTE }
      '>='            { TokenGTE }
      '!='            { TokenNEQ }
      
      -- Lógicos
      not             { TokenNot }
      and             { TokenAnd }
      or              { TokenOr }
      
      -- Palabras reservadas
      let             { TokenLet }
      letstar         { TokenLetStar }
      letrec          { TokenLetRec }
      lambda          { TokenLambda }
      if0             { TokenIf0 }
      if              { TokenIf }
      cond            { TokenCond }
      else            { TokenElse }
      
      -- Pares
      pair            { TokenPair }
      fst             { TokenFst }
      snd             { TokenSnd }
      
      -- Listas
      head            { TokenHead }
      tail            { TokenTail }
      nullQ           { TokenNullQ }
      empty           { TokenEmpty }

%%

-- Arbol de Sintaxis Abstracta (SASA)
SASA : var                                      { IdS $1 }
     | int                                      { NumS $1 }
     | bool                                     { BooleanS $1 }
     | empty                                    { EmptyS }
     
     -- Operadores aritméticos variádicos 
     | '(' '+' SASA SASA SASAList ')'           { AddS ($3 : $4 : $5) }
     | '(' '-' SASA SASA SASAList ')'           { SubS ($3 : $4 : $5) }
     | '(' '*' SASA SASA SASAList ')'           { MulS ($3 : $4 : $5) }
     | '(' '/' SASA SASA SASAList ')'           { DivS ($3 : $4 : $5) }
     
     -- Operadores aritméticos unarios/binarios
     | '(' add1 SASA ')'                        { Add1S $3 }
     | '(' sub1 SASA ')'                        { Sub1S $3 }
     | '(' sqrt SASA ')'                        { SqrtS $3 }
     | '(' expt SASA SASA ')'                   { ExptS $3 $4 }
     
     -- Comparadores variádicos
     | '(' '=' SASA SASA SASAList ')'           { EqS ($3 : $4 : $5) }
     | '(' '<' SASA SASA SASAList ')'           { LtS ($3 : $4 : $5) }
     | '(' '>' SASA SASA SASAList ')'           { GtS ($3 : $4 : $5) }
     | '(' '<=' SASA SASA SASAList ')'          { LteS ($3 : $4 : $5) }
     | '(' '>=' SASA SASA SASAList ')'          { GteS ($3 : $4 : $5) }
     | '(' '!=' SASA SASA SASAList ')'          { NeqS ($3 : $4 : $5) }
     
     -- Lógicos
     | '(' not SASA ')'                         { NotS $3 }
     | '(' and SASA SASA SASAList ')'           { AndS ($3 : $4 : $5) }
     | '(' or SASA SASA SASAList ')'            { OrS ($3 : $4 : $5) }

     -- Pares
     | '(' pair SASA SASA ')'                   { PairS $3 $4 }
     | '(' fst SASA ')'                         { FstS $3 }
     | '(' snd SASA ')'                         { SndS $3 }
     
     -- Listas 
     | '[' ListElements ']'                     { ListS $2 }
     | '(' head SASA ')'                        { HeadS $3 }
     | '(' tail SASA ')'                        { TailS $3 }
     | '(' nullQ SASA ')'                       { NullQS $3 }
     
     -- Let variádico 
     | '(' let '(' Bindings ')' SASA ')'        { LetS $4 $6 }
     
     -- Let* variádico
     | '(' letstar '(' Bindings ')' SASA ')'    { LetStarS $4 $6 }
     
     -- Letrec
     | '(' letrec '(' var SASA ')' SASA ')'     { LetRecS $4 $5 $7 }
          
     -- Condicionales
     | '(' if0 SASA SASA SASA ')'               { If0S $3 $4 $5 }
     | '(' if SASA SASA SASA ')'                { IfS $3 $4 $5 }
     
     -- Cond con clausulado
     | '(' cond CondClauses ')'                 { CondS $3 }
     
     -- Lambda variádica 
     | '(' lambda '(' Params ')' SASA ')'       { LambdaS $4 $6 }
     
     -- Aplicación de función
     | '(' SASA AppArgs ')'                     { AppS $2 $3 }

-- Lista de expresiones 
SASAList : {- empty -}                          { [] }
         | SASA SASAList                        { $1 : $2 }

-- Elementos de lista 
ListElements : {- empty -}                      { [] }
             | SASA                             { [$1] }
             | SASA ',' ListElements            { $1 : $3 }

-- Bindings para let/let* 
Bindings : '(' var SASA ')'                     { [($2, $3)] }
         | '(' var SASA ')' Bindings            { ($2, $3) : $5 }

-- Parámetros de lambda 
Params : {- empty -}                            { [] }
       | var                                    { [$1] }
       | var Params                             { $1 : $2 }

-- Argumentos de aplicación 
AppArgs : SASA                                  { [$1] }
        | SASA AppArgs                          { $1 : $2 }

-- Cláusulas de cond 
CondClauses : CondClause                        { [$1] }
            | CondClause CondClauses            { $1 : $2 }

CondClause : '[' SASA SASA ']'                  { ClauseS $2 $3 }
           | '[' else SASA ']'                  { ElseS $3 }

{
parseError :: [Token] -> a
parseError tokens = error $ "Parse error at: " ++ show (take 10 tokens)

data SASA 
  = IdS String
  | NumS Int
  | BooleanS Bool
  | EmptyS
  
  -- Operadores aritméticos variádicos
  | AddS [SASA]
  | SubS [SASA]
  | MulS [SASA]
  | DivS [SASA]
  
  -- Operadores aritméticos unarios/binarios
  | Add1S SASA
  | Sub1S SASA
  | SqrtS SASA
  | ExptS SASA SASA
  
  -- Comparadores variádicos
  | EqS [SASA]
  | LtS [SASA]
  | GtS [SASA]
  | LteS [SASA]
  | GteS [SASA]
  | NeqS [SASA]
  
  -- Lógicos
  | NotS SASA
  | AndS [SASA]
  | OrS [SASA]

  -- Pares
  | PairS SASA SASA
  | FstS SASA
  | SndS SASA
  
  -- Listas
  | ListS [SASA]
  | HeadS SASA
  | TailS SASA
  | NullQS SASA
  
  -- Bindings
  | LetS [(String, SASA)] SASA
  | LetStarS [(String, SASA)] SASA
  | LetRecS String SASA SASA
  
  -- Condicionales
  | If0S SASA SASA SASA
  | IfS SASA SASA SASA
  | CondS [CondClause]
  
  -- Funciones
  | LambdaS [String] SASA
  | AppS SASA [SASA]
  
  deriving (Show, Eq)

-- Cláusulas de cond
data CondClause
  = ClauseS SASA SASA  
  | ElseS SASA         
  deriving (Show, Eq)
}