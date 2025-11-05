{
module Lex where
}

%wrapper "basic"

$digit = 0-9
$alpha = [a-zA-Z]
$alnum = [a-zA-Z0-9]
$white = [\ \t]

tokens :-
  $white+                  ;
  ";"[^\n]*                ;
  "#t"                     { \s -> TokenBool True }
  "#f"                     { \s -> TokenBool False }
  "("                      { \s -> TokenLParen }
  ")"                      { \s -> TokenRParen }
  "["                      { \s -> TokenLBracket }
  "]"                      { \s -> TokenRBracket }
  "+"                      { \s -> TokenAdd }
  "-"                      { \s -> TokenSub }
  "*"                      { \s -> TokenMul }
  "/"                      { \s -> TokenDiv }
  "add1"                   { \s -> TokenAdd1 }
  "sub1"                   { \s -> TokenSub1 }
  "sqrt"                   { \s -> TokenSqrt }
  "expt"                   { \s -> TokenExpt }
  "="                      { \s -> TokenEq }
  "<"                      { \s -> TokenLt }
  ">"                      { \s -> TokenGt }
  "<="                     { \s -> TokenLte }
  ">="                     { \s -> TokenGte }
  "!="                     { \s -> TokenNeq }
  "and"                    { \s -> TokenAnd }
  "or"                     { \s -> TokenOr }
  "not"                    { \s -> TokenNot }
  "pair"                   { \s -> TokenPair }
  "fst"                    { \s -> TokenFst }
  "snd"                    { \s -> TokenSnd }
  "if"                     { \s -> TokenIf }
  "if0"                    { \s -> TokenIf0 }
  "cond"                   { \s -> TokenCond }
  "=>"                     { \s -> TokenArrow }
  "lambda"                 { \s -> TokenLambda }
  "let"                    { \s -> TokenLet }
  "let\*"                  { \s -> TokenLetStar }
  "letrec"                 { \s -> TokenLetrec }
  "nil"                    { \s -> TokenNil }
  $digit+                  { \s -> TokenNum (read s) }
  $alpha [$alnum \_\?\!]*  { \s -> TokenId s }

{

data Token
  = TokenLParen
  | TokenRParen
  | TokenLBracket
  | TokenRBracket
  | TokenAdd
  | TokenSub
  | TokenMul
  | TokenDiv
  | TokenAdd1
  | TokenSub1
  | TokenSqrt
  | TokenExpt
  | TokenEq
  | TokenLt
  | TokenGt
  | TokenLte
  | TokenGte
  | TokenNeq
  | TokenAnd
  | TokenOr
  | TokenNot
  | TokenPair
  | TokenFst
  | TokenSnd
  | TokenIf
  | TokenIf0
  | TokenCond
  | TokenArrow
  | TokenLambda
  | TokenLet
  | TokenLetStar
  | TokenLetrec
  | TokenNil
  | TokenNum Int
  | TokenBool Bool
  | TokenId String
  deriving (Show, Eq)

scanner :: String -> [Token]
scanner = alexScanTokens

}
