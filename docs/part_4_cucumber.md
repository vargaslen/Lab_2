PARTE 4: INTRODUCCION A CUCUMBER

Cucumber es una herramienta notable para escribir pruebas de integración y aceptación de alto nivel, términos con los que ya estás familiarizado. Aprenderemos mucho más sobre Cucumber más adelante, pero por ahora lo usaremos para impulsar el desarrollo del código de tu aplicación.

Del mismo modo que utilizaste RSpec para "impulsar" la creación de los métodos de la clase, a continuación utilizarás Cucumber para impulsar la creación del código SaaS.

Normalmente, el ciclo sería:

Utiliza el "Scenario" Cucumber para expresar el comportamiento de extremo a extremo de un escenario.
Cuando empieces a escribir el código para hacer que cada paso del "Scenario" valide bien, usa RSpec para conducir la creación del código de ese paso.
Repite hasta que todos los pasos del "Scenario" validen bien ( se pongan en verde ).
En esta tarea nos estamos saltando el paso intermedio ya que el objetivo es brindarte una descripción general de todas las partes del proceso. Además, en el primer paso, para tus propias aplicaciones, tu mismo crearías los "Scenario" de Cucumber; en esta tarea, los hemos proporcionado para ti.

Cucumber te permite expresar escenarios("Scenarios") de prueba de integración, que encontrarás en el directorio:features  en archivos de tipo:.feature . También verás un subdirectorio:step_definitions  con un solo archivo:game_steps.rb, que contiene el código utilizado cuando se ejecuta cada "paso" en un escenario como parte de la prueba.

Como una herramienta de prueba de integración, Cucumber se puede utilizar para probar casi cualquier tipo de sistema de software siempre que haya una manera de simular el sistema y una forma de inspeccionar el comportamiento del sistema. Selecciona un "back-end" para Cucumber basado en cómo se debe simular e inspeccionar el sistema final.

Dado que un servidor SaaS se simula mediante la emisión de solicitudes HTTP, y su comportamiento se puede inspeccionar mirando las páginas HTML servidas, configuramos Cucumber para usar: Capybara , un simulador de navegador basado en Ruby que incluye un lenguaje específico de dominio (DSL) para simular acciones del navegador e inspeccionar las respuestas del servidor SaaS a esas acciones.


Lee la sección sobre "Uso de Capybara con Cucumber" en la página principal de Capybara. ¿Qué definiciones de un "paso" usan Capybara para simular el servidor como lo haría un navegador?:respuesta:Las definiciones de "pasos" que usan: visit, click_button`, fill_in, simulan un navegador visitando una página y / o completando un formulario en esa página y haciendo clic en sus botones.
¿Qué definiciones de "paso" usan Capybara para inspeccionar la respuesta de la aplicación al estímulo?resp: Aquellos que usan: have_content, están inspeccionando la salida.

Mira en el archivo features/guess.feature, ¿cuál es el papel de las tres líneas siguientes al encabezado "Feature:"?resp:Son comentarios que muestran el propósito y los actores de esta historia. Cucumber no los ejecutará.

En el mismo archivo, mirando el paso del escenario: Given I start a new game with word "garply", ¿qué líneas de game_steps.rb se invocarán cuando Cucumber intente ejecutar este paso, y cuál es el papel de la cadena "garply"en el paso?resp:Las líneas 13-16 del archivo se ejecutarán. Se elige un "paso" al hacer coincidir una expresión regular(regexp), la variable:word coincidirá con el primer grupo de captura de paréntesis (y en este caso solamente) en la expresión regular, que en este ejemplo es garply.

HAGAMOS PASAR EL PRIMER SCENARIO
Primero pasaremos el escenario "start new game" (definido en: start_new_game.feature); A continuación, utilizarás las mismas técnicas para hacer que pasen los otros escenarios, completando así la aplicación. Así que echa un vistazo a la definición de "paso" para "I start a new game with word..."

Ya has visto que puedes cargar la nueva página del juego, pero obtienes un error al hacer clic en el botón para crear un juego nuevo. Ahora reproducirás este comportamiento con un escenario de Cuke(diminutivo de Cucumber).


Cuando el "simulador de navegador" en Capybara emite la solicitud:visit '/new' , Capybara simulará un "HTTP GET" a la URL parcial /new en la aplicación. ¿Por qué crees que visit siempre hace un GET, en lugar de dar la opción de hacer un GET o un POST en un paso dado?resp:Se supone que Cucumber / Capybara solo puede simular lo que un usuario humano puede hacer. Como mencionamos anteriormente, la única forma en que un usuario humano puede hacer que un POST ocurra a través de un navegador web es enviar un formulario HTML, que se realiza al presionar el botón(click button) en Capybara.

Ejecuta el escenario del "nuevo juego" con:

$ cucumber features/start_new_game.feature

Si obtienes un error acerca de Cucumber como el que se describe abajo, simplemente sige las indicaciones y corre bundle install primero.

~/workspace/hw-sinatra-saas-hangperson (master) $ cucumber features/start_new_game.feature
Could not find proper version of cucumber (2.0.0) in any of the sources
Run `bundle install` to install missing gems.

El escenario falla porque la etiqueta <form> en views/new.erb es incorrecta(está incompleta) en la información que le dice al navegador a qué URL enviar el formulario. Según la tabla de rutas que desarrollamos en una sección anterior, complete los  atributos de la etiqueta <form> de forma adecuada. Puedes inspeccionar lo que ocurre en varias rutas en app.rb, pero no necesitas editar este archivo todavía. (Sugerencia: si te quedas atascado, mira show.erb (en la parte inferior) un ejemplo similar de una etiqueta de formulario llena).

El código de crear un nuevo juego en la aplicación Sinatra debería hacer lo siguiente:

Llamar al método de clase HangpersonGame#get_random_word (genera una palabra al azar)
Crear una nueva instancia de HangpersonGame usando esa palabra
Redirigir el navegador a la acción show
Ve cómo se actualizan estos pasos en el archivo app.rb debajo de la ruta: post /create do .

Ahora prepara (stage) y  has commit de odos los archivos  locales para ser enviados a  Heroku ( desde donde tu app puede ser llamada): git push heroku master .Invoca nuevamente tu app en Heroku y verifica manualmente este comportamiento mejorado.



DESARROLLAR EL ESCENARIO PARA ADIVINAR UNA LETRA

Para este escenario, en features/guess.feature, ya hemos proporcionado un archivo HTML correcto: show.erb   que envía la adivinanza del jugador a la acción guess . Ya tienes un método HangpersonGame#guess  de instancia que tiene la funcionalidad necesaria.


En game_steps.rb, mira el código para el paso "Comienzo un nuevo juego ..." y, en particular, el comando:stub_request . Dada la sugerencia de que ese comando es proporcionado por una Gema (librería) llamada webmock, ¿qué está pasando con esa línea y por qué es necesaria? (Use Google si es necesario).resp:Webmock permite que nuestras pruebas "intercepten" las solicitudes HTTP ** procedentes de ** nuestra aplicación y se dirijan a otro servicio. En este caso, está interceptando la solicitud POST (la misma que hizo manualmente con curl en una parte anterior de la asignación) y simulando el valor de respuesta. Esto nos permite aplicar el comportamiento determinista de nuestras pruebas, y también significa que no estamos llegando al servidor externo real cada vez que se ejecuta nuestra prueba.

El hash especial de Sinatra: params[] , tiene un par de clave-valor(key-value) para cada campo no en blanco en un formulario enviado: la clave es el atributo name  "simbolizado" del campo de formulario y el valor es lo que el usuario tipeó en ese campo, o en el caso de una casilla de verificación (checkbox) o un botón de radio (radiobutton), los valores especificados por el navegador que indican si están marcados o no. ("Simbolizado" significa que la cadena se convierte en un símbolo, por lo que se "foo"convierte en :foo).

En tu código de Sinatra para procesar una adivinanza, ¿qué expresión usarías para extraer * solo el primer carácter * de lo que el usuario escribió en el campo de adivinar letras (guess) del formulario show.erb? ** PRECAUCIÓN: ** si el usuario no escribió nada, no aparecerá ninguna clave coincidente en params[], por lo que se eliminará la referencia del campo del formulario: nil. En ese caso, tu código debería devolver la cadena vacía en lugar de un error.resp: params[:guess].to_s[0] o su equivalente. to_s convierte nil en la cadena vacía en caso de que el campo de formulario se haya dejado en blanco (y, por lo tanto, no se haya incluido en params). [0] toma el primer carácter solamente; para una cadena vacía, devuelve una cadena vacía.

En el código "guess"  del archivo Sinatra: app.rb, debe hacer lo siguiente:

Extraer la letra enviada en el formulario. (dado arriba y en el código para tí)
Usar esa letra como adivinanza en el juego actual. (debes agregar este código)
Redirigir a la acción show  para que el jugador pueda ver el resultado de su suposición. (hecho para ti también)
Mientras estás aquí, lee los comentarios en el archivo. Dan pistas para futuros pasos en esta tarea.

Cuando termine de agregar ese código, verifica que todos los pasos features/guess.feature ahora pasen ejecutando cucumber  para ese archivo (guess.feature).

Sugerencia de depuración: el comando Capybara save_and_open_page colocado en una definición de paso hará que el paso abra una ventana del navegador web que muestre cómo se ve la página en ese punto del escenario. La funcionalidad es proporcionada en parte por una gema llamada "launchy" que se encuentra en el Gemfile.

Siguiente: Parte 5 - Casos de esquina
