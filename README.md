Hangperson: una asignación de inicio de ESaaS con scaffolded (!)
(v1.1, septiembre de 2015. Escrito por Armando Fox y Nick Herson) (algunas ediciones de mverdicchio 21 de septiembre de 2015) (refinamientos de Armando Fox, septiembre de 2017)

En esta tarea, conocerás parte del ciclo básico de creación de SaaS de forma disciplinada.



Metas de aprendizaje
Después de completar esta tarea, podrás:

Crear e implementar aplicaciones simples de SaaS en tu entorno de desarrollo e implementarlas en la nube pública
Practicar el flujo de trabajo básico del desarrollo basado en pruebas (TDD), en el que las pruebas se escriben antes del código (para que fallen cuando se ejecuta por primera vez) y luego se agrega el código para que pasen.
Comprender cómo los "frameworks" SaaS como Sinatra admiten los componentes conceptuales de una arquitectura de aplicaciones SaaS de tres niveles
Comprender los desafíos de adaptar una aplicación que no es SaaS a un entorno SaaS, que incluye cómo identificar y administrar el estado de la aplicación
Comprender un caso de uso de arquitectura orientada a servicios, en la cual su aplicación SaaS depende de la API de un servicio externo (interfaz de programación de aplicaciones) para proporcionar parte de la funcionalidad de la aplicación SaaS.
Requisitos previos
Debes estar familiarizado con los principios básicos de Ruby, por ejemplo completando el Lab_1 y consultando la documentación.
Necesitará habilidades y facilidad de línea de comandos de Unix de "nivel de supervivencia" (ej: cambiar directorio actual) con un editor para editar archivos de códigos, como el editor incorporado en el IDE de Atom.
NOTA: Puede encontrar útil la documentación de Sinatra.

Introducción
El ciclo Agile / XP completo incluye hablar con el cliente, usar BDD para desarrollar escenarios, convertir esos escenarios en pruebas ejecutables de integración / aceptación con "Cucumber", usar esos escenarios más TDD para impulsar la creación del código real y desplegar el resultado del trabajo de cada iteración a la nube.

En esta tarea introductoria, se proporcionan pruebas de unidad RSpec para permitirle usar TDD para desarrollar la lógica del juego popular Hangman (ahorcado). En el ciclo completo de Agile / XP, tú mismo desarrollarías estas pruebas a medida que codificas.

A continuación, utilizarás el "framework" Sinatra para hacer que el juego Hangman esté disponible como SaaS. La adaptación de la lógica del juego para SaaS te permitirá pensar en rutas RESTful y arquitectura orientada a servicios. A medida que desarrolles el juego Hangman "SaaS-ificado", usarás "Cucumber" para describir cómo funcionará el juego desde el punto de vista del jugador y como pruebas de integración de "pila completa"(full stack) que impulsarán el desarrollo de SaaS. En el ciclo completo de Agile / XP, tú mismo desarrollarías los escenarios de "cucumber" basándote en la consulta con el cliente y crearías las definiciones de paso necesarias (código de cucumber que convierte los escenarios de lenguaje simple en pruebas ejecutables). En esta tarea, proporcionamos escenarios y definiciones de pasos para tí.

Implementarás tu juego en la nube con Heroku, lo que te brindará experiencia en la automatización de la implementación de SaaS.

¿Por qué Sinatra?

Esta asignación utiliza el marco simple de Sinatra en lugar de Rails, para que puedas centrarte en las herramientas, la mecánica y los conceptos de SaaS, que se correlacionarán fácilmente con Rails más adelante. Como nuestra aplicación no tiene una base de datos y tiene muy pocas funciones, Sinatra es una manera fácil de comenzar.

Contenido
Parte 0: Desmitificar la creación de aplicaciones SaaS

Parte 1: Hangperson

Parte 2: Pensamiento RESTful para HangPerson

Parte 3: Conexión de Hangperson Game a Sinatra

Parte 4: Introducción al cucumber

Parte 5: casos de esquina

Parte 6: Conclusión

