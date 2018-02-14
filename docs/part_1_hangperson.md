Parte 1: Hangperson

Con toda la maquinaria ya vista en mente, clone este repositorio localmente, y trabajemos en Hangperson.

$ git clone https://github.com/vargaslen/hangperson
$ cd hangperson
$ bundle

Desarrollando Hangperson usando TDD y "Guard"

Objetivos: utilizar el desarrollo basado en pruebas (TDD) basado en las pruebas que hemos proporcionado para desarrollar la lógica del juego para "Ahorcado" (hangman), lo que te obliga a pensar: qué datos son necesarios para capturar el "estado del juego". Esto último  será importante cuando SaaS-ify (modismo de habilitar en SaaS) el juego en la siguiente parte.

Lo que harás:

Utilizarás "autotest", nuestros casos de prueba proporcionados se volverán a ejecutar cada vez que realices un cambio en el código de la aplicación. Una por una, las pruebas pasarán de rojo (fallido) a verde (aprobado) a medida que creas el código de la aplicación. Para cuando hayas terminado, tendrás una clase de juego Hangperson en funcionamiento, lista para ser "envuelta" en SaaS usando Sinatra.

Visión de conjunto:

Nuestra versión basada en la web del popular juego "Ahorcado" funciona de la siguiente manera:

1- La computadora elige una palabra al azar

2- El jugador adivina las letras para adivinar la palabra

3- Si el jugador adivina la palabra antes de hacer siete intentos incorrectos de letras, gana; de lo contrario, pierde. (Adivinar la misma letra en varias ocasiones simplemente se ignora).

4- Una letra que ya ha sido adivinada o es un carácter no alfabético se considera "inválida", es decir, no es un intento "válido".

Para que el juego sea divertido, cada vez que inicias un juego nuevo, la aplicación recuperará una palabra aleatoria en inglés de un servidor remoto, por lo que cada juego será diferente. Esta característica te familiarizará no solo a utilizar un servicio externo (el generador de palabras aleatorias) como un "elemento básico" en una arquitectura orientada a servicios , sino también a cómo un escenario (scenario) "Cucumber" puede probar dicha aplicación de manera determinista con pruebas (tests) que rompen la dependencia en el servicio externo en el momento de la prueba.

En el directorio raíz de la aplicación, tipea: bundle exec autotest.

Esto activará el marco Autotest, que busca varios archivos para descubrir qué tipo de aplicación estás probando y qué marco (framework) de prueba estás utilizando. En nuestro caso, descubrirá el archivo llamado .rspec, que contiene las opciones de RSpec e indica que estamos utilizando el marco de prueba de RSpec. Por lo tanto, Autotest buscará los archivos de prueba en spec/y los archivos de clase correspondientes en lib/.

Hemos proporcionado un conjunto de 18 casos de prueba para ayudarte a desarrollar la clase de juego. Echa un vistazo a spec/hangperson_game_spec.rb. Especifica los comportamientos que esperas de la clase lib/hangperson_game.rb. Inicialmente, hemos agregado , :pending => true a todas las especificaciones, por lo que cuando Autotest las ejecuta por primera vez, deberías ver los nombres de casos de prueba impresos en amarillo y el informe "18 ejemplos, 0 fallos, 18 pendientes".

Ahora, con Autotest todavía ejecutándose, elimínelo , :pending => truede la línea 12 y guarde el archivo. Debería ver inmediatamente que Autotest se active y vuelva a ejecutar las pruebas. Ahora debería tener 18 ejemplos, 1 falla, 17 pendientes.

El bloque: describe 'new' , significa que "el siguiente bloque de pruebas describe el comportamiento de una 'nueva' instancia de HangpersonGame". La línea hangpersonGame hace que se cree una nueva instancia y las siguientes líneas verifican la presencia y los valores de las variables de instancia.


Para hacer que esta prueba falle, deberás crear "getters y setters" para las variables de instancia . Sugerencia: usa "attr_accessor". Cuando hayas hecho esto correctamente y lo hayas guardado en hangperson_game.rb, autotest debería volver a activarse y los ejemplos que anteriormente fallaban ahora deberían pasar (verde).

Continúa de esta manera, eliminando , :pending => true de uno o dos ejemplos a la vez, recorriendo las especificaciones, hasta que hayas implementado todos los métodos de instancia de la clase de juego : a) guess, que procesa una suposición y modifica las variables de instancia "wrong_guesses" y "guesses"  en consecuencia; b) check_win_or_lose, Que devuelve uno de los símbolos :win, :lose o :play dependiendo del estado actual del juego; y c) word_with_guesses, que sustituye las conjeturas correctas hechas hasta ahora en la palabra.

Sugerencia de depuración

Al ejecutar las pruebas, puedes insertar el comando Ruby: byebug , en el código de tu aplicación para pasar al depurador de la línea de comandos e inspeccionar las variables, etc. Escribe: h , para obtener ayuda en el indicador de depuración. Escribe: c,para salir del depurador y continuar ejecutando tu código.

Echa un vistazo al código en el método de clase get_random_word, que recupera una palabra aleatoria de un servicio web que encontramos y que hace precisamente eso. Usa el siguiente comando para verificar que el servicio web funcione de esta manera. Ejecútalo varias veces para verificar que obtenga diferentes palabras.

$ curl --data '' http://watchout4snakes.com/wo4snakes/Random/RandomWord (para instalar curl en windows, sigue instrucciones en: http://www.oracle.com/webfolder/technetwork/tutorials/obe/cloud/13_2/messagingservice/files/installing_curl_command_line_tool_on_windows.html)

( es necesario "--data" para obligar a "curl"  hacer un POST en lugar de un GET. Normalmente, el argumento de "--data" sería los campos del formulario codificados, pero en este caso no se necesitan campos de formulario.) El uso de curl es una excelente manera de depurar las interacciones con servicios externos. 

Siguiente: Parte 2 - Pensamiento RESTful
