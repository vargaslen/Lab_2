Parte 1: Hangperson
Con toda esta maquinaria en mente, clone este repositorio en Cloud9, y trabajemos en Hangperson.

$ git clone https://github.com/saasbook/hw-sinatra-saas-hangperson
$ cd hw-sinatra-saas-hangperson
$ bundle
Desarrollando Hangperson usando TDD y Guardia
Objetivos: utilice el desarrollo basado en pruebas (TDD) basado en las pruebas que hemos proporcionado para desarrollar la lógica del juego para Ahorcado, lo que le obliga a pensar qué datos son necesarios para capturar el estado del juego. Esto será importante cuando SaaS-ify el juego en la siguiente parte.

Lo que hará: utilizar autotest, nuestros casos de prueba proporcionados se volverán a ejecutar cada vez que realice un cambio en el código de la aplicación. Una por una, las pruebas pasarán de rojo (fallido) a verde (aprobado) a medida que crea el código de la aplicación. Para cuando hayas terminado, tendrás una clase de juego Hangperson en funcionamiento, lista para ser "envuelta" en SaaS usando Sinatra.

Visión de conjunto
Nuestra versión basada en la web del popular juego "verdugo" funciona de la siguiente manera:

La computadora elige una palabra al azar

El jugador adivina las letras para adivinar la palabra

Si el jugador adivina la palabra antes de hacer siete aciertos incorrectos de letras, gana; de lo contrario, pierden. (Adivinar la misma letra en varias ocasiones simplemente se ignora).

Una letra que ya ha sido adivinada o es un carácter no alfabético se considera "inválida", es decir, no es una suposición "válida".

Para que el juego sea divertido, cada vez que inicias un juego nuevo, la aplicación recuperará una palabra aleatoria en inglés de un servidor remoto, por lo que cada juego será diferente. Esta característica lo introducirá no solo a utilizar un servicio externo (el generador de palabras aleatorias) como un "elemento básico" en una arquitectura orientada a servicios , sino también a cómo un escenario de pepino puede probar dicha aplicación de manera determinista con pruebas que rompen la dependencia en el servicio externo en el momento de la prueba.

En el directorio raíz de la aplicación, di bundle exec autotest.
Esto activará el marco Autotest, que busca varios archivos para descubrir qué tipo de aplicación está probando y qué marco de prueba está utilizando. En nuestro caso, descubrirá el archivo llamado .rspec, que contiene las opciones de RSpec e indica que estamos utilizando el marco de prueba de RSpec. Por lo tanto, Autotest buscará los archivos de prueba en spec/y los archivos de clase correspondientes en lib/.

Hemos proporcionado un conjunto de 18 casos de prueba para ayudarlo a desarrollar la clase de juego. Eche un vistazo a spec/hangperson_game_spec.rb. Especifica los comportamientos que espera de la clase lib/hangperson_game.rb. Inicialmente, hemos agregado , :pending => truetodas las especificaciones, por lo que cuando Autotest las ejecuta por primera vez, debería ver los nombres de casos de prueba impresos en amarillo y el informe "18 ejemplos, 0 fallos, 18 pendientes".

Ahora, con Autotest todavía ejecutándose, elimínelo , :pending => truede la línea 12 y guarde el archivo. Debería ver inmediatamente que Autotest se active y vuelva a ejecutar las pruebas. Ahora debería tener 18 ejemplos, 1 falla, 17 pendientes.

El describe 'new'bloque significa que "el siguiente bloque de pruebas describe el comportamiento de una 'nueva' instancia de HangpersonGame". La hangpersonGamelínea hace que se cree una nueva instancia y las siguientes líneas verifican la presencia y los valores de las variables de instancia.

Preguntas de autoverificación
De acuerdo con nuestros casos de prueba, ¿cuántos argumentos espera el constructor de la clase de juego y, por lo tanto, cómo se verá la primera línea de la definición de método a la que debe agregar hangperson_game.rb?

Según las pruebas en este describebloque, ¿qué variables de instancia se espera que tenga HangpersonGame?

Para hacer que esta prueba falle, deberá crear getters y setters para las variables de instancia mencionadas en las pruebas de autocomprobación anteriores. Sugerencia: uso attr_accessor. Cuando haya hecho esto correctamente y lo haya guardado hangperson_game.rb, autotestdebería volver a activarse y los ejemplos que anteriormente fallaban ahora deberían pasar (verde).

Continúe de esta manera, eliminando , :pending => truede uno o dos ejemplos a la vez, bajando las especificaciones, hasta que haya implementado todos los métodos de instancia de la clase de juego : guess, que procesa una suposición y modifica las variables de instancia wrong_guessesy en guessesconsecuencia; check_win_or_lose, Que devuelve uno de los símbolos :win, :loseo :playdependiendo del estado actual del juego; y word_with_guesses, que sustituye las conjeturas correctas hechas hasta ahora en la palabra.

Sugerencia de depuración
Al ejecutar las pruebas, puede insertar el comando Ruby byebugen el código de su aplicación para pasar al depurador de la línea de comandos e inspeccionar las variables, etc. Escriba hpara obtener ayuda en el indicador de depuración. Escriba cpara salir del depurador y continuar ejecutando su código.

Eche un vistazo al código en el método de clase get_random_word, que recupera una palabra aleatoria de un servicio web que encontramos que hace precisamente eso. Use el siguiente comando para verificar que el servicio web funcione de esta manera. Ejecútelo varias veces para verificar que obtenga diferentes palabras.
$ curl --data '' http://watchout4snakes.com/wo4snakes/Random/RandomWord
( --dataes necesario obligar curla hacer un POST en lugar de un GET. Normalmente, el argumento --datasería los campos de formulario codificados, pero en este caso no se necesitan campos de formulario.) El uso curles una excelente manera de depurar las interacciones con servicios externos. man curlpara (mucho) más detalles sobre esta poderosa herramienta de línea de comandos.

Siguiente: Parte 2 - Pensamiento RESTful
