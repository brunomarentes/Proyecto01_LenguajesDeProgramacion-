{- |
Módulo      : Interp
Descripción : Intérprete de ejecución para MiniLisp

Este módulo implementa el intérprete del núcleo del lenguaje.
Se encarga de desarrollar el Árbol de Sintaxis Abstracta (ASA) producido
por desugar, transformándolo en valores.

ASA --(interp)--> Value

Autores:  -Lorena González Téllez
          -Leslie Renée López Rodríguez
          -Bruno Sebastián Marentes Mosqueda
-}

module Interp where

import Desugar
import Grammars


--Tipos de datos--------------------------------------------------------- 

{- |
Ambiente de evaluación: lista de pares (nombre_variable, valor).
-}
type Env = [(String, Value)]

data Value
  = NumV Int                       -- • Número entero
  | BooleanV Bool                  -- • Booleano (#t = True, #f = False)
  | PairV Value Value              -- • Par de valores (estructura de dato)
  | NilV                           -- • Lista vacía (empty)
  | ClosureV String ASA Env        -- • Cerradura: (parámetro, cuerpo, ambiente capturado)

{- |
Instancia Show para representar valores como strings.

Produce una representación legible de cada valor
para mostrar en el REPL.
-}
instance Show Value where
  show (NumV n) = show n
  show (BooleanV True) = "#t"
  show (BooleanV False) = "#f"
  show (PairV v1 v2) = "(pair " ++ show v1 ++ " " ++ show v2 ++ ")"
  show NilV = "empty"
  show (ClosureV _ _ _) = "#<procedure>"

{- |
Instancia Eq para comparación de valores.

Define igualdad estructural: dos valores son iguales si
tienen la misma estructura y contenido.
-}
instance Eq Value where
  NumV x == NumV y = x == y
  BooleanV x == BooleanV y = x == y
  NilV == NilV = True
  PairV a b == PairV c d = a == c && b == d
  _ == _ = False

--Interp-------------------------------------------------------------

{- |
Función principal de evaluación: transforma un ASA en un Value
dentro de un ambiente dado.

Tipo: ASA => Env => Value
-}
interp :: ASA -> Env -> Value

--Variables y literales--------------------------------------------

{- |
Variables: buscar su valor en el ambiente.
Si la variable no existe, lanza error "Variable libre: <var>"
-}
interp (Id i) env = lookupEnv i env

{- |
Literales numéricos: Regresar directamente como NumV
-}
interp (Num n) env = NumV n

{- |
Literales booleanos: Regresar directamente como BooleanV
-}
interp (Boolean b) env = BooleanV b

{- |
Nil (lista vacía): Regresar NilV
-}
interp Nil env = NilV

--Operadores aritméticos--------------------------------------------

{- |
Suma binaria: Add e1 e2 (e1 + e2)
  1. Evalúa e1 y e2 en el ambiente actual
  2. Extrae los números y los suma
  3. Regresa NumV con el resultado
-}
interp (Add e1 e2) env = 
  let v1 = interp e1 env
      v2 = interp e2 env
  in NumV (numV v1 + numV v2)

{- |
Resta binaria: Sub e1 e2 (e1 - e2)
  1. Evalúa e1 y e2 en el ambiente actual
  2. Extrae los números y los resta
  3. Regresa NumV con el resultado
-}
interp (Sub e1 e2) env = 
  let v1 = interp e1 env
      v2 = interp e2 env
  in NumV (numV v1 - numV v2)

{- |
Multiplicación binaria: Mul e1 e2 (e1 * e2)
  1. Evalúa e1 y e2 en el ambiente actual
  2. Extrae los números y los multiplica
  3. Regresa NumV con el resultado
-}
interp (Mul e1 e2) env = 
  let v1 = interp e1 env
      v2 = interp e2 env
  in NumV (numV v1 * numV v2)

{- |
División binaria: Div e1 e2 (e1 / e2)
  1. Evalúa e1 y e2 en el ambiente actual
  2. Verifica que el divisor no sea 0
  3. Extrae los números y realiza división entera
  4. Regresa NumV o error "División por cero"
-}
interp (Div e1 e2) env = 
  let v1 = interp e1 env
      v2 = interp e2 env
      n2 = numV v2
  in if n2 == 0
     then error "División por cero"
     else NumV (numV v1 `div` n2)

{- |
Operador unario Add1: incrementa en 1 un número
  (Add1 e) desazucariza a (+ e 1)
-}
interp (Add1 e) env = 
  let v = interp e env
  in NumV (numV v + 1)

{- |
Operador unario Sub1: decrementa en 1 un número
  (Sub1 e) desazucariza a (- e 1)
-}
interp (Sub1 e) env = 
  let v = interp e env
  in NumV (numV v - 1)

{- |
Raíz cuadrada: Sqrt e (√e)
  1. Evalúa e en el ambiente actual
  2. Extrae el número y verifica que no sea negativo
  3. Calcula raíz cuadrada (resultado entero)
  4. Regresa NumV o error "Raíz cuadrada de número negativo"
-}
interp (Sqrt e) env = 
  let v = interp e env
      n = numV v
  in if n < 0
     then error "Raíz cuadrada de número negativo"
     else NumV (floor (sqrt (fromIntegral n)))

{- |
Potencia: Expt base exp (base ^ exp)
  1. Evalúa base y exp en el ambiente actual
  2. Extrae números
  3. Calcula potencia
  4. Regresa NumV
-}
interp (Expt base exp) env = 
  let vBase = interp base env
      vExp = interp exp env
  in NumV (numV vBase ^ numV vExp)

--Operadores de comparación--------------------------------------------

{- |
Igualdad: Eq e1 e2 (e1 == e2)
  Compara si dos valores son estructuralmente iguales.
  Regresa BooleanV (True si son iguales, False si son diferentes).
  -}
interp (Eq e1 e2) env = 
  let v1 = interp e1 env
      v2 = interp e2 env
  in BooleanV (v1 == v2)

{- |
Menor que: Lt e1 e2 (e1 < e2)
  Compara numéricamente dos números.
  Regresa BooleanV (True si e1 es menor que e2, False en caso contrario).
-}
interp (Lt e1 e2) env = 
  let v1 = interp e1 env
      v2 = interp e2 env
  in BooleanV (numV v1 < numV v2)

{- |
Mayor que: Gt e1 e2 (e1 > e2)
  Compara numéricamente dos números.
  Regresa BooleanV (True si e1 es mayor que e2, False en caso contrario).
-}
interp (Gt e1 e2) env = 
  let v1 = interp e1 env
      v2 = interp e2 env
  in BooleanV (numV v1 > numV v2)

{- |
Menor o igual: Lte e1 e2 (e1 <= e2)
  Compara numéricamente dos números.
  Regresa BooleanV (True si e1 es menor o igual que e2, False en caso contrario).
-}
interp (Lte e1 e2) env = 
  let v1 = interp e1 env
      v2 = interp e2 env
  in BooleanV (numV v1 <= numV v2)

{- |
Mayor o igual: Gte e1 e2 (e1 >= e2)
  Compara numéricamente dos números.
  Regresa BooleanV (True si e1 es mayor o igual que e2, False en caso contrario).
-}
interp (Gte e1 e2) env = 
  let v1 = interp e1 env
      v2 = interp e2 env
  in BooleanV (numV v1 >= numV v2)

{- |
Desigualdad: Neq e1 e2 (e1 != e2)
  Compara si dos valores son diferentes.
  Regresa BooleanV (True si diferentes, False si iguales).
  -}
interp (Neq e1 e2) env = 
  let v1 = interp e1 env
      v2 = interp e2 env
  in BooleanV (v1 /= v2)

--Operadores lógicos--------------------------------------------

{- |
Negación lógica: Not e
  Niega el valor booleano de e. #t a #f y viceversa.
  Regresa BooleanV con el valor negado.
-}
interp (Not e) env = 
  let v = interp e env
  in BooleanV (not (boolV v))

{- |
Conjunción lógica (AND): And e1 e2
  Resuelve si ambos argumentos son verdaderos.
  Regresa BooleanV (True solo si ambos son #t).
  -}
interp (And e1 e2) env = 
  let v1 = interp e1 env
      v2 = interp e2 env
  in BooleanV (boolV v1 && boolV v2)

{- |
Disyunción lógica (OR): Or e1 e2
  Resuelve si al menos uno de los argumentos es verdadero.
  Regresa BooleanV (True si al menos uno es #t).
-}
interp (Or e1 e2) env = 
  let v1 = interp e1 env
      v2 = interp e2 env
  in BooleanV (boolV v1 || boolV v2)

--Pares----------------------------------------------------------

{- |
Construcción de par: Pair e1 e2
  Crea un par con dos valores.
-}
interp (Pair e1 e2) env = 
  let v1 = interp e1 env
      v2 = interp e2 env
  in PairV v1 v2

{- |
  Head de un par: Fst 
  Extrae el primer elemento de un par.
  Error si el argumento no es un par.
  -}
interp (Fst e) env = 
  case interp e env of
    PairV v1 _ -> v1
    _ -> error "fst requiere un par"

{- |
  Tail de un par: Snd
  Extrae el segundo elemento de un par.
  Error si el argumento no es un par.
-}
interp (Snd e) env = 
  case interp e env of
    PairV _ v2 -> v2
    _ -> error "snd requiere un par"


--Condicionales--------------------------------------------------

{- |
Condicional: If cond thenE elseE
  1. Evalúa la condición
  2. Si es verdadera (#t), evalúa thenE
  3. Si es falsa (#f), evalúa elseE
-}
interp (If cond thenE elseE) env = 
  let condV = interp cond env
  in if boolV condV
     then interp thenE env
     else interp elseE env

--Funciones y aplicaciones--------------------------------------------

{- |
Definición de función: Fun param body
  Crea una cerradura (closure) que captura:
  1. El parámetro (nombre de variable)
  2. El cuerpo (expresión a ejecutar)
  3. El ambiente actual (captura de alcance estático)
  Regresa ClosureV con estos tres elementos.
-}
interp (Fun param body) env = 
  ClosureV param body env

{- |
Aplicación de función: App f a
  1. Evalúa f (debe ser una cerradura)
  2. Evalúa a (el argumento)
  3. Crea nuevo ambiente con (param, arg)
  4. Evalúa el cuerpo en el nuevo ambiente
-}
interp (App f a) env = 
  case interp f env of
    -- Aplicar cerradura: crea nuevo ambiente con (param, arg)
    -- y lo prepende al ambiente capturado (alcance estático)
    ClosureV param body closureEnv ->
      let argV = interp a env
          newEnv = (param, argV) : closureEnv
      in interp body newEnv
    
    _ -> error "Intento de aplicar algo que no es una función"

--Funciones auxiliares--------------------------------------------

{- |
Buscar una variable en el ambiente.
Si no se encuentra, lanza error "Variable libre: <var>"
Regresa el valor asociado a la variable.
-}
lookupEnv :: String -> Env -> Value
lookupEnv var [] = error $ "Variable libre: " ++ var
lookupEnv var ((name, val):rest)
  | var == name = val
  | otherwise = lookupEnv var rest

{- |
Extrae un entero de un valor.
Si el valor no es NumV, lanza error.
-}
numV :: Value -> Int
numV (NumV n) = n
numV v = error $ "Se esperaba un número, se obtuvo: " ++ show v

{- |
Extrae un booleano de un valor.
Si el valor no es BooleanV, lanza error.
-}
boolV :: Value -> Bool
boolV (BooleanV b) = b
boolV v = error $ "Se esperaba un booleano, se obtuvo: " ++ show v

{- |
Verifica si un valor es Nil (lista vacía).
-}
isNil :: Value -> Bool
isNil NilV = True
isNil _ = False

{- |
Verifica si un valor es un par.
-}
isPair :: Value -> Bool
isPair (PairV _ _) = True
isPair _ = False

--Combinador Z --------------------------------------------------------


{- |
Combinador Z: punto fijo para evaluación estricta.
Permite que las funciones recursivas se definan sin referencia explícita
a sí mismas. 

Definición formal:
  Z = λf. (λx. f (λy. (x x) y)) (λx. f (λy. (x x) y))

-}
zCombinator :: Value
zCombinator = 
  ClosureV "f" 
    (App 
      (Fun "x" (App (Id "f") (Fun "y" (App (App (Id "x") (Id "x")) (Id "y")))))
      (Fun "x" (App (Id "f") (Fun "y" (App (App (Id "x") (Id "x")) (Id "y"))))))
    []

{- |
Ambiente inicial con el combinador Z predefinido.

Se proporciona el combinador Z globalmente para que las funciones
recursivas (definidas con letrec) puedan acceder a él.
-}
initialEnv :: Env
initialEnv = [("Z", zCombinator)]

--Eval desde cero------------------------------------------------

{- |
Evalua una expresión desde cero.

Entrada: expresión SASA (sin procesar - azucarada)
Salida: valor evaluado (Value)
-}
eval :: SASA -> Value
eval sasa = interp (desugar sasa) initialEnv

