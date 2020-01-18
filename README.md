# Lector-de-noticias

## Proyecto fin de curso

Vamos a crear un lector RSS de noticias en iOS usando una tabla y una colección, además de
una vista simple para mostrar la información de la propia app.
La app constará de tres pestañas de forma obligatoria:
- Noticias
- Favoritos
- Acerca de


### Lectura de los datos
Se deberán leer los datos de un JSON y tratarlo con Codable para cargar en un struct (o varios)
que sean capaces de entender y crear la estructura de los mismos.
La fuente de los datos será la siguiente URL que será la fuente asíncrona de datos:
https://applecoding.com/wp-json/wp/v2/posts
Para mayor referencia, podéis consultar el significado de los campos en la siguiente URL:
https://developer.wordpress.org/rest-api/reference/posts/
Esta llamada devuelve los últimos 10 artículos en un formato bastante extenso en formato JSON.
El JSON tiene una estructura en formato array con corchetes al comienzo y al final y una
estructura repetitiva.
Los datos básicos a recuperar serán:
- id
- date
- link
- title -> rendered
- content -> rendered
- excerpt -> rendered
- jetpack_featured_media_ur
