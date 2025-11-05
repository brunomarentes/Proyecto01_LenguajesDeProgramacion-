{- 
Módulo      : Desugar
Descripción : Módulo de eliminación de azúcar sintáctica para MiniLisp

Este módulo implementa la transformación de la sintaxis de superficie (SASA)
al núcleo del lenguaje (ASA). La desazucarización garantiza que
el intérprete sólo necesite evaluar primitivas binarias, currificadas y anidadas,
mientras que la sintaxis de superficie mantiene su expresividad.

SASA --(desugar)--> ASA 

Autores:  -Lorena González Téllez
          -Leslie Renée López Rodríguez
          -Bruno Sebastián Marentes Mosqueda-}

module Desugar where

import Grammars

--Tipos de dato ASA---------------------------------------------

{-Definición del Árbol de Sintaxis Abstracta (núcleo del lenguaje).

El ASA contiene solo los constructores primitivos necesarios para
representar programas MiniLisp. Todos los demás constructores de la
sintaxis de superficie son azúcar sintáctica que se elimina en
la fase de desazucarización.-}
data ASA
  -- Literales: valores básicos sin necesidad de evaluación
  = Id String                       --Identificador de variable
  | Num Int                         --Constante entera
  | Boolean Bool                    --Constante booleana (#t o #f)

  -- Operadores aritméticos binarios del núcleo
  | Add ASA ASA                     --Suma             (e1 + e2)
  | Sub ASA ASA                     --Resta            (e1 - e2)
  | Mul ASA ASA                     --Multiplicación   (e1 * e2)
  | Div ASA ASA                     --División         (e1 / e2)

  -- Operadores unarios/binarios especiales
  | Add1 ASA                        --Incremento       (e + 1)
  | Sub1 ASA                        --Decremento       (e - 1)
  | Sqrt ASA                        --Raíz cuadrada    (sqrt e)
  | Expt ASA ASA                    --Potencia         (e1 ^ e2)

  -- Comparadores binarios
  | Eq ASA ASA                      --Igualdad         (e1 = e2)
  | Lt ASA ASA                      --Menor que        (e1 < e2)
  | Gt ASA ASA                      --Mayor que       (e1 > e2)
  | Lte ASA ASA                     --Menor o igual    (e1 <= e2)
  | Gte ASA ASA                     --Mayor o igual    (e1 >= e2)
  | Neq ASA ASA                     --Desigualdad      (e1 != e2)

  -- Operadores lógicos
  | Not ASA                         --Negación           (not e)
  | And ASA ASA                     --Conjunción lógica  (and e1 e2)
  | Or ASA ASA                      --Disyunción lógica  (or e1 e2)

  -- Estructuras de datos: pares como primitiva
  | Pair ASA ASA                    --Construir par (pair e1 e2)
  | Fst ASA                         --Primer elemento (fst e)
  | Snd ASA                         --Segundo elemento (snd e)
  | Nil                             --Lista vacía (empty)

  -- Control de flujo: único condicional en el núcleo
  | If ASA ASA ASA                  --If (cond then else)

  -- Funciones y aplicación: currificadas y binarias
  | Fun String ASA                  --Función currificada: lambda con 1 parámetro
  | App ASA ASA                     --Aplicación binaria: (f a)

  deriving (Show, Eq)

--Desugar---------------------------------------------------------

{-Función principal que transforma SASA a ASA.

La desazucarización es un proceso recursivo que elimina todos los
constructores de azúcar sintáctica, reemplazándolos por equivalentes
del núcleo-}
desugar :: SASA -> ASA -- ======================================================

--Literales e identificadores-------------------------------------

{-Literales e identificadores se transforman sin necesidad de desazucarización.
Y ya son parte del núcleo-}
desugar (IdS i) = Id i
desugar (NumS n) = Num n
desugar (BooleanS b) = Boolean b
desugar EmptyS = Nil

--Operadores aritméticos variádicos------------------------------

{-Los operadores variádicos se transforman a operaciones binarias 
anidadas que asocian a la izquierda-}

{-Suma variádica: (+ 1 2 3) significa "sumar todos los argumentos"
Se implementa como suma binaria anidada:
(+ 1 2 3) => (+ (+ 1 2) 3)
-}
desugar (AddS [e]) = desugar e
desugar (AddS [e1, e2]) = Add (desugar e1) (desugar e2)
desugar (AddS (e1:e2:rest)) = desugar (AddS (AddS [e1, e2] : rest))
desugar (AddS []) = error "Add requiere al menos 1 argumento"

{-Resta variádica: (- 10 3 2) significa "restar todos los argumentos"
Se implementa como resta binaria anidada:
(- 10 3 2) => (- (- 10 3) 2)-}
desugar (SubS [e]) = desugar e
desugar (SubS [e1, e2]) = Sub (desugar e1) (desugar e2)
desugar (SubS (e1:e2:rest)) = desugar (SubS (SubS [e1, e2] : rest))
desugar (SubS []) = error "Sub requiere al menos 1 argumento"

{-Multiplicación variádica: (* 2 3 4) significa "multiplicar todos los argumentos"
Se implementa como multiplicación binaria anidada:
(* 2 3 4) => (* (* 2 3) 4)-}
desugar (MulS [e]) = desugar e
desugar (MulS [e1, e2]) = Mul (desugar e1) (desugar e2)
desugar (MulS (e1:e2:rest)) = desugar (MulS (MulS [e1, e2] : rest))
desugar (MulS []) = error "Mul requiere al menos 1 argumento"

{-División variádica: (/ 24 2 3) significa "dividir todos los argumentos"
Se implementa como división binaria anidada:
(/ 24 2 3) => (/ (/ 24 2) 3)-}
desugar (DivS [e]) = desugar e
desugar (DivS [e1, e2]) = Div (desugar e1) (desugar e2)
desugar (DivS (e1:e2:rest)) = desugar (DivS (DivS [e1, e2] : rest))
desugar (DivS []) = error "Div requiere al menos 1 argumento"

--Operadores unarios y binarios especiales---------------------------

{- Incrementos y decrementos unarios, raíz cuadrada y potencia binaria-}
desugar (Add1S e) = Add1 (desugar e)
desugar (Sub1S e) = Sub1 (desugar e)
desugar (SqrtS e) = Sqrt (desugar e)
desugar (ExptS base exp) = Expt (desugar base) (desugar exp)

--Comparadores variádicos-------------------------------------------------

{-Los comparadores variádicos se desazucarizan a cadenas de comparaciones
binarias combinadas.-}

{-Igualdad variádica: (= 1 2 3) significa "todos los argumentos son iguales"
Se implementa como AND de comparaciones:(and (= 1 2) (and (= 2 3) #f))-}
desugar (EqS [e]) = Boolean True
desugar (EqS [e1, e2]) = Eq (desugar e1) (desugar e2)
desugar (EqS (e1:e2:rest)) = 
  desugarAnd (Eq (desugar e1) (desugar e2)) (desugar (EqS (e2:rest)))
desugar (EqS []) = error "Eq requiere al menos 1 argumento"

{-Menor que variádico: (< 1 2 3) significa "todos los pares consecutivos cumplen e_i < e_{i+1}"
Se implementa como AND de comparaciones: (and (< 1 2) (and (< 2 3) #t))-}
desugar (LtS [e]) = Boolean True
desugar (LtS [e1, e2]) = Lt (desugar e1) (desugar e2)
desugar (LtS (e1:e2:rest)) = 
  desugarAnd (Lt (desugar e1) (desugar e2)) (desugar (LtS (e2:rest)))
desugar (LtS []) = error "Lt requiere al menos 1 argumento"

{-Mayor que variádico: (> 5 3 1) significa "todos los pares consecutivos cumplen e_i > e_{i+1}"
Se implementa como AND de comparaciones: (and (> 5 3) (and (> 3 1) #t))-}
desugar (GtS [e]) = Boolean True
desugar (GtS [e1, e2]) = Gt (desugar e1) (desugar e2)
desugar (GtS (e1:e2:rest)) = 
  desugarAnd (Gt (desugar e1) (desugar e2)) (desugar (GtS (e2:rest)))
desugar (GtS []) = error "Gt requiere al menos 1 argumento"

{-Menor o igual variádico: (<= 1 2 3) significa "existe al menos un par menor"
Se implementa como AND de comparaciones:(and (<= 1 2) (and (<= 2 3) #f))-}
desugar (LteS [e]) = Boolean True
desugar (LteS [e1, e2]) = Lte (desugar e1) (desugar e2)
desugar (LteS (e1:e2:rest)) = 
  desugarAnd (Lte (desugar e1) (desugar e2)) (desugar (LteS (e2:rest)))
desugar (LteS []) = error "Lte requiere al menos 1 argumento"


{-Mayor o igual variádico: (>= 5 3 1) significa "existe al menos un par mayor"
Se implementa como AND de comparaciones:(and (>= 5 3) (and (>= 3 1) #f))-}
desugar (GteS [e]) = Boolean True
desugar (GteS [e1, e2]) = Gte (desugar e1) (desugar e2)
desugar (GteS (e1:e2:rest)) = 
  desugarAnd (Gte (desugar e1) (desugar e2)) (desugar (GteS (e2:rest)))
desugar (GteS []) = error "Gte requiere al menos 1 argumento"

{-Desigualdad variádica: (!=  a b c) significa "existe al menos un par diferente"
Se implementa como OR de comparaciones: (!= a b) OR (!= b c)-}
desugar (NeqS [e]) = Boolean True
desugar (NeqS [e1, e2]) = Neq (desugar e1) (desugar e2)
desugar (NeqS (e1:e2:rest)) = 
  Or (Neq (desugar e1) (desugar e2)) (desugar (NeqS (e2:rest)))
desugar (NeqS []) = error "Neq requiere al menos 1 argumento"

--Operadores lógicos variádicos-----------------------------------------

{-Negación: (not e) significa "negación lógica de e"
Se implementa directamente como Not del núcleo-}
desugar (NotS e) = Not (desugar e)

{-AND variádico: (and e1 e2 e3) significa "todos los argumentos son verdaderos"
Se implementa como AND binario anidado: (and e1 (and e2 e3))-}
desugar (AndS []) = Boolean True           
desugar (AndS [e]) = desugar e             
desugar (AndS [e1, e2]) = And (desugar e1) (desugar e2)  
desugar (AndS (e1:e2:es)) = And (desugar e1) (desugar (AndS (e2:es)))  

{-OR variádico: (or e1 e2 e3) significa "existe al menos un argumento verdadero"
Se implementa como OR binario anidado: (or e1 (or e2 e3))-}
desugar (OrS []) = Boolean False           
desugar (OrS [e]) = desugar e              
desugar (OrS [e1, e2]) = Or (desugar e1) (desugar e2)   
desugar (OrS (e1:e2:es)) = Or (desugar e1) (desugar (OrS (e2:es)))  

--Pares------------------------------------------------------------

{-Los pares se desazucarizan directamente a los constructores del núcleo.
Ejemplo: (pair 1 2) desazucariza a (pair 1 2)-}
desugar (PairS e1 e2) = Pair (desugar e1) (desugar e2)
desugar (FstS e) = Fst (desugar e)
desugar (SndS e) = Snd (desugar e)

--Listas----------------------------------------------------------

{-Las listas se representan internamente como cadenas de pares terminadas en Nil.-}
desugar (ListS []) = Nil
desugar (ListS (e:es)) = Pair (desugar e) (desugar (ListS es))

{-head y tail se desazucarizan como fst y snd respectivamente.
significan "primer elemento de la lista" y "resto de la lista".

null? se desazucariza como comparación con Nil.-}
desugar (HeadS e) = Fst (desugar e)
desugar (TailS e) = Snd (desugar e)
desugar (NullQS e) = Eq (desugar e) Nil

--Let y Let*------------------------------------------------------

{-Let se desazucariza a aplicaciones de funciones anidadas.

Semántica: Todas las expresiones de valor se evalúan en el ambiente
actual, luego se vinculan todas simultáneamente.-}
desugar (LetS [] body) = desugar body
desugar (LetS [(x, v)] body) = 
  App (Fun x (desugar body)) (desugar v)
desugar (LetS ((x, v):rest) body) = 
  App (Fun x (desugar (LetS rest body))) (desugar v)

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

{-Let* se desazucariza igual que let, pero con semántica secuencial-}
desugar (LetStarS [] body) = desugar body
desugar (LetStarS [(x, v)] body) = 
  App (Fun x (desugar body)) (desugar v)
desugar (LetStarS ((x, v):rest) body) = 
  App (Fun x (desugar (LetStarS rest body))) (desugar v)

--Letrec--------------------------------------------------------

{-Letrec se desazucariza usando el combinador Z.

Combinador Z:
  Z = λf. (λx. f (λy. (x x) y)) (λx. f (λy. (x x) y))-}
desugar (LetRecS f fdef body) = 
  desugar (LetS [(f, AppS (IdS "Z") [LambdaS [f] fdef])] body)

--Condicionales----------------------------------------------------

{-If0 se desazucariza a un condicional If que compara con 0.
(if0 cond then else) desazucariza a (if (= cond 0) then else)
significa "si cond es 0, entonces then, sino else".-}
desugar (If0S cond thenE elseE) = 
  If (Eq (desugar cond) (Num 0)) (desugar thenE) (desugar elseE)

{-If se desazucariza directamente al constructor If del núcleo.
(if cond then else) desazucariza a (if cond then else)-}
desugar (IfS cond thenE elseE) = 
  If (desugar cond) (desugar thenE) (desugar elseE)

{-Cond se desazucariza a una serie de if anidados.-}
desugar (CondS clauses) = desugarCond clauses
  where
    -- Desazucariza lista de cláusulas a if anidados
    desugarCond [] = error "cond sin cláusulas"
    desugarCond [ElseS e] = desugar e  
    desugarCond [ClauseS c e] = 
      If (desugar c) (desugar e) (error "cond sin else al final")
    desugarCond (ClauseS c e : rest) = 
      If (desugar c) (desugar e) (desugarCond rest)
    desugarCond (ElseS e : rest) = 
      error "else debe ser la última cláusula de cond"

--Lambda variádica----------------------------------------------------

{-Las funciones con múltiples parámetros se desazucarizan a funciones
currificadas con un parámetro cada una.-}
desugar (LambdaS [] body) = desugar body
desugar (LambdaS [x] body) = Fun x (desugar body)
desugar (LambdaS (x:xs) body) = 
  Fun x (desugar (LambdaS xs body))

--aplicaciones variádicas--------------------------------------------

{-Las aplicaciones variádicas se desazucarizan a aplicaciones binarias
anidadas, asociativas por izquierda.-}
desugar (AppS f []) = desugar f
desugar (AppS f [a]) = App (desugar f) (desugar a)
desugar (AppS f (a:as)) = desugar (AppS (AppS f [a]) as)





--funciones auxiliares--------------------------------------------

{-Desazucariza AND como condicional IF.
la usamos en los comparadores-}
desugarAnd :: ASA -> ASA -> ASA
desugarAnd e1 e2 = If e1 e2 (Boolean False)
