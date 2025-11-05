{
module Lex (Token(..), lexer) where
import Data.Char (isSpace)
}

%wrapper "basic"

-- Espacios en blanco 
$white = [\x20\x09\x0A\x0D\x0C\x0B]
$digit = 0-9
$letter = [A-Za-z_]
$idrest = [A-Za-z0-9_\?\!]

tokens :-

  -- Ignorar espacios en blanco
  $white+               ;

  -- Delimitadores
  \(                    { \_ -> TokenPA }
  \)                    { \_ -> TokenPC }
  \[                    { \_ -> TokenCL }
  \]                    { \_ -> TokenCR }
  ","                   { \_ -> TokenComma }

  -- Operadores aritméticos básicos
  \+                    { \_ -> TokenSuma }
  \-                    { \_ -> TokenResta }
  \*                    { \_ -> TokenMul }
  \/                    { \_ -> TokenDiv }

  -- Operadores aritméticos unarios/binarios
  add1                  { \_ -> TokenAdd1 }
  sub1                  { \_ -> TokenSub1 }
  sqrt                  { \_ -> TokenSqrt }
  expt                  { \_ -> TokenExpt }

  -- Operadores de comparación
  "<="                  { \_ -> TokenLTE }
  ">="                  { \_ -> TokenGTE }
  "!="                  { \_ -> TokenNEQ }
  \=                    { \_ -> TokenEQ }
  \<                    { \_ -> TokenLT }
  \>                    { \_ -> TokenGT }

  -- Operadores lógicos
  not                   { \_ -> TokenNot }
  and                   { \_ -> TokenAnd }
  or                    { \_ -> TokenOr }


  -- Palabras reservadas 
  letrec                { \_ -> TokenLetRec }
  "let*"                { \_ -> TokenLetStar }
  let                   { \_ -> TokenLet }
  lambda                { \_ -> TokenLambda }
  if0                   { \_ -> TokenIf0 }
  if                    { \_ -> TokenIf }
  cond                  { \_ -> TokenCond }
  else                  { \_ -> TokenElse }

  -- Operadores de pares
  pair                  { \_ -> TokenPair }
  fst                   { \_ -> TokenFst }
  snd                   { \_ -> TokenSnd }

  -- Operadores de listas
  head                  { \_ -> TokenHead }
  tail                  { \_ -> TokenTail }
  "null?"               { \_ -> TokenNullQ }
  empty                 { \_ -> TokenEmpty }

  -- Booleanos
  "#t"                  { \_ -> TokenBool True }
  "#f"                  { \_ -> TokenBool False }

  -- Números con signo
  \-?$digit+            { \s -> TokenNum (read s) }

  -- Identificadores 
  $letter$idrest*       { \s -> TokenId s }

  -- Catch-all para diagnóstico
  .                     { \s -> error ("Lexical error: caracter no reconocido = "
                                      ++ show s
                                      ++ " | codepoints = "
                                      ++ show (map fromEnum s)) }

{
data Token
  = TokenId String
  | TokenNum Int
  | TokenBool Bool
  -- Delimitadores
  | TokenPA
  | TokenPC
  | TokenCL
  | TokenCR
  | TokenComma
  -- Operadores aritméticos
  | TokenSuma
  | TokenResta
  | TokenMul
  | TokenDiv
  | TokenAdd1
  | TokenSub1
  | TokenSqrt
  | TokenExpt
  -- Comparadores
  | TokenEQ
  | TokenLT
  | TokenGT
  | TokenLTE
  | TokenGTE
  | TokenNEQ
  -- Lógicos
  | TokenNot
  | TokenAnd
  | TokenOr
  -- Palabras reservadas
  | TokenLet
  | TokenLetStar
  | TokenLetRec
  | TokenLambda
  | TokenIf0
  | TokenIf
  | TokenCond
  | TokenElse
  -- Pares
  | TokenPair
  | TokenFst
  | TokenSnd
  -- Listas
  | TokenHead
  | TokenTail
  | TokenNullQ
  | TokenEmpty
  deriving (Show, Eq)

-- Normaliza espacios en blanco Unicode
normalizeSpaces :: String -> String
normalizeSpaces = map (\c -> if isSpace c then '\x20' else c)

-- Función principal del lexer
lexer :: String -> [Token]
lexer = alexScanTokens . normalizeSpaces
}