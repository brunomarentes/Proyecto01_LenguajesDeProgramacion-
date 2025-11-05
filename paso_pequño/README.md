# MiniLisp - Paso Pequeño

Este intérprete de MiniLisp implementa la evaluación de **Paso Pequeño**, en este caso tuvimos unos problemas con el rendimiento y no pudimos corregirlos. Creemos que el código es correcto funcionalmente, pero la evaluación small-step con el combinador Z se tarda demasiado en la recursión (más de 20 segundos y se llena la memoria para maps relativamente pequeños). A pesar de esto, pensamos que todos los tests dan resultados correctos.
