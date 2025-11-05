# MiniLisp - Paso Pequeño

Este intérprete MiniLisp implementa evaluación de **Paso Pequeño**, en este caso tuvimos problemas con el rendimiento y no pudimos corregirlos. El código es correcto funcionalmente, pero la evaluación small-step con el combinador Z se tarda demasiado en recursión profunda (más de 20 segundos para mapas pequeños). A pesar de esto, todos los tests dan resultados correctos.
