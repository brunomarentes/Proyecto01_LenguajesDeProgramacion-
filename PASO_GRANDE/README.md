# MiniLisp - Proyecto 01
Extensión del lenguaje de programación MINILISP

**Lenguajes de Programación 2026-1**  
**Facultad de Ciencias, UNAM**

## Descripción:

Nuestro proyecto de MiniLisp es un intérprete implementado en Haskell. Este proyecto construye la formalización teórica mediante sintaxis abstracta, la eliminación de azúcar sintáctica y la semántica operacional estructural, junto con la implementación en código.

## Integrantes:

- González Téllez Lorena - 321288952
- López Rodríguez Leslie Renée - 321171915
- Marentes Mosqueda Bruno Sebastian - 321260606

## Requisitos

### Software Necesario

Necesitamos tener instalado:

- **GHC**
- **Alex** 
- **Happy** 

### Instalación:

#### En Ubuntu/Debian:

###### sudo apt-get update
###### sudo apt-get install ghc alex happy

#### En Fedora:

###### sudo dnf install ghc alex happy

## Instalación:

1. **Primero vamos a clonar el repositorio con el comando:**

git clone https://github.com/brunomarentes/Proyecto01_LenguajesDeProgramacion-.git

Debemos estar situados en la carpeta en la que lo vamos a clonar.


2. **Después tenemos que generar el lexer y el parser con los comandos:**

#### alex Lex.x
#### happy Grammars.y


3. **Compilación**

Por último, ya que tenemos todos los módulos generados, entramos
al entorno de ghc con el comando:

##### ghci

una vez estando en el entorno cargamos nuestro proyecto y lo corremos con
los siguientes comandos:

##### :load MiniLisp.hs
##### run

### Menú Interactivo

Al ejecutar el programa, se presenta un menú con las siguientes opciones:

⸻⸻⸻⸻⸻⸻ MENÚ PRINCIPAL ⸻⸻⸻⸻⸻⸻

    1.- Iniciar REPL interactivo

    2.- Ejecutar tests de las 5 funciones requeridas

    3.- Ver ayuda

    4.- Ver ejemplos

    5.- Salir

### REPL Interactivo

Dentro del REPL puedes:
- Escribir expresiones de MiniLisp directamente
- Usar comandos especiales:
  - `:help` - Te muestra ayuda de sintaxis
  - `:ejemplos` - Ver ejemplos de uso
  - `:test` - Ejecutar tests
  - `:clear` - Limpiar pantalla
  - `(exit)`- Salir del intérprete

## Ejemplos de Uso:

### Aritmética

MiniLisp> (+ 1 2 3 4 5)
⇒ 15

MiniLisp> (* 2 3 4)
⇒ 24

MiniLisp> (expt 2 10)
⇒ 1024

text

### Lógica

MiniLisp> (and #t #t #f)
⇒ #f

MiniLisp> (or #f #f #t)
⇒ #t

MiniLisp> (not #t)
⇒ #f

### Funciones

MiniLisp> ((lambda (x y) (+ x y)) 5 7)
⇒ 12


### Factorial Recursivo

MiniLisp> (letrec (fact (lambda (n)(if (= n 0) 1 (* n (fact (- n 1))))))(fact 5))
⇒ 120

## Funciones de Prueba

El proyecto incluye 5 funciones de prueba:

1. **Suma de primeros N naturales**
2. **Factorial**
3. **Fibonacci**
4. **Map (aplicar función a lista)**
5. **Filter (filtrar elementos de lista)**

Estas pruebas se pueden ejecutar eligiendo el número 2.

