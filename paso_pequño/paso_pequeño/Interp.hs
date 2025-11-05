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
    ( ASA(Id, Fun, App), desugar, ASAValues(..), desugarV )
import Grammars

type Env = [(String, ASAValues)]

--ambiente inicial con el combinador Z -----------------------
initialEnv :: Env
initialEnv = [("Z", zCombinator)]

zCombinator :: ASAValues
zCombinator =
  let bodyASA =
        App
          (Fun "x" (App (Id "f")
                        (Fun "y" (App (App (Id "x") (Id "x")) (Id "y")))))
          (Fun "x" (App (Id "f")
                        (Fun "y" (App (App (Id "x") (Id "x")) (Id "y")))))
      bodyV = desugarV bodyASA
  in ClosureV "f" bodyV []



--funcion de paso pequeño---------------------------------------
smallStep :: ASAValues -> Env -> (ASAValues, Env)

--reglas para valores---------------------------
smallStep (NumV n) env = (NumV n, env)
smallStep (BooleanV b) env = (BooleanV b, env)
smallStep (NilV) env = (NilV, env)
smallStep (ClosureV p c e) env = (ClosureV p c e, env)
smallStep (PairV v1 v2) env = (PairV v1 v2, env)

--lookup de identificadores---------------------------------------
smallStep (IdV i) env = (lookupEnv i env, env)

--suma-------------------------------------------------------

--Add: Ambos lados son valores
smallStep (AddV (NumV n) (NumV m)) env = (NumV (n + m), env)

--AddD: Evaluar lado derecho
smallStep (AddV (NumV n) d) env =
  let (d', env') = smallStep d env
  in (AddV (NumV n) d', env')

--AddL: Evaluar lado izquierdo
smallStep (AddV d1 d2) env =
  let (d1', env') = smallStep d1 env
  in (AddV d1' d2, env')

--resta-------------------------------------------------------

--Sub: Ambos lados son valores
smallStep (SubV (NumV n) (NumV m)) env = (NumV (n - m), env)

--SubD: Evaluar lado derecho
smallStep (SubV (NumV n) d) env =
  let (d', env') = smallStep d env
  in (SubV (NumV n) d', env')

--SubL: Evaluar lado izquierdo
smallStep (SubV d1 d2) env =
  let (d1', env') = smallStep d1 env
  in (SubV d1' d2, env')

--multiplicación-------------------------------------------------------

--Mul: Ambos lados son valores
smallStep (MulV (NumV n) (NumV m)) env = (NumV (n * m), env)

--MulD: Evaluar lado derecho
smallStep (MulV (NumV n) d) env =
  let (d', env') = smallStep d env
  in (MulV (NumV n) d', env')

--MulL: Evaluar lado izquierdo
smallStep (MulV d1 d2) env =
  let (d1', env') = smallStep d1 env
  in (MulV d1' d2, env')

--división-------------------------------------------------------

--Div: Ambos lados son valores
smallStep (DivV (NumV n) (NumV m)) env
  | m == 0 = error "División por cero"
  | otherwise = (NumV (n `div` m), env)

--DivD: Evaluar lado derecho
smallStep (DivV (NumV n) d) env =
  let (d', env') = smallStep d env
  in (DivV (NumV n) d', env')

--DivL: Evaluar lado izquierdo
smallStep (DivV d1 d2) env =
  let (d1', env') = smallStep d1 env
  in (DivV d1' d2, env')

--operaciones unarias--------------------------------------------

--add1
smallStep (Add1V (NumV n)) env = (NumV (n + 1), env)
smallStep (Add1V d) env =
  let (d', env') = smallStep d env
  in (Add1V d', env')

--sub1
smallStep (Sub1V (NumV n)) env = (NumV (n - 1), env)
smallStep (Sub1V d) env =
  let (d', env') = smallStep d env
  in (Sub1V d', env')

--sqrt
smallStep (SqrtV (NumV n)) env
  | n < 0 = error "Raíz cuadrada de número negativo"
  | otherwise = (NumV (floor (sqrt (fromIntegral n))), env)
smallStep (SqrtV d) env =
  let (d', env') = smallStep d env
  in (SqrtV d', env')

--expt
smallStep (ExptV (NumV b) (NumV e)) env = (NumV (b ^ e), env)
smallStep (ExptV (NumV b) d) env =
  let (d', env') = smallStep d env
  in (ExptV (NumV b) d', env')
smallStep (ExptV d1 d2) env =
  let (d1', env') = smallStep d1 env
  in (ExptV d1' d2, env')

--predicadores binarios--------------------------------------------

--igualdad (optimizada para null?)
-- Casos especiales para Nil (acelera null?)
smallStep (EqV NilV NilV) env = (BooleanV True, env)
smallStep (EqV NilV v) env
  | isValueV v = (BooleanV False, env)
  | otherwise =
      let (v', env') = smallStep v env
      in (EqV NilV v', env')
smallStep (EqV v NilV) env
  | isValueV v = (BooleanV False, env)
  | otherwise =
      let (v', env') = smallStep v env
      in (EqV v' NilV, env')

-- Casos normales
smallStep (EqV d1 d2) env
  | isValueV d1 && isValueV d2 = (BooleanV (d1 == d2), env)
  | isValueV d1 =
      let (d2', env') = smallStep d2 env
      in (EqV d1 d2', env')
  | otherwise =
      let (d1', env') = smallStep d1 env
      in (EqV d1' d2, env')


--menor que
smallStep (LtV (NumV n) (NumV m)) env = (BooleanV (n < m), env)
smallStep (LtV (NumV n) d) env =
  let (d', env') = smallStep d env
  in (LtV (NumV n) d', env')
smallStep (LtV d1 d2) env =
  let (d1', env') = smallStep d1 env
  in (LtV d1' d2, env')

--mayor que
smallStep (GtV (NumV n) (NumV m)) env = (BooleanV (n > m), env)
smallStep (GtV (NumV n) d) env =
  let (d', env') = smallStep d env
  in (GtV (NumV n) d', env')
smallStep (GtV d1 d2) env =
  let (d1', env') = smallStep d1 env
  in (GtV d1' d2, env')

--menor o igual que
smallStep (LteV (NumV n) (NumV m)) env = (BooleanV (n <= m), env)
smallStep (LteV (NumV n) d) env =
  let (d', env') = smallStep d env
  in (LteV (NumV n) d', env')
smallStep (LteV d1 d2) env =
  let (d1', env') = smallStep d1 env
  in (LteV d1' d2, env')

--mayor o igual que
smallStep (GteV (NumV n) (NumV m)) env = (BooleanV (n >= m), env)
smallStep (GteV (NumV n) d) env =
  let (d', env') = smallStep d env
  in (GteV (NumV n) d', env')
smallStep (GteV d1 d2) env =
  let (d1', env') = smallStep d1 env
  in (GteV d1' d2, env')

--diferente
smallStep (NeqV d1 d2) env
  | isValueV d1 && isValueV d2 = (BooleanV (d1 /= d2), env)
  | isValueV d1 =
      let (d2', env') = smallStep d2 env
      in (NeqV d1 d2', env')
  | otherwise =
      let (d1', env') = smallStep d1 env
      in (NeqV d1' d2, env')

--operadores lógicos--------------------------------------------

--conjunción
smallStep (AndV (BooleanV b1) (BooleanV b2)) env = 
  (BooleanV (b1 && b2), env)
smallStep (AndV (BooleanV b) d) env =
  let (d', env') = smallStep d env
  in (AndV (BooleanV b) d', env')
smallStep (AndV d1 d2) env =
  let (d1', env') = smallStep d1 env
  in (AndV d1' d2, env')

--disyunción
smallStep (OrV (BooleanV b1) (BooleanV b2)) env = 
  (BooleanV (b1 || b2), env)
smallStep (OrV (BooleanV b) d) env =
  let (d', env') = smallStep d env
  in (OrV (BooleanV b) d', env')
smallStep (OrV d1 d2) env =
  let (d1', env') = smallStep d1 env
  in (OrV d1' d2, env')

--negación
smallStep (NotV (BooleanV b)) env = (BooleanV (not b), env)
smallStep (NotV d) env =
  let (d', env') = smallStep d env
  in (NotV d', env')

--pares y listas--------------------------------------------

--fst (primer elemento)
smallStep (FstV (PairV v1 v2)) env = (v1, env)
smallStep (FstV NilV) env = error "fst: no se puede aplicar a lista vacía"
smallStep (FstV p) env
  | isValueV p = error "fst: se esperaba un par"
  | otherwise =
      let (p', env') = smallStep p env
      in (FstV p', env')

--snd (resto/segundo elemento)
smallStep (SndV (PairV v1 v2)) env = (v2, env)
smallStep (SndV NilV) env = error "snd: no se puede aplicar a lista vacía"
smallStep (SndV p) env
  | isValueV p = error "snd: se esperaba un par"
  | otherwise =
      let (p', env') = smallStep p env
      in (SndV p', env')


--condicionales--------------------------------------------

--if-true / if-false
smallStep (IfV (BooleanV True) t e) env = (t, env)
smallStep (IfV (BooleanV False) t e) env = (e, env)
smallStep (IfV c t e) env =
  let (c', env') = smallStep c env
  in (IfV c' t e, env')

--funciones y aplicaciones--------------------------------------------

--funcion
smallStep (FunV p c) env = (ClosureV p c env, env)

--aplicación
smallStep (AppV cv@(ClosureV p b env') a) env
  | isValueV a = (ExprV b ((p, a) : env'), env)
  | otherwise  = let (a', env1) = smallStep a env
                 in (AppV cv a', env1)

--evaluar el cuerpo de la función
smallStep (ExprV v envIn) env
  | isValueV v = (v, env)
  | otherwise  = let (v', envIn') = smallStep v envIn
                 in (ExprV v' envIn', env)

--evaluar función en aplicación
smallStep (AppV f a) env =
  let (f', env') = smallStep f env
  in (AppV f' a, env')


--interp: evaluación completa---------------------------------------

{- |
interp :: ASAValues -> Env -> ASAValues

Aplica smallStep iterativamente hasta alcanzar un valor.
-}
interp :: ASAValues -> Env -> ASAValues
interp e env
  | isValueV e = e
  | otherwise =
      let (e', env') = smallStep e env
      in interp e' env'

{- |
isValueV verifica si una ASAValues es irreducible.
Valores: NumV, BooleanV, NilV, ClosureV, PairV
-}
isValueV :: ASAValues -> Bool
isValueV (NumV _) = True
isValueV (BooleanV _) = True
isValueV NilV = True
isValueV (ClosureV _ _ _) = True
isValueV (PairV v1 v2) = isValueV v1 && isValueV v2
isValueV _ = False

{- |
lookupEnv busca un identificador en el ambiente.
-}
lookupEnv :: String -> Env -> ASAValues
lookupEnv i [] = error $ "Variable libre: " ++ i
lookupEnv i ((j, v) : env)
  | i == j = v
  | otherwise = lookupEnv i env

{- |
Extractores de números y booleanos.
-}
numN :: ASAValues -> Int
numN (NumV n) = n
numN _ = error "Se esperaba NumV"

{- |
boolN extrae el valor booleano de una ASAValues.
-}
boolN :: ASAValues -> Bool
boolN (BooleanV b) = b
boolN _ = error "Se esperaba BooleanV"

{- |
extrae el parámetro de una ClosureV.
-}
closureP :: ASAValues -> String
closureP (ClosureV p _ _) = p
closureP _ = error "Se esperaba ClosureV"

{- |
extrae el cuerpo de una ClosureV.
-}
closureC :: ASAValues -> ASAValues
closureC (ClosureV _ c _) = c
closureC _ = error "Se esperaba ClosureV"

{- |
extrae el ambiente de una ClosureV.
-}
closureE :: ASAValues -> Env
closureE (ClosureV _ _ e) = e
closureE _ = error "Se esperaba ClosureV"

--eval: función principal de evaluación---------------------------------------
eval :: SASA -> ASAValues
eval sasa = 
  let asa = desugar sasa
      asaVal = desugarV asa
      result = interp asaVal initialEnv
  in result
