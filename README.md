Hangperson: una asignaci�n de inicio de ESaaS con scaffolded (!)
(v1.1, septiembre de 2015. Escrito por Armando Fox y Nick Herson) (algunas ediciones de mverdicchio 21 de septiembre de 2015) (refinamientos de Armando Fox, septiembre de 2017)

En esta tarea, conocer�s parte del ciclo b�sico de creaci�n de SaaS de forma disciplinada.



Metas de aprendizaje
Despu�s de completar esta tarea, podr�:

Cree e implemente aplicaciones simples de SaaS en su entorno de desarrollo e implem�ntelas en la nube p�blica
Practique el flujo de trabajo b�sico del desarrollo basado en pruebas (TDD), en el que las pruebas se escriben antes del c�digo (para que fallen cuando se ejecuta por primera vez) y luego se agrega el c�digo para que pasen.
Comprender c�mo los marcos SaaS como Sinatra admiten los componentes conceptuales de una arquitectura de aplicaciones SaaS de tres niveles
Comprender los desaf�os de adaptar una aplicaci�n que no es SaaS a un entorno SaaS, que incluye c�mo identificar y administrar el estado de la aplicaci�n
Comprenda un caso de uso de arquitectura orientada a servicios, en la cual su aplicaci�n SaaS depende de la API de un servicio externo (interfaz de programaci�n de aplicaciones) para proporcionar parte de la funcionalidad de la aplicaci�n SaaS.
Requisitos previos
Debes estar familiarizado con los principios b�sicos de Ruby, por ejemplo completando la tarea Ruby Intro o Ruby Calisthenics.
Deber�a haber le�do el Cap�tulo 2 de ESaaS , "La arquitectura de las aplicaciones SaaS", y haber visto los videos que lo acompa�an en el MOOC .
Deber�a sentirse c�modo con el uso b�sico de Git y c�mo insertar su c�digo en GitHub, como se describe en el Ap�ndice A de ESaaS .
Necesitar� habilidades y facilidad de l�nea de comandos de Unix de "nivel de supervivencia" con un editor para editar archivos de c�digos, como el editor incorporado en el IDE de Cloud9.
NOTA: Puede encontrar �til la documentaci�n de Sinatra para tener a mano.

Introducci�n
El ciclo Agile / XP completo que seguimos en ESaaS incluye hablar con el cliente, usar BDD para desarrollar escenarios, convertir esos escenarios en pruebas ejecutables de integraci�n / aceptaci�n con Cucumber, usar esos escenarios m�s TDD para impulsar la creaci�n del c�digo real y desplegar el resultado del trabajo de cada iteraci�n a la nube.

En esta tarea introductoria, hemos proporcionado pruebas de unidad RSpec para permitirle usar TDD para desarrollar la l�gica del juego popular Hangman. En el ciclo completo de Agile / XP, t� mismo desarrollar�as estas pruebas a medida que codificas.

A continuaci�n, utilizar� el marco Sinatra para hacer que el juego Hangman est� disponible como SaaS. La adaptaci�n de la l�gica del juego para SaaS le permitir� pensar en rutas RESTful y arquitectura orientada a servicios. A medida que desarrolles el juego Hangman "SaaS-ified", usar�s Cucumber para describir c�mo funcionar� el juego desde el punto de vista del jugador y como pruebas de integraci�n de "pila completa" que impulsar�n el desarrollo de SaaS. En el ciclo completo de Agile / XP, usted mismo desarrollar�a los escenarios de Pepino bas�ndose en la consulta con el cliente y crear�a las definiciones de paso necesarias (c�digo de pepino que convierte los escenarios de ingl�s simple en pruebas ejecutables). En esta tarea, proporcionamos escenarios y definiciones de pasos para usted.

Implementar�s tu juego en la nube con Heroku, lo que te brindar� experiencia en la automatizaci�n de la implementaci�n de SaaS.

�Por qu� Sinatra?

Esta asignaci�n utiliza el marco simple de Sinatra en lugar de los rieles, para que pueda centrarse en las herramientas, la mec�nica y los conceptos de SaaS, que se correlacionar�n f�cilmente con Rails m�s adelante. Como nuestra aplicaci�n no tiene una base de datos y tiene muy pocas funciones, Sinatra es una manera f�cil de comenzar.

Contents
---------

* Part 0: [Demystifying SaaS app creation](docs/part_0_create_saas_app.md)
* Part 1: [Hangperson](docs/part_1_hangperson.md)
* Part 2: [RESTful thinking for HangPerson](docs/part_2_restful_thinking.md)
* Part 3: [Connecting HangpersonGame to Sinatra](docs/part_3_connecting_hangperson_to_sinatra.md)
* Part 4: [Introducing Cucumber](docs/part_4_cucumber.md)
* Part 5: [Corner Cases](docs/part_5_corner_cases.md)
* Part 6: [Conclusion](docs/part_6_conclusion.md)
* Part 7: [Optional Challenge Assignment](docs/part_7_optional_challenge.md)
