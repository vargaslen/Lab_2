Parte 0: Desmitificar la creaci�n de aplicaciones SaaS

Objetivo: comprender los pasos necesarios para crear, versionar e implementar una aplicaci�n SaaS, incluido el seguimiento de las bibliotecas de las que depende para que sus entornos de producci�n y desarrollo sean lo m�s similares posible.


Lo que har�s: crea una aplicaci�n sencilla de "hola mundo" utilizando el framework Sinatra, vu�lvela a la versi�n adecuada y despli�gala en Heroku.


Crear y versionar una aplicaci�n SaaS simple


Las aplicaciones SaaS se desarrollan en tu computadora (o IDE basado en la nube) pero se implementan en un servidor al que otros pueden acceder. Intentamos minimizar las diferencias entre los entornos de desarrollo y producci�n , para evitar problemas dif�ciles de diagnosticar en los que algo funciona de una manera en tu computadora de desarrollo pero de una manera diferente (o nada) cuando ese c�digo se implementa en producci�n.

Tenemos dos mecanismos para mantener los entornos de desarrollo y producci�n consistentes. El primero es el control de versiones , como Git, para el c�digo de la aplicaci�n. Pero dado que casi todas las aplicaciones tambi�n se basan en bibliotecas escritas por otros, como gemas en el caso de Ruby, necesitamos una forma de realizar un seguimiento de las versiones de las bibliotecas con las que se ha probado nuestra aplicaci�n, para que las mismas se utilicen en desarrollo y producci�n.

Afortunadamente, Ruby tiene un maravilloso sistema para administrar dependencias de gemas: una gema llamada "Bundler" busca un archivo llamado Gemfile en el directorio ra�z de la aplicaci�n de cada proyecto. El Gemfile contiene una lista de gemas y versiones de las que depende tu aplicaci�n. Bundler verifica que esas gemas, y cualquier otra a la que dependan, est�n instaladas correctamente en tu sistema y accesibles para la aplicaci�n.


Comencemos con los siguientes pasos:


Crea un nuevo directorio vac�o para guardar tu nueva aplicaci�n y util�za:

git init

en ese directorio para comenzar a crear versiones con Git.

En ese directorio, crea un nuevo archivo llamado Gemfile (la capitalizaci�n es importante) con los siguientes contenidos. Este archivo ser� una parte permanente de tu aplicaci�n y se desplazar� con tu aplicaci�n a donde quiera que vaya:

1- source 'https://rubygems.org' 
2- ruby '2.3.0'
3-  
4- gem 'sinatra' , '>= 1.4'


La primera l�nea dice que el lugar preferido para descargar las gemas necesarias es https://rubygems.org , que es donde la comunidad de Ruby registra las gemas de producci�n.

La segunda l�nea especifica qu� versi�n del int�rprete de lenguaje Ruby se requiere. Si omitimos esta l�nea, Bundler no intentar� verificar qu� versi�n de Ruby est� disponible; hay diferencias sutiles entre las versiones, y no todas las gemas funcionan con todas las versiones, por lo que es mejor especificar esto.

La �ltima l�nea dice que necesitamos la versi�n 1.4 o posterior de la gema sinatra. En algunos casos, no necesitamos especificar qu� versi�n de una joya (gema) queremos; en este caso, lo especificamos porque dependemos de algunas caracter�sticas que est�n ausentes de las versiones anteriores de Sinatra.


Ejecutar Bundler


Ejecute el comando bundle, lo que examina Gemfile para asegurarse de que las gemas correctas (y, donde se especifique, las versiones correctas) est�n disponibles, e intenta instalarlas de otro modo. Esto crear� un nuevo archivo Gemfile.lock, que debes colocar bajo control de versi�n.

Para colocar bajo control de versi�n, usa estos comandos:

$ git add . 
$ git commit -m " Configurar el Gemfile "

El primer comando prepara todos los archivos modificados para la confirmaci�n (commit). El segundo comando confirma los archivos preparados con el comentario entre comillas. Puedes repetir estos comandos para confirmar cambios futuros. Recuerda que estos son commits LOCALES - si quieres estos cambios en GitHub, deber�s ejecutar un comando "git push", que mostraremos m�s adelante.

Despu�s de ejecutar bundle, �por qu� hay gemas enumeradas en las Gemfile.lock que no figuraban Gemfile?

Crea una aplicaci�n SaaS simple con Sinatra

Las aplicaciones SaaS requieren un servidor web para recibir solicitudes HTTP del mundo exterior y un servidor de aplicaciones que "conecta" la l�gica de su aplicaci�n con el servidor web. Para el desarrollo, utilizaremos webrick un servidor web basado en Ruby muy simple que ser�a inapropiado para la producci�n pero que est� bien para el desarrollo. Tanto en desarrollo como en producci�n, utilizaremos el servidor de aplicaciones rack ( basado en Ruby), y que es compatible con las aplicaciones de Ruby escritas en varios frameworks, incluidos Sinatra y Rails.

Una aplicaci�n SaaS esencialmente reconoce y responde a las solicitudes HTTP correspondientes a las rutas de la aplicaci�n Una ruta consiste en un m�todo HTTP como GET o POST m�s un URI). Sinatra proporciona una abreviatura extremadamente ligera para hacer coincidir una ruta con el c�digo de la aplicaci�n que se ejecutar� cuando llegue una solicitud que utiliza esa ruta desde el servidor web.

Crea un archivo en tu proyecto llamado  app.rb que contenga lo siguiente:

1- require  'sinatra'
2-
3- class  MyApp < Sinatra::Base 
4- get '/'  do 
5-    "<!DOCTYPE html><html><head></head><body><h1>Hola mundo</h1></body></html>"
6- end 
7- end

El m�todo get es proporcionado por la  clase Sinatra::Base , de la cual nuestra clase MyApp hereda; Sinatra::Base est� disponible porque cargamos la biblioteca de Sinatra en la l�nea 1.


Como puedes ver en el ejemplo simple anterior, Sinatra te permite escribir funciones que coinciden con una ruta HTTP entrante, en este caso GET '/'(la URL ra�z), un documento HTML muy simple que contiene la cadena "Hola mundo" se devolver� al nivel de presentaci�n (webrick) como resultado de la solicitud.

Para ejecutar nuestra aplicaci�n, debemos iniciar el servidor de aplicaciones y el servidor de nivel de presentaci�n (web). El servidor de aplicaciones "rack" est� controlado por un archivo config.ru, que ahora debes crear y agregar al control de versiones, y que contiene lo siguiente:

1- require  './app' 
2- run MyApp

La primera l�nea le dice a Rack que nuestra aplicaci�n vive en el archivo app.rb, que se cre� anteriormente para guardar el c�digo de tu aplicaci�n. Tenemos que declarar expl�citamente que nuestro archivo se encuentra en el directorio actual (.) Porque "require" normalmente solo busca en los directorios del sistema est�ndar para encontrar gemas.

ahora estamos listo para probar nuestra sencilla aplicaci�n con esta l�nea de comando:

$ bundle exec rackup -p 3000 -o 127.0.0.1


Este comando inicia el servidor de aplicaciones Rack y el servidor web WEBrick. Prefij�ndolo con bundle exec asegura que est� ejecutando con las gemas especificadas en Gemfile.lock. Rack buscar� config.ru e intentar� iniciar nuestra aplicaci�n en funci�n de la informaci�n de all�. 

Abre una nueva pesta�a del navegador web, con la url:localhost:3000 y verifica que puedas ver "Hola mundo".



Ahora debes tener los siguientes archivos bajo control de versiones: Gemfile, Gemfile.lock, app.rb, config.ru. Esta es una aplicaci�n SaaS m�nima: el archivo de la aplicaci�n en s�, la lista de gemas requeridas expl�citamente, la lista de gemas reales instaladas (Gemfile.lock), incluidas las dependencias implicadas por las gemas requeridas, y un archivo de configuraci�n que le dice al servidor de aplicaciones (rack) c�mo iniciar la aplicaci�n.

Modificar la aplicaci�n

Modifica app.rb para que en lugar de "Hola mundo" imprima "Adios mundo cruel". Guarde los cambios app.rbe intenta actualizar la pesta�a del navegador donde se ejecuta la aplicaci�n.

�Sin cambios? �Confundido?

Ahora regresa a la ventana del shell donde ejecut� rackup y presiona Ctrl-C para detener el Rack. Luego, vuelve a escribir bundle exec rackup -p 3000 -o 127.0.0.1 , y una vez que se est� ejecutando, vuelve a la pesta�a del navegador  y actualiza la p�gina. Esta vez deber�a funcionar.


Lo que esto muestra es que si modificas tu aplicaci�n mientras est� en ejecuci�n, debes reiniciar Rack para que "vea" esos cambios. Ya que el reinicio manual es tedioso, usaremos la gema rerun, que reinicia Rack autom�ticamente cuando ve cambios en los archivos en el directorio de la aplicaci�n. (Rails hace esto por t� de forma predeterminada durante el desarrollo, como veremos, pero Sinatra no).

Probablemente ya est�s pensando: "�Aj�! Si nuestra aplicaci�n depende de esta gema adicional, debemos agregarla al Gemfile y ejecutar el paquete para asegurarnos de que est� realmente presente". Buen pensamiento. Pero tambi�n puede ocurrir que esta gema en particular no sea necesaria en un entorno de producci�n: solo la necesitamos como herramienta mientras desarrollamos. Afortunadamente, hay una forma de decirle a Bundler que algunas gemas solo son necesarias en ciertos entornos. Agrega lo siguiente al Gemfile (no importa d�nde):

group :development do 
  gem 'rerun'
 end

Cualquier especificaci�n de gemas dentro del bloque group :development solo se examinar� si el paquete se ejecuta en el entorno de desarrollo. (Los otros entornos que puede especificar son :test y :production , y puedes definir nuevos entornos ti mismo). Se supone que las especificaciones de gemas fuera de cualquier bloque de grupo se aplican en todos los entornos.

ejecuta: bundle exec rerun -- rackup -p 3000 -o 127.0.0.1 en la ventana del terminal que inicia tsu aplicaci�n y verifica que la aplicaci�n se est� ejecutando. Hay m�s detalles sobre el uso de la repetici�n disponible en GitHub README de la gema . Las gemas generalmente est�n en GitHub y sus README contienen instrucciones �tiles sobre c�mo usarlas.

En este caso, estamos prefijando de nuevo bundle exec para asegurarnos de que estamos usando las gemas en Gemfile.lock, y el s�mbolo -- est� ah� para afirmar que el comando con el que queremos volver a ejecutar es rackup -p 3000 -o 127.0.0.1  . Podr�amos lograr el mismo efecto con: bundle exec rerun "rackup -p 3000 -o 127.0.0.1". Ellos son equivalentes. Lo que es m�s importante, cualquier cambio detectado provocar� que el servidor se reinicie autom�ticamente, de forma similar al uso de guard para volver a ejecutar autom�ticamente las especificaciones (specs) cuando los archivos cambian.


Modifica app.rb para imprimir un mensaje diferente y verifique que el cambio se detecta al volver a ejecutar una vez que actualiza la pesta�a del navegador con la aplicaci�n en ejecuci�n. Adem�s, antes de continuar, debes enviar tus �ltimos cambios a git.


Implementar a Heroku

Heroku es una plataforma  como servicio en nube (PaaS) donde podemos implementar nuestras aplicaciones Sinatra (y posteriormente en Rails) de una manera s�lida. Si todav�a no tienes una cuenta, ve a inscribirse en http://www.heroku.com . Necesitar�s tu nombre de usuario y contrase�a para el siguiente paso.


Instala una interface de comandos (CLI) para Heroku desde: https://devcenter.heroku.com/articles/getting-started-with-nodejs#set-up

Desde la cli que reci�n instalaste, inicia sesi�n en tu cuenta Heroku escribiendo el comando: heroku login. Esto conectar� su espacio de trabajo con tu cuenta Heroku.

Mientras est�s en el directorio ra�z de tu proyecto (no en tu espacio de trabajo completo), escribe: heroku create,  para crear un nuevo proyecto en Heroku. Esto le dir� al servicio de Heroku que se prepare para alg�n c�digo entrante, y localmente, agregar� un repositorio remoto de git para ti llamado: (el nombre es aleatorio).


A continuaci�n, aseg�rate de que preparas (git add .) y confirmas (git commit) todos los cambios a nivel local como se indic� m�s arriba.

Anteriormente vimos que para ejecutar la aplicaci�n localmente se ejecuta rackup para iniciar el servidor de aplicaciones Rack, y Rack consulta config.ru para determinar c�mo iniciar su aplicaci�n Sinatra. �C�mo le dices a un entorno de producci�n la manera de iniciar un servidor de aplicaciones u otros procesos necesarios para recibir solicitudes y comenzar tu aplicaci�n? En el caso de Heroku, esto se hace con un archivo especial llamado "Procfile", que especifica uno o m�s tipos de procesos de Heroku que usar� tu aplicaci�n y c�mo iniciar cada uno. El tipo de proceso m�s b�sico de Heroku se llama: Dyno o "trabajador web".

El Dyno puede atender una solicitud de usuario a la vez. Como estamos en el nivel "gratuito" de Heroku, solo podemos tener un Dyno.
Vamos a crear un archivo con nombre Procfile ( y solo esto como el nombre,es decir, Procfile.txt no es v�lido). Escribe la siguiente l�nea en tu Procfile:

web: bundle exec rackup config.ru -p 3000

Esto le dice a Heroku que inicie un �nico trabajador web (Dyno) usando esencialmente la misma l�nea de comando que utiliz� para iniciar Rack localmente. Ten en cuenta que, en algunos casos, el Procfile no es necesario, ya que Heroku puede inferir de tus archivos c�mo iniciar la aplicaci�n. Sin embargo, siempre es mejor ser expl�cito.

Tu repositorio local ahora est� listo para implementarse en Heroku:

$ git push heroku master

("master" se refiere a qu� rama (branch) del repositorio remoto de Heroku estamos "actualizando" desde nuestro repositorio local. Aprenderemos sobre las ramas m�s adelante en el curso, pero por ahora, basta con decir que solo puedes implementarlo en la rama master en Heroku.) Este push crear� una instancia en ejecuci�n de tu aplicaci�n en alguna URL que termina con "herokuapp.com".
Ingresa esa URL en una nueva pesta�a del navegador para ver tu aplicaci�n ejecut�ndose en vivo. Felicitaciones, lo hiciste: �tu aplicaci�n esta en la web!

Resumen

Comenzaste un nuevo proyecto de aplicaci�n al crear una especificaci�n Gemfile de las "gemas" que necesitas y ejecutaste bundle para verificar que est�n disponibles y crear el Gemfile.lock, archivo que registra las versiones de las gemas realmente en uso.

Creaste una aplicaci�n Sinatra en el archivo app.rb, apuntaste a Rack en el archivo config.ru y usaste rackup para iniciar el servidor de aplicaciones y el servidor web WEBrick.

Aprendiste que cambiar el c�digo de la aplicaci�n no provoca autom�ticamente que Rack vuelva a cargar la aplicaci�n. Para guardar el trabajo de reiniciar la aplicaci�n manualmente cada vez que se realiza un cambio, usaste la gema rerun agreg�ndola al Gemfile de una manera que especifica que no lo necesitar�s en producci�n, solo durante el desarrollo.

Versionaste los archivos importantes que contienen: no solo el c�digo de tu aplicaci�n sino la informaci�n necesaria para reproducir todas las bibliotecas en las que se basa y el archivo que inicia la aplicaci�n.

Has implementado esta sencilla aplicaci�n para Heroku.

Siguiente: Parte 1 - Hangperson