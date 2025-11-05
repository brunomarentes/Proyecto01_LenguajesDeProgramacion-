module REPL where


import System.IO
import Control.Exception (catch, SomeException)
import Desugar
import Grammars
import Interp
import Lex



------------------------------------------------------------combinador z

combinadorZ :: String
combinadorZ = "(lambda (f) ((lambda (x) (f (lambda (y) ((x x) y)))) (lambda (x) (f (lambda (y) ((x x) y))))))"

z :: Value
z = interp (desugar $ parse $ lexer combinadorZ) []

------------------------------------------------------------combinador z



saca :: Value -> String
saca (NumV n) = show n
saca (BooleanV b)
  | b == True = "#t"
  | otherwise = "#f"
saca NilV = "[]"
saca p@(PairV _ _) = sacaLista p
  where
    sacaLista l = "[" ++ sacaElementos l ++ "]"
      where
        sacaElementos NilV = ""
        sacaElementos (PairV v NilV) = saca v
        sacaElementos (PairV v rest@(PairV _ _)) = saca v ++ ", " ++ sacaElementos rest
        sacaElementos (PairV v rest) = saca v ++ " | " ++ saca rest
saca (ClosureV _ _ _) = "#<procedure>"

------------------------------------------------------------
-- BANNER Y MENSAJES
------------------------------------------------------------


banner :: String
banner = unlines
  [ colorAzul "  ================================================="
  , colorAzul "  ||" ++ colorBoldAmarillo "           Proyecto 01 - MiniLisp            " ++ colorAzul "||"
  , colorAzul "  ||" ++ colorAmarillo "     Lenguajes de Programación 2026-1        " ++ colorAzul "||"
  , colorAzul "  ||" ++ colorCyan "   Universidad Nacional Autónoma de México   " ++ colorAzul "||"
  , colorAzul "  ||" ++ colorCyan "            Facultad de Ciencias             " ++ colorAzul "||"
  , colorAzul "  ||" ++ "                                             " ++ colorAzul "||"
  , colorAzul "  ||" ++ colorAmarillo "        Desarrollado por:                    " ++ colorAzul "||"
  , colorAzul "  ||" ++ colorAmarillo "    =>  " ++ colorBlanco "Lorena González Téllez               " ++ colorAzul "||"
  , colorAzul "  ||" ++ colorAmarillo "    =>  " ++ colorBlanco "Leslie Renée López Rodríguez         " ++ colorAzul "||"
  , colorAzul "  ||" ++ colorAmarillo "    =>  " ++ colorBlanco "Bruno Sebastián Marentes Mosqueda    " ++ colorAzul "||"
  , colorAzul "  ================================================="
  , ""
  , colorAzul "  Escribe expresiones de MiniLisp o comandos:"
  , colorAmarillo "  (exit)    " ++ "- Salir del intérprete"
  , colorAmarillo "  :help     " ++ "- Mostrar ayuda"
  , colorAmarillo "  :ejemplos " ++ "- Mostrar ejemplos"
  , colorAmarillo "  :test     " ++ "- Ejecutar funciones de prueba"
  , colorAmarillo "  :clear    " ++ "- Limpiar pantalla"
  , ""
  ]



helpMessage :: String
helpMessage = unlines
  [ "" ++ colorCyan "===================== AYUDA (ദ്ദി˙ᗜ˙) ====================="
  , ""
  , "" ++ colorAmarillo "COMANDOS:"
  , "  (exit)              " ++ colorVerde "- Salir del intérprete"
  , "  :help               " ++ colorVerde "- Mostrar ayuda"
  , "  :ejemplos           " ++ colorVerde "- Mostrar ejemplos"
  , "  :test               " ++ colorVerde "- Ejecutar funciones de prueba"
  , "  :clear              " ++ colorVerde "- Limpiar pantalla"
  , ""
  , "" ++ colorAmarillo "OPERADORES ARITMÉTICOS:"
  , "  (+ e1 e2 ...)       " ++ colorVerde "- Suma variádica"
  , "  (- e1 e2 ...)       " ++ colorVerde "- Resta variádica"
  , "  (* e1 e2 ...)       " ++ colorVerde "- Multiplicación variádica"
  , "  (/ e1 e2 ...)       " ++ colorVerde "- División variádica"
  , "  (add1 e)            " ++ colorVerde "- Incremento"
  , "  (sub1 e)            " ++ colorVerde "- Decremento"
  , "  (sqrt e)            " ++ colorVerde "- Raíz cuadrada"
  , "  (expt base exp)     " ++ colorVerde "- Potencia"
  , ""
  , "" ++ colorAmarillo "COMPARADORES:"
  , "  (= e1 e2 ...)       " ++ colorVerde "- Igualdad"
  , "  (< e1 e2 ...)       " ++ colorVerde "- Menor que"
  , "  (> e1 e2 ...)       " ++ colorVerde "- Mayor que"
  , "  (<= e1 e2 ...)      " ++ colorVerde "- Menor o igual"
  , "  (>= e1 e2 ...)      " ++ colorVerde "- Mayor o igual"
  , "  (!= e1 e2 ...)      " ++ colorVerde "- Desigualdad"
  , ""
  , "" ++ colorAmarillo "LÓGICOS:"
  , "  (not e)             " ++ colorVerde "- Negación"
  , "  (and e1 e2 ...)     " ++ colorVerde "- Conjunción"
  , "  (or e1 e2 ...)      " ++ colorVerde "- Disyunción"
  , ""
  , "" ++ colorAmarillo "PARES Y LISTAS:"
  , "  (pair e1 e2)        " ++ colorVerde "- Crear par"
  , "  (fst e)             " ++ colorVerde "- Primer elemento del par"
  , "  (snd e)             " ++ colorVerde "- Segundo elemento del par"
  , "  [e1, e2, e3]        " ++ colorVerde "- Lista literal"
  , "  empty               " ++ colorVerde "- Lista vacía"
  , "  (head lst)          " ++ colorVerde "- Primer elemento de lista"
  , "  (tail lst)          " ++ colorVerde "- Resto de la lista"
  , "  (null? lst)         " ++ colorVerde "- Verificar si está vacía"
  , ""
  , "" ++ colorAmarillo "VARIABLES Y FUNCIONES:"
  , "  (let ((x e1) (y e2)) body)       " ++ colorVerde "- Asignación paralela"
  , "  (let* ((x e1) (y e2)) body)      " ++ colorVerde "- Asignación secuencial"
  , "  (letrec (f def) body)            " ++ colorVerde "- Definición recursiva"
  , "  (lambda (x y z) body)            " ++ colorVerde "- Función anónima"
  , "  (f arg1 arg2)                    " ++ colorVerde "- Aplicación de función"
  , ""
  , "" ++ colorAmarillo "CONDICIONALES:"
  , "  (if cond then else)              " ++ colorVerde "- Condicional simple"
  , "  (if0 e then else)                " ++ colorVerde "- Condicional por cero"
  , "  (cond [c1 e1] [c2 e2] [else e])  " ++ colorVerde "- Condicional múltiple"
  , ""
  ]


ejemplosMessage :: String
ejemplosMessage = unlines
  [ "" ++ colorCyan "================== EJEMPLOS ==================="
  , ""
  , "" ++ colorAmarillo "ARITMÉTICA:"
  , "  > (+ 1 2 3 4 5)"
  , "  " ++ colorVerde "15"
  , ""
  , "  > (* 2 3 4)"
  , "  " ++ colorVerde "24"
  , ""
  , "  > (expt 2 10)"
  , "  " ++ colorVerde "1024"
  , ""
  , "" ++ colorAmarillo "LÓGICA:"
  , "  > (and #t #t #f)"
  , "  " ++ colorVerde "#f"
  , ""
  , "  > (or #f #f #t)"
  , "  " ++ colorVerde "#t"
  , ""
  , "  > (not #t)"
  , "  " ++ colorVerde "#f"
  , ""
  , "" ++ colorAmarillo "LISTAS:"
  , "  > [1, 2, 3, 4, 5]"
  , "  " ++ colorVerde "[1, 2, 3, 4, 5]"
  , ""
  , "  > (head [10, 20, 30])"
  , "  " ++ colorVerde "10"
  , ""
  , "  > (tail [10, 20, 30])"
  , "  " ++ colorVerde "[20, 30]"
  , ""
  , "" ++ colorAmarillo "FUNCIONES:"
  , "  > ((lambda (x y) (+ x y)) 5 7)"
  , "  " ++ colorVerde "12"
  , ""
  , "" ++ colorAmarillo "FACTORIAL:"
  , "  > (letrec (fact (lambda (n)"
  , "       (if (= n 0) 1 (* n (fact (- n 1))))))"
  , "      (fact 5))"
  , "  " ++ colorVerde "120"
  , ""
  , "" ++ colorAmarillo "MAP:"
  , "  > (letrec (map (lambda (f lst)"
  , "       (if (null? lst) empty"
  , "         (pair (f (head lst)) (map f (tail lst))))))"
  , "      (map (lambda (x) (* x 2)) [1, 2, 3]))"
  , "  " ++ colorVerde "[2, 4, 6]"
  , ""
  ]


testFunctions :: [(String, String, String)]
testFunctions =
  [ ("" ++ colorCyan "Suma de primeros N naturales"
    , "(letrec (sum (lambda (n) (if (= n 0) 0 (+ n (sum (- n 1)))))) (sum 10))"
    , "55")
  
  , ("" ++ colorCyan "Factorial"
    , "(letrec (fact (lambda (n) (if (= n 0) 1 (* n (fact (- n 1)))))) (fact 5))"
    , "120")

  , ("" ++ colorCyan "Fibonacci"
    , "(letrec (fib (lambda (n) (if (< n 2) n (+ (fib (- n 1)) (fib (- n 2)))))) (fib 10))"
    , "55")

  , ("" ++ colorCyan "Map para listas"
    , "(letrec (map (lambda (f lst) (if (null? lst) empty (pair (f (head lst)) (map f (tail lst)))))) (map (lambda (x) (* x 2)) [1, 2, 3, 4, 5]))"
    , "[2, 4, 6, 8, 10]")

  , ("" ++ colorCyan "Filter para listas"
    , "(letrec (filter (lambda (pred lst) (if (null? lst) empty (if (pred (head lst)) (pair (head lst) (filter pred (tail lst))) (filter pred (tail lst)))))) (filter (lambda (x) (> x 3)) [1, 2, 3, 4, 5, 6]))"
    , "[4, 5, 6]")
  ]


------------------------------------------------------------
------------------------------------------------------------


evalSafe :: String -> IO (Either String Value)
evalSafe input = 
  catch (do
          let result = interp (desugar (parse (lexer input))) [("Z", z)]
          return (Right result))
        (\e -> return $ Left $ show (e :: SomeException))
        
        
------------------------------------------------------------
------------------------------------------------------------

runTests :: IO ()
runTests = do
  putStrLn $ colorCyan "  ================== EJECUTANDO TESTS ===================="
  putStrLn ""
  mapM_ runTest (zip [1..] testFunctions)
  putStrLn "⸻⸻⸻⸻⸻⸻⸻⸻⸻⸻⸻⸻⸻⸻⸻⸻⸻⸻⸻⸻⸻⸻"
  putStrLn ""
  where
    runTest (n, (name, expr, expected)) = do
      putStrLn $ colorAmarillo "Test " ++ colorAmarillo (show n) ++ colorAmarillo ": " ++ name
      putStrLn $ "  Expresión: " ++ take 100000 expr ++ "  " ++ colorAmarillo "   (⸝⸝⸝-﹏-⸝⸝⸝)"
      result <- evalSafe expr
      case result of
        Left err -> putStrLn $ "  ERROR: " ++ err
        Right val -> do
          let resultStr = saca val
          if resultStr == expected
            then putStrLn $ " " ++ colorVerde "CORRECTO (˶ᵔ ᵕ ᵔ˶): " ++ colorBoldVerde resultStr
            else putStrLn $ " " ++ colorRojo "INCORRECTO (╥﹏╥): " ++ "esperado " ++ expected ++ ", obtenido " ++ colorRojo resultStr
      putStrLn ""

------------------------------------------------------------
------------------------------------------------------------

handleCommand :: String -> IO Bool
handleCommand ":help" = do
  putStrLn helpMessage
  return True

handleCommand ":ejemplos" = do
  putStrLn ejemplosMessage
  return True

handleCommand ":test" = do
  runTests
  return True

handleCommand ":clear" = do
  putStr "\ESC[2J\ESC[H"  
  return True

handleCommand _ = return False

------------------------------------------------------------
------------------------------------------------------------
--colores

resetColor :: String
resetColor = "\ESC[0m"

colorBoldVerde :: String -> String
colorBoldVerde s = "\ESC[1;32m" ++ s ++ resetColor

colorBoldAzul :: String -> String
colorBoldAzul s = "\ESC[1;34m" ++ s ++ resetColor

colorBoldAmarillo :: String -> String
colorBoldAmarillo s = "\ESC[1;93m" ++ s ++ resetColor

--------------------------------------------------------------

colorCyan :: String -> String
colorCyan s = "\ESC[1;96m" ++ s ++ resetColor

colorAmarillo :: String -> String
colorAmarillo s = "\ESC[93m" ++ s ++ resetColor

colorAzul :: String -> String
colorAzul s = "\ESC[94m" ++ s ++ resetColor

colorVerde :: String -> String
colorVerde s = "\ESC[92m" ++ s ++ resetColor

colorBlanco :: String -> String
colorBlanco s = "\ESC[97m" ++ s ++ resetColor

colorRojo :: String -> String
colorRojo s = "\ESC[91m" ++ s ++ resetColor


------------------------------------------------------------
------------------------------------------------------------


repl :: IO ()
repl = do
  putStr "MiniLisp> "
  hFlush stdout
  str <- getLine
  
  let trimmed = trim str
  
  if trimmed == "(exit)" || trimmed == ":quit" || trimmed == ":q"
    then putStrLn "¡Hasta luego!"
  
  else if null trimmed
    then repl
  
  else do
    isCommand <- handleCommand trimmed
    if isCommand
      then repl
      else do

        result <- evalSafe trimmed 
        case result of
          Left err -> do
            putStrLn $ " Error: " ++ err
            repl
          Right val -> do
            putStrLn $ "⇒  " ++ colorVerde (saca val)
            repl

trim :: String -> String
trim = f . f
  where f = reverse . dropWhile (`elem` " \t\n\r")

------------------------------------------------------------
------------------------------------------------------------

showMenu :: IO ()
showMenu = do
  putStrLn $ colorCyan "================= MENÚ PRINCIPAL ================="
  putStrLn ""
  putStrLn "1. Iniciar REPL interactivo"
  putStrLn "2. Ejecutar tests de las 5 funciones de prueba"
  putStrLn "3. Ver ayuda"
  putStrLn "4. Ver ejemplos"
  putStrLn "5. Salir"
  putStrLn ""
  putStr "Selecciona una opción (1-5): "
  hFlush stdout

mainMenu :: IO ()
mainMenu = do
  showMenu
  option <- getLine
  putStrLn ""
  
  case option of
    "1" -> do
      putStrLn "Iniciando REPL..."
      putStrLn ""
      repl
      mainMenu
    
    "2" -> do
      runTests
      putStrLn "Presiona Enter para continuar..."
      _ <- getLine
      mainMenu
    
    "3" -> do
      putStrLn helpMessage
      putStrLn "Presiona Enter para continuar..."
      _ <- getLine
      mainMenu
    
    "4" -> do
      putStrLn ejemplosMessage
      putStrLn "Presiona Enter para continuar..."
      _ <- getLine
      mainMenu
    
    "5" -> do
      putStrLn "¡Hasta luego!"

    "17" -> do
      putStrLn ""
      putStrLn $ colorAmarillo "     ⠀⠀⠀⠀⠀⠀⠀⢀⣀⣀⣄⣀⡀⠀⠀⠀⠀⠀⠀⠀"
      putStrLn $ colorAmarillo "     ⠀⠀⠀⠀⢀⣴⠾⠛⠉⠉⠉⠉⠛⠿⣦⡀⠀⠀⠀⠀"
      putStrLn $ colorAmarillo "     ⠀⠀⠀⢠⡿⠁⠀⢀⣠⣤⣤⣄⡀⠀⠈⢿⡆⠀⠀⠀"
      putStrLn $ colorAmarillo "     ⠀⠀⢀⣿⣁⣀⣠⡿⠋⠀⠀⠙⢿⣄⣀⣈⣿⡀⠀⠀"
      putStrLn $ colorAmarillo "     ⠀⠀⢸⣿⠛⠛⢻⣧⠀⠿⠇⠀⣼⡟⠛⠛⣿⡇⠀⠀"
      putStrLn $ colorAmarillo "     ⠀⠀⢸⣿⠀⠀⠀⠙⢷⣦⣴⡾⠋⠀⠀⠀⣿⡇⠀⠀"
      putStrLn $ colorAmarillo "     ⠀⠀⢸⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⡇⠀⠀"
      putStrLn $ colorAmarillo "     ⠀⠀⣸⣿⠀⠀⠀⠛⠷⠶⠶⠾⠛⠀⠀⠀⣿⣇⠀⠀       xd"
      putStrLn $ colorAmarillo "     ⠀⣸⣿⣿⢷⣦⣀⣀⣀⣀⣀⣀⣀⣀⣴⡾⣿⣿⣇⠀"
      putStrLn $ colorAmarillo "     ⢠⣿⢸⣿⠀⣿⡏⠉⠉⠉⠉⠉⠉⢹⣿⠀⣿⡇⣿⡄"
      putStrLn $ colorAmarillo "     ⢸⡏⢸⣿⣀⣿⡇⠀⠀⠀⠀⠀⠀⢸⣿⣀⣿⡇⢹⡇"
      putStrLn $ colorAmarillo "     ⢸⡇⠀⢿⣏⠉⠁⠀⠀⠀⠀⠀⠀⠈⠉⣹⡿⠀⢸⡇"
      putStrLn $ colorAmarillo "     ⢸⣿⣤⣌⠛⠷⣶⣶⣶⣶⣶⣶⣶⣶⠾⠛⣡⣤⣿⡇"
      putStrLn $ colorAmarillo "     ⠘⠿⠿⠇⠀⠀⠀⢿⡾⠇⠸⢷⡿⠀⠀⠀⠸⠿⠿⠃"
      putStrLn $ colorAmarillo "     ⠀⠀⠀⠀⠀⠀⠀⠛⠛⠁⠈⠛⠛⠀⠀⠀⠀⠀⠀⠀"
      putStrLn ""
      mainMenu
    
    _ -> do
      putStrLn "Opción inválida. Ingresa un número del 1 al 5."
      putStrLn ""
      mainMenu
------------------------------------------------------------
------------------------------------------------------------

run :: IO ()
run = do
  hSetBuffering stdout NoBuffering
  hSetBuffering stdin LineBuffering
  putStrLn banner
  mainMenu

main :: IO ()
main = run
