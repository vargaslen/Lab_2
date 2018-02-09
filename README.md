Hangperson: una asignaci�n de inicio de ESaaS con scaffolded (!)
(v1.1, septiembre de 2015. Escrito por Armando Fox y Nick Herson) (algunas ediciones de mverdicchio 21 de septiembre de 2015) (refinamientos de Armando Fox, septiembre de 2017)

En esta tarea, conocer�s parte del ciclo b�sico de creaci�n de SaaS de forma disciplinada.



Metas de aprendizaje
Despu�s de completar esta tarea, podr�s:

Crear e implementar aplicaciones simples de SaaS en tu entorno de desarrollo e implementarlas en la nube p�blica
Practicar el flujo de trabajo b�sico del desarrollo basado en pruebas (TDD), en el que las pruebas se escriben antes del c�digo (para que fallen cuando se ejecuta por primera vez) y luego se agrega el c�digo para que pasen.
Comprender c�mo los "frameworks" SaaS como Sinatra admiten los componentes conceptuales de una arquitectura de aplicaciones SaaS de tres niveles
Comprender los desaf�os de adaptar una aplicaci�n que no es SaaS a un entorno SaaS, que incluye c�mo identificar y administrar el estado de la aplicaci�n
Comprender un caso de uso de arquitectura orientada a servicios, en la cual su aplicaci�n SaaS depende de la API de un servicio externo (interfaz de programaci�n de aplicaciones) para proporcionar parte de la funcionalidad de la aplicaci�n SaaS.
Requisitos previos
Debes estar familiarizado con los principios b�sicos de Ruby, por ejemplo completando el Lab_1 y consultando la documentaci�n.
Necesitar� habilidades y facilidad de l�nea de comandos de Unix de "nivel de supervivencia" (ej: cambiar directorio actual) con un editor para editar archivos de c�digos, como el editor incorporado en el IDE de Atom.
NOTA: Puede encontrar �til la documentaci�n de Sinatra.

Introducci�n
El ciclo Agile / XP completo incluye hablar con el cliente, usar BDD para desarrollar escenarios, convertir esos escenarios en pruebas ejecutables de integraci�n / aceptaci�n con "Cucumber", usar esos escenarios m�s TDD para impulsar la creaci�n del c�digo real y desplegar el resultado del trabajo de cada iteraci�n a la nube.

En esta tarea introductoria, se proporcionan pruebas de unidad RSpec para permitirle usar TDD para desarrollar la l�gica del juego popular Hangman (ahorcado). En el ciclo completo de Agile / XP, t� mismo desarrollar�as estas pruebas a medida que codificas.

A continuaci�n, utilizar�s el "framework" Sinatra para hacer que el juego Hangman est� disponible como SaaS. La adaptaci�n de la l�gica del juego para SaaS te permitir� pensar en rutas RESTful y arquitectura orientada a servicios. A medida que desarrolles el juego Hangman "SaaS-ificado", usar�s "Cucumber" para describir c�mo funcionar� el juego desde el punto de vista del jugador y como pruebas de integraci�n de "pila completa"(full stack) que impulsar�n el desarrollo de SaaS. En el ciclo completo de Agile / XP, t� mismo desarrollar�as los escenarios de "cucumber" bas�ndote en la consulta con el cliente y crear�as las definiciones de paso necesarias (c�digo de cucumber que convierte los escenarios de lenguaje simple en pruebas ejecutables). En esta tarea, proporcionamos escenarios y definiciones de pasos para t�.

Implementar�s tu juego en la nube con Heroku, lo que te brindar� experiencia en la automatizaci�n de la implementaci�n de SaaS.

�Por qu� Sinatra?

Esta asignaci�n utiliza el marco simple de Sinatra en lugar de Rails, para que puedas centrarte en las herramientas, la mec�nica y los conceptos de SaaS, que se correlacionar�n f�cilmente con Rails m�s adelante. Como nuestra aplicaci�n no tiene una base de datos y tiene muy pocas funciones, Sinatra es una manera f�cil de comenzar.

Contenido

Parte 0: Desmitificar la creaci�n de aplicaciones SaaS

Parte 1: Hangperson

Parte 2: Pensamiento RESTful para HangPerson

Parte 3: Conexi�n de Hangperson Game a Sinatra

Parte 4: Introducci�n al cucumber

Parte 5: casos de esquina

Parte 6: Conclusi�n
