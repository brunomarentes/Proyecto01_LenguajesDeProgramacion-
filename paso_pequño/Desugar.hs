{- 
Módulo      : Desugar 
Descripción : Módulo de eliminación de azúcar sintáctica para MiniLisp paso_pequeño

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
  = Id String                             --Identificador de variable
  | Num Int                               --Constante entera
  | Boolean Bool                          --Constante booleana  
  -- Operadores aritméticos
  | Add ASA ASA                           --Suma                  (e1 + e2)
  | Sub ASA ASA                           -- Resta                (e1 - e2)
  | Mul ASA ASA                           -- Multiplicación       (e1 * e2)
  | Div ASA ASA                           -- División             (e1 / e2)
-- Operadores unarios/binarios especiales     
  | Add1 ASA                              -- Incremento           (e + 1)
  | Sub1 ASA                              -- Decremento           (e - 1)
  | Sqrt ASA                              -- Raíz cuadrada        (sqrt e)
  | Expt ASA ASA                          -- Potencia             (e1 ^ e2)
  -- Predicados binarios
  | Eq ASA ASA                            -- Igualdad             (e1 == e2)
  | Lt ASA ASA                            -- Menor que            (e1 < e2)
  | Gt ASA ASA                            -- Mayor que            (e1 > e2)
  | Lte ASA ASA                           -- Menor o igual        (e1 <= e2)
  | Gte ASA ASA                           -- Mayor o igual        (e1 >= e2)
  | Neq ASA ASA                           -- Diferente            (e1 != e2)
  -- Operadores lógicos
  | And ASA ASA                           -- Conjunción lógica    (and e1 e2)
  | Or ASA ASA                            -- Disyunción lógica    (or e1 e2)
  | Not ASA                               -- Negación             (not e)
  -- Pares y listas 
  | Pair ASA ASA                          -- Par                  (pair e1 e2)
  | Fst ASA                               -- Primer elemento      (fst e)
  | Snd ASA                               -- Segundo elemento     (snd e)
  | Nil                                   -- Lista vacía          (empty )
  -- Condicional
  | If ASA ASA ASA                        -- Condicional          (if c t e)
  -- Funciones
  | Fun String ASA                        -- Función              (lambda (param) body)
  | App ASA ASA                           -- Aplicación           (f arg)
  deriving (Show, Eq)

--Tipos de dato ASAValues---------------------------------------
{-Definición del Árbol de Sintaxis Abstracta para Valores (ASAValues).-}
data ASAValues
  = IdV String
  | NumV Int
  | BooleanV Bool
  -- Operadores aritméticos
  | AddV ASAValues ASAValues
  | SubV ASAValues ASAValues
  | MulV ASAValues ASAValues
  | DivV ASAValues ASAValues
  | Add1V ASAValues
  | Sub1V ASAValues
  | SqrtV ASAValues
  | ExptV ASAValues ASAValues
  -- Predicados binarios
  | EqV ASAValues ASAValues
  | LtV ASAValues ASAValues
  | GtV ASAValues ASAValues
  | LteV ASAValues ASAValues
  | GteV ASAValues ASAValues
  | NeqV ASAValues ASAValues
  -- Operadores lógicos
  | AndV ASAValues ASAValues
  | OrV ASAValues ASAValues
  | NotV ASAValues
  -- Pares y listas
  | PairV ASAValues ASAValues
  | FstV ASAValues
  | SndV ASAValues
  | NilV
  -- Condicional
  | IfV ASAValues ASAValues ASAValues
  -- Funciones
  | FunV String ASAValues
  | ExprV ASAValues [(String, ASAValues)]   -- NUEVO
  | ClosureV String ASAValues [(String, ASAValues)]
  | AppV ASAValues ASAValues
  deriving (Show, Eq)

--Desugar---------------------------------------------------------

{-Función principal que transforma SASA a ASA.

La desazucarización es un proceso recursivo que elimina todos los
constructores de azúcar sintáctica, reemplazándolos por equivalentes
del núcleo-}
desugar :: SASA -> ASA



--Literales e identificadores-------------------------------------

{-Literales e identificadores se transforman sin necesidad de desazucarización.
Y ya son parte del núcleo-}
desugar (SNum n) = Num n
desugar (SBoolean b) = Boolean b
desugar SNil = Nil

{-Caso especial: 'empty' como identificador → Nil
Permite escribir 'empty' directamente sin modificar el parser-}
desugar (SId "empty") = Nil

{-Identificadores normales-}
desugar (SId i) = Id i



--Operadores aritméticos variádicos------------------------------

{-Los operadores variádicos se transforman a operaciones binarias 
anidadas que asocian a la izquierda-}

{-Suma variádica: (+ 1 2 3) significa "sumar todos los argumentos"
Se implementa como suma binaria anidada:
(+ 1 2 3) => (+ (+ 1 2) 3)-}
desugar (SAdd []) = error "add: requiere al menos un argumento"
desugar (SAdd [e]) = desugar e
desugar (SAdd [e1, e2]) = Add (desugar e1) (desugar e2)
desugar (SAdd (e1:e2:rest)) = desugar (SAdd (SAdd [e1, e2] : rest))

{-Resta variádica: (- 10 3 2) significa "restar todos los argumentos"
Se implementa como resta binaria anidada:
(- 10 3 2) => (- (- 10 3) 2)-}
desugar (SSub []) = error "sub: requiere al menos un argumento"
desugar (SSub [e]) = desugar e
desugar (SSub [e1, e2]) = Sub (desugar e1) (desugar e2)
desugar (SSub (e1:e2:rest)) = desugar (SSub (SSub [e1, e2] : rest))

{-Multiplicación variádica: (* 2 3 4) significa "multiplicar todos los argumentos"
Se implementa como multiplicación binaria anidada:
(* 2 3 4) => (* (* 2 3) 4)-}
desugar (SMul []) = error "mul: requiere al menos un argumento"
desugar (SMul [e]) = desugar e
desugar (SMul [e1, e2]) = Mul (desugar e1) (desugar e2)
desugar (SMul (e1:e2:rest)) = desugar (SMul (SMul [e1, e2] : rest))

{-División variádica: (/ 24 2 3) significa "dividir todos los argumentos"
Se implementa como división binaria anidada:
(/ 24 2 3) => (/ (/ 24 2) 3)-}
desugar (SDiv []) = error "div: requiere al menos un argumento"
desugar (SDiv [e]) = desugar e
desugar (SDiv [e1, e2]) = Div (desugar e1) (desugar e2)
desugar (SDiv (e1:e2:rest)) = desugar (SDiv (SDiv [e1, e2] : rest))

--Operadores unarios y binarios especiales---------------------------

{- Incrementos y decrementos unarios, raíz cuadrada y potencia binaria-}
desugar (SAdd1 e) = Add1 (desugar e)
desugar (SSub1 e) = Sub1 (desugar e)
desugar (SSqrt e) = Sqrt (desugar e)
desugar (SExpt b e) = Expt (desugar b) (desugar e)

--Comparadores variádicos-------------------------------------------------

{-Los comparadores variádicos se desazucarizan a cadenas de comparaciones
binarias combinadas con AND.-}

{-Igualdad variádica: (= 1 2 3) significa "todos los argumentos son iguales"
Se implementa como AND de comparaciones: (and (= 1 2) (and (= 2 3) #t))-}
desugar (SEq []) = error "eq: requiere al menos dos argumentos"
desugar (SEq [_]) = error "eq: requiere al menos dos argumentos"
desugar (SEq [e1, e2]) = Eq (desugar e1) (desugar e2)
desugar (SEq (e1:e2:rest)) = 
  desugarAnd (Eq (desugar e1) (desugar e2)) (desugar (SEq (e2:rest)))

{-Menor que variádico: (< 1 2 3) significa "todos los pares consecutivos cumplen e_i < e_{i+1}"
Se implementa como AND de comparaciones: (and (< 1 2) (and (< 2 3) #t))-}
desugar (SLt []) = error "lt: requiere al menos dos argumentos"
desugar (SLt [_]) = error "lt: requiere al menos dos argumentos"
desugar (SLt [e1, e2]) = Lt (desugar e1) (desugar e2)
desugar (SLt (e1:e2:rest)) = 
  desugarAnd (Lt (desugar e1) (desugar e2)) (desugar (SLt (e2:rest)))

{-Mayor que variádico: (> 5 3 1) significa "todos los pares consecutivos cumplen e_i > e_{i+1}"
Se implementa como AND de comparaciones: (and (> 5 3) (and (> 3 1) #t))-}
desugar (SGt []) = error "gt: requiere al menos dos argumentos"
desugar (SGt [_]) = error "gt: requiere al menos dos argumentos"
desugar (SGt [e1, e2]) = Gt (desugar e1) (desugar e2)
desugar (SGt (e1:e2:rest)) = 
  desugarAnd (Gt (desugar e1) (desugar e2)) (desugar (SGt (e2:rest)))

{-Menor o igual variádico: (<= 1 2 3) significa "todos los pares consecutivos cumplen e_i <= e_{i+1}"
Se implementa como AND de comparaciones:(and (<= 1 2) (and (<= 2 3) #t))-}
desugar (SLte []) = error "lte: requiere al menos dos argumentos"
desugar (SLte [_]) = error "lte: requiere al menos dos argumentos"
desugar (SLte [e1, e2]) = Lte (desugar e1) (desugar e2)
desugar (SLte (e1:e2:rest)) = 
  desugarAnd (Lte (desugar e1) (desugar e2)) (desugar (SLte (e2:rest)))

{-Mayor o igual variádico: (>= 5 3 1) significa "todos los pares consecutivos cumplen e_i >= e_{i+1}"
Se implementa como AND de comparaciones:(and (>= 5 3) (and (>= 3 1) #t))-}
desugar (SGte []) = error "gte: requiere al menos dos argumentos"
desugar (SGte [_]) = error "gte: requiere al menos dos argumentos"
desugar (SGte [e1, e2]) = Gte (desugar e1) (desugar e2)
desugar (SGte (e1:e2:rest)) = 
  desugarAnd (Gte (desugar e1) (desugar e2)) (desugar (SGte (e2:rest)))

{-Desigualdad variádica: (!= a b c) significa "existe al menos un par diferente"
Se implementa como OR de comparaciones: (!= a b) OR (!= b c)-}
desugar (SNeq []) = error "neq: requiere al menos dos argumentos"
desugar (SNeq [_]) = error "neq: requiere al menos dos argumentos"
desugar (SNeq [e1, e2]) = Neq (desugar e1) (desugar e2)
desugar (SNeq (e1:e2:rest)) = 
  Or (Neq (desugar e1) (desugar e2)) (desugar (SNeq (e2:rest)))


--Operadores lógicos variádicos--------------------------------------------

{-Los operadores lógicos variádicos se transforman a operaciones binarias 
anidadas que asocian a la izquierda-}

{-Conjunción variádica: (and e1 e2 e3) significa "todos los argumentos son verdaderos"-}
desugar (SAnd []) = error "and: requiere al menos un argumento"
desugar (SAnd [e]) = desugar e
desugar (SAnd [e1, e2]) = And (desugar e1) (desugar e2)
desugar (SAnd (e1:e2:rest)) = desugar (SAnd (SAnd [e1, e2] : rest))

{-Disyunción variádica: (or e1 e2 e3) significa "al menos un argumento es verdadero"-}
desugar (SOr []) = error "or: requiere al menos un argumento"
desugar (SOr [e]) = desugar e
desugar (SOr [e1, e2]) = Or (desugar e1) (desugar e2)
desugar (SOr (e1:e2:rest)) = desugar (SOr (SOr [e1, e2] : rest))

{-Negación unaria-}
desugar (SNot e) = Not (desugar e)

--pares y listas--------------------------------------------

{-Los pares se desazucarizan directamente a los constructores del núcleo.-}
desugar (SPair f s) = Pair (desugar f) (desugar s)
desugar (SFst p) = Fst (desugar p)
desugar (SSnd p) = Snd (desugar p)

{-Las listas se desazucarizan a pares anidados terminando en Nil.-}
desugar (SList []) = Nil
desugar (SList (x:xs)) = Pair (desugar x) (desugar (SList xs))

--Condicionales--------------------------------------------

{-Los condicionales se desazucarizan a la forma If del núcleo.-}
desugar (SIf c t e) = If (desugar c) (desugar t) (desugar e)
desugar (SIf0 c t e) = If (Eq (desugar c) (Num 0)) (desugar t) (desugar e)
desugar (SCond clauses) = desugarCond clauses
  where
    desugarCond [] = error "cond: falta cláusula else"
    desugarCond [(SBoolean True, e)] = desugar e
    desugarCond ((c, e):rest) = If (desugar c) (desugar e) (desugarCond rest)

--Let y Let*--------------------------------------------

{-Los bindings de Let y Let* se desazucarizan a aplicaciones de funciones.-}

-- Let (secuencial)
desugar (SLet [] body) = desugar body
desugar (SLet [(i, v)] body) = App (Fun i (desugar body)) (desugar v)
desugar (SLet ((i, v):rest) body) = 
  App (Fun i (desugar (SLet rest body))) (desugar v)

-- Let* (paralelo)
desugar (SLetStar [] body) = desugar body
desugar (SLetStar [(i, v)] body) = App (Fun i (desugar body)) (desugar v)
desugar (SLetStar ((i, v):rest) body) = 
  App (Fun i (desugar (SLetStar rest body))) (desugar v)


--letrec--------------------------------------------

{-Los bindings de Letrec se desazucarizan usando el combinador Z para
permitir definiciones recursivas.-}

desugar (SLetrec f def body) =
  App (Fun f (desugar body))
      (App (Id "Z") (Fun f (desugar def)))



--Funciones y aplicaciones--------------------------------------------

{-Las funciones con múltiples parámetros se desazucarizan a funciones
anidadas de un solo parámetro (currificación).-}
desugar (SLambda [] _) = error "lambda: requiere al menos un parámetro"
desugar (SLambda [p] body) = Fun p (desugar body)
desugar (SLambda (p:ps) body) = Fun p (desugar (SLambda ps body))

{-Casos especiales para operaciones sobre listas
Estos deben ir ANTES de los casos generales de SApp-}

-- null? como función (verifica si es lista vacía)
desugar (SApp (SId "null?") [arg]) = Eq (desugar arg) Nil

-- head como función (primer elemento)
desugar (SApp (SId "head") [arg]) = Fst (desugar arg)

-- tail como función (resto de la lista)
desugar (SApp (SId "tail") [arg]) = Snd (desugar arg)

-- list como constructor de listas
desugar (SApp (SId "list") args) = desugar (SList args)

{-Las aplicaciones con múltiples argumentos se desazucarizan a aplicaciones
anidadas de un solo argumento.-}
desugar (SApp f []) = desugar f
desugar (SApp f [a]) = App (desugar f) (desugar a)
desugar (SApp f (a:as)) = desugar (SApp (SApp f [a]) as)



--Desugar a ASAValues--------------------------------------------

desugarV :: ASA -> ASAValues

---Literales e identificadores-------------------------------------
desugarV (Id i) = IdV i
desugarV (Num n) = NumV n
desugarV (Boolean b) = BooleanV b

--Operadores aritméticos---------------------------------------------
desugarV (Add i d) = AddV (desugarV i) (desugarV d)
desugarV (Sub i d) = SubV (desugarV i) (desugarV d)
desugarV (Mul i d) = MulV (desugarV i) (desugarV d)
desugarV (Div i d) = DivV (desugarV i) (desugarV d)
desugarV (Add1 e) = Add1V (desugarV e)
desugarV (Sub1 e) = Sub1V (desugarV e)
desugarV (Sqrt e) = SqrtV (desugarV e)
desugarV (Expt b e) = ExptV (desugarV b) (desugarV e)

--Predicadores binarios---------------------------------------------
desugarV (Eq i d) = EqV (desugarV i) (desugarV d)
desugarV (Lt i d) = LtV (desugarV i) (desugarV d)
desugarV (Gt i d) = GtV (desugarV i) (desugarV d)
desugarV (Lte i d) = LteV (desugarV i) (desugarV d)
desugarV (Gte i d) = GteV (desugarV i) (desugarV d)
desugarV (Neq i d) = NeqV (desugarV i) (desugarV d)

--Operadores lógicos---------------------------------------------
desugarV (And i d) = AndV (desugarV i) (desugarV d)
desugarV (Or i d) = OrV (desugarV i) (desugarV d)
desugarV (Not e) = NotV (desugarV e)

--Pares y listas---------------------------------------------
{-Desazucariza pares y listas a sus representaciones en valores-}
desugarV (Pair i d) = PairV (desugarV i) (desugarV d)
desugarV (Fst p) = FstV (desugarV p)
desugarV (Snd p) = SndV (desugarV p)
desugarV Nil = NilV

--Condicionales---------------------------------------------
desugarV (If c t e) = IfV (desugarV c) (desugarV t) (desugarV e)

--Funciones y aplicaciones---------------------------------------------
desugarV (Fun p c) = FunV p (desugarV c)
desugarV (App f a) = AppV (desugarV f) (desugarV a)


--Función auxiliar---------------------------------------------

{-Función auxiliar para desazucarizar conjunciones variádicas.-}
desugarAnd :: ASA -> ASA -> ASA
desugarAnd e1 e2 = If e1 e2 (Boolean False)
