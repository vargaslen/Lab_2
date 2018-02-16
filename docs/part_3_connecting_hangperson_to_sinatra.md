
PARTE 3: CONEXIÓN DEL JUEGO HANGPERSON (AHORCADO)  A SINATRA

Ya conociste a Sinatra (recuerda la clase MyApp). Esto es lo nuevo  del armazón de la aplicación Sinatra app.rb que ya comenzamos a trabajar en Hangperson:

before do...end : es un bloque de código ejecutado antes de cada solicitud de SaaS

after do...end  : se ejecuta después de cada solicitud de SaaS

Las llamadas "erb : acción"   hacen que Sinatra busque el archivo views/acción (de tipo .erb) y lo ejecute a través del procesador Ruby (erb: embedded ruby), que busca construcciones <%= like this %>, ejecuta el código de Ruby dentro y sustituye el resultado. El código se ejecuta en el mismo contexto que la llamada a erb, por lo que el código puede "ver" cualquier variable de instancia configurada en los bloques get o post.

@game es una variable de instancia de la clase HangpersonApp en el archivo app.rb .Estamos tratando aquí con dos clases de Ruby: la clase HangpersonGame encapsula la lógica del juego en sí misma (es decir, el Modelo en el patron Modelo-Vista-Controlador), mientras que la clase  HangpersonApp (como en MyApp) encapsula la lógica que nos permite "montar" el juego como SaaS (puede pensar más o menos de ella como la lógica del controlador más la capacidad de representar las vistas a través de erb).

LA SESIÓN

Ya identificamos los elementos necesarios para mantener el estado del juego y los encapsulamos en la clase de juego. Como el protocolo HTTP no tiene estado (stateless), cuando aparece una nueva solicitud HTTP, no hay ninguna noción del "juego actual". Lo que tenemos que hacer, por lo tanto, es guardar el objeto del juego de alguna manera entre las solicitudes.

Si el objeto del juego fuera grande, probablemente lo almacenaríamos en un registro de base de datos en el servidor (permanencia) y colocaríamos el identificador de dicho registro  en una "cookie" (de hecho, como veremos, esto es exactamente lo que hacen las aplicaciones Rails). Pero dado que nuestro estado de juego es pequeño, podemos simplemente poner todo en la cookie. La biblioteca de session  de Sinatra nos permite hacer esto: en el contexto de la aplicación Sinatra (HangpersonApp), todo lo que colocamos en el hash especial: session[] , se preserva a través de las solicitudes. De hecho, los objetos colocados allí se "serializan" en una forma textual amigable y que se conserva para nosotros. Este comportamiento se activa mediante una llamada de Sinatra: enable :sessions en: app.rb.

Hay otro objeto de sesión que usaremos. En uno de los casos anteriores, una acción realiza un cambio de estado y luego redirige a otra acción, así, cuando la acción guess  (disparada por POST /guess) redirige a la acción show ( GET /show) para volver a mostrar el estado del juego después de cada adivinanza. Pero, ¿qué sucede si la acción "Guess" quiere mostrar un mensaje al jugador, tal como informarles que han repetido erróneamente una adivinanza? El problema es que dado que cada solicitud es independiente (stateless), tenemos que transmitir ese mensaje "a través" de la redirección, delmismo modo que necesitamos preservar el estado deljuego "a través de" las solicitudes HTTP ..

Para hacer esto, usamos la gema: sinatra-flash , que puedes ver en el archivo Gemfile. flash[] es un hash para recordar mensajes cortos que persisten hasta la próxima solicitud (generalmente una redirección), y luego se borran.

Cuando ponemos algo en sesión[] permanece allí hasta que lo eliminemos. El caso de un mensaje que debe "sobrevivir a una redirección" es que solo debe mostrarse una vez; flash [] incluye la funcionalidad adicional de borrar los mensajes después de la próxima solicitud.



Como antes, ejecute el comando de shell:

 bundle exec rackup -p 3000 -o 127.0.0.1

 para iniciar la aplicación.



El servidor web conectado a Sinatra se ejecutará localmente, por lo que la primera parte de la URL es algo así como http://127.0.0.1:3000. El código Ruby: get '/new' do ... en la app.rb nos lleva a la página de un Nuevo juego, por lo que la URL completa tiene el formato http://127.0.0.1:3000/new.

Visite esta URL y verifique que aparezca la página Iniciar nuevo juego.

Pregunta de autoverificación
¿Dónde está el código HTML para esta página?

Verifique que al hacer clic en el botón Nuevo juego, aparece un error. Esto se debe a que hemos dejado deliberadamente el <form>botón que incluye este botón incompleto: no hemos especificado dónde debe publicarse el formulario. Lo haremos a continuación, pero lo haremos de forma guiada por pruebas.

Pero primero, entreguemos nuestra aplicación a Heroku. Este es en realidad un paso crítico. Necesitamos asegurarnos de que nuestra aplicación se ejecute en heroku antes de comenzar a hacer cambios significativos.

Primero, ejecuta bundle installpara asegurarte de que nuestro Gemfile y Gemfile.lock estén sincronizados.
A continuación, escriba git add .para organizar todos los archivos modificados (incluido Gemfile.lock)
Luego escriba git commit -m "Ready for Heroku!"para confirmar todos los cambios locales en Cloud9.
Luego, escribe heroku loginy autentica.
Dado que esta es la primera vez que le contamos a Heroku sobre la aplicación Hangperson, debemos escribir heroku createpara que Heroku se prepare para recibir este código y hacer que cree una referencia git para hacer referencia al nuevo repositorio remoto.
Luego, escribe git push heroku masterpara enviar tu código Cloud9 a Heroku.
Cuando quieras actualizar a Heroku más tarde, solo tienes que enviar tus cambios a git localmente en Cloud9, y luego presionar a Heroku como en el último paso.
Verifique que el ahorcado desplegado por Heroku se comporte igual que su versión de desarrollo antes de continuar. Algunas líneas desde la parte inferior de la salida de Heroku en la terminal Cloud9 deberían tener una URL que termine en herokuapp.com. Busque eso, cópielo en el portapapeles y péguelo en una nueva pestaña del navegador para ver la aplicación actual. La pestaña del navegador IDE de Cloud9 no procesará la aplicación correctamente, por lo tanto, use una nueva pestaña del navegador fuera de Cloud9.
Verifique la funcionalidad rota haciendo clic en el nuevo botón de juego.
Siguiente: Parte 4 - Pepino
