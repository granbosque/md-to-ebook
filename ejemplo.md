---
title: Ejemplo de libro
author: Nombre Apellido
lang: es-ES
cover-image: portada.jpg
date: "Revisión 2025"
rights: "© Autor. Todos los derechos reservados."
---

# 1

Este archivo muestra, con ejemplos sencillos, cómo usar markdown para libros de ficción.

Párrafo normal. El estilo ya añade sangría de primera línea automáticamente a partir del segundo párrafo.

Segundo párrafo del mismo bloque, ahora verás la sangría de primera línea aplicada por CSS.

Texto en cursiva con *asteriscos* y en **negrita** con dobles asteriscos.

---¿Cómo puedo insertar diálogos? ---pregunta un personaje. ---Nunca recuerdo cómo escribir correctamente la raya.

---Es fácil, si escribes tres guiones, se susituirá por una raya de diálogo.


***

Los tres asteriscos encima forman un separador de escena.

> Cita. Se marca con un ángulo delante. Este texto aparecerá con un formato especial.

Lista sin orden:

- Elemento uno
- Elemento dos

Lista numerada:

1. Paso uno
2. Paso dos

## Imágenes

![Texto alternativo](imagen.jpg "Título de la imagen")

## Notas

Hay varias formas de incluir notas al pie.

Nota al pie de página con referencia[^nota1]. También puedes añadir otra nota en la misma línea[^nota2].


[^nota1]: Texto de la nota que aparecerá al pie de la página (en PDF) o al final de capítulo (según lector).
[^nota2]: Otra nota al pie.

## Subtítulo dentro del capítulo

Puedes usar subtítulos con `##` para secciones internas.

***

Aunque incluyas

muchas



muchas


líneas en blanco ente párrafos, esos espacios no se verán luego en el epub o pdf. La única forma de separarlos es con los tres asteriscos o tres guiones.


# 2

Nuevo capítulo. En los PDF imprimibles, los capítulos (`#`) comienzan en página derecha automáticamente.

Si quieres un párrafo con una clase específica (para dar formato especial), hay varias formas compatibles con Pandoc.


## Consejos rápidos

- Para separar escenas: usa `***` o `---` en una línea.
- Para saltos de capítulo: usa `#` (h1). Ya fuerza salto de página en los PDF.
- Para ocultar un título del índice/TOC: añade `{.unlisted .unnumbered}` al encabezado.


## Estilos especiales


A continuación tenemos un ejemplo de cómo definir encabezados con clases y atributos adicionales.

- Tras el encabezado, entre llaves, puedes indicar clases.

- .colophon es para marcar el estilo especial. Esta clase está definida en las plantillas incluidas.

- .unlisted y .unnumbered hacen que no aparezca en la tabla de contenidos y que palabra "Colofón" no se muestre (solamente se mostrará el contenido)


Aunque si esto no te queda claro, simplemente, puedes copiar y pegar ;)


# Colofón {.colophon .unlisted .unnumbered epub:type="afterword" role="doc-afterword"}

Aquí puedes escribir créditos, licencias o información final. En los estilos incluidos, el colofón se maquetará como página aparte sin numeración. Lo que va entre llaves son clases y atributos que definen que esta sección será especial.


***


¡Gracias!