Parte 0: Desmitificar la creación de aplicaciones SaaS

Objetivo: comprender los pasos necesarios para crear, versionar e implementar una aplicación SaaS, incluido el seguimiento de las bibliotecas de las que depende para que sus entornos de producción y desarrollo sean lo más similares posible.


Lo que harás: crea una aplicación sencilla de "hola mundo" utilizando el framework Sinatra, vuélvela a la versión adecuada y despliégala en Heroku.


Crear y versionar una aplicación SaaS simple


Las aplicaciones SaaS se desarrollan en tu computadora (o IDE basado en la nube) pero se implementan en un servidor al que otros pueden acceder. Intentamos minimizar las diferencias entre los entornos de desarrollo y producción , para evitar problemas difíciles de diagnosticar en los que algo funciona de una manera en tu computadora de desarrollo pero de una manera diferente (o nada) cuando ese código se implementa en producción.

Tenemos dos mecanismos para mantener los entornos de desarrollo y producción consistentes. El primero es el control de versiones , como Git, para el código de la aplicación. Pero dado que casi todas las aplicaciones también se basan en bibliotecas escritas por otros, como gemas en el caso de Ruby, necesitamos una forma de realizar un seguimiento de las versiones de las bibliotecas con las que se ha probado nuestra aplicación, para que las mismas se utilicen en desarrollo y producción.

Afortunadamente, Ruby tiene un maravilloso sistema para administrar dependencias de gemas: una gema llamada "Bundler" busca un archivo llamado Gemfile en el directorio raíz de la aplicación de cada proyecto. El Gemfile contiene una lista de gemas y versiones de las que depende tu aplicación. Bundler verifica que esas gemas, y cualquier otra a la que dependan, están instaladas correctamente en tu sistema y accesibles para la aplicación.


Comencemos con los siguientes pasos:


Crea un nuevo directorio vacío para guardar tu nueva aplicación y utilíza:

git init

en ese directorio para comenzar a crear versiones con Git.

En ese directorio, crea un nuevo archivo llamado Gemfile (la capitalización es importante) con los siguientes contenidos. Este archivo será una parte permanente de tu aplicación y se desplazará con tu aplicación a donde quiera que vaya:

1- source 'https://rubygems.org' 
2- ruby '2.3.0'
3-  
4- gem 'sinatra' , '>= 1.4'


La primera línea dice que el lugar preferido para descargar las gemas necesarias es https://rubygems.org , que es donde la comunidad de Ruby registra las gemas de producción.

La segunda línea especifica qué versión del intérprete de lenguaje Ruby se requiere. Si omitimos esta línea, Bundler no intentará verificar qué versión de Ruby está disponible; hay diferencias sutiles entre las versiones, y no todas las gemas funcionan con todas las versiones, por lo que es mejor especificar esto.

La última línea dice que necesitamos la versión 1.4 o posterior de la gema sinatra. En algunos casos, no necesitamos especificar qué versión de una joya (gema) queremos; en este caso, lo especificamos porque dependemos de algunas características que están ausentes de las versiones anteriores de Sinatra.


Ejecutar Bundler


Ejecute el comando bundle, lo que examina Gemfile para asegurarse de que las gemas correctas (y, donde se especifique, las versiones correctas) estén disponibles, e intenta instalarlas de otro modo. Esto creará un nuevo archivo Gemfile.lock, que debes colocar bajo control de versión.

Para colocar bajo control de versión, usa estos comandos:

$ git add . 
$ git commit -m " Configurar el Gemfile "

El primer comando prepara todos los archivos modificados para la confirmación (commit). El segundo comando confirma los archivos preparados con el comentario entre comillas. Puedes repetir estos comandos para confirmar cambios futuros. Recuerda que estos son commits LOCALES - si quieres estos cambios en GitHub, deberás ejecutar un comando "git push", que mostraremos más adelante.

Después de ejecutar bundle, ¿por qué hay gemas enumeradas en las Gemfile.lock que no figuraban Gemfile?

Crea una aplicación SaaS simple con Sinatra

Las aplicaciones SaaS requieren un servidor web para recibir solicitudes HTTP del mundo exterior y un servidor de aplicaciones que "conecta" la lógica de su aplicación con el servidor web. Para el desarrollo, utilizaremos webrick un servidor web basado en Ruby muy simple que sería inapropiado para la producción pero que está bien para el desarrollo. Tanto en desarrollo como en producción, utilizaremos el servidor de aplicaciones rack ( basado en Ruby), y que es compatible con las aplicaciones de Ruby escritas en varios frameworks, incluidos Sinatra y Rails.

Una aplicación SaaS esencialmente reconoce y responde a las solicitudes HTTP correspondientes a las rutas de la aplicación Una ruta consiste en un método HTTP como GET o POST más un URI). Sinatra proporciona una abreviatura extremadamente ligera para hacer coincidir una ruta con el código de la aplicación que se ejecutará cuando llegue una solicitud que utiliza esa ruta desde el servidor web.

Crea un archivo en tu proyecto llamado  app.rb que contenga lo siguiente:

1- require  'sinatra'
2-
3- class  MyApp < Sinatra::Base 
4- get '/'  do 
5-    "<!DOCTYPE html><html><head></head><body><h1>Hola mundo</h1></body></html>"
6- end 
7- end

El método get es proporcionado por la  clase Sinatra::Base , de la cual nuestra clase MyApp hereda; Sinatra::Base está disponible porque cargamos la biblioteca de Sinatra en la línea 1.


Como puedes ver en el ejemplo simple anterior, Sinatra te permite escribir funciones que coinciden con una ruta HTTP entrante, en este caso GET '/'(la URL raíz), un documento HTML muy simple que contiene la cadena "Hola mundo" se devolverá al nivel de presentación (webrick) como resultado de la solicitud.

Para ejecutar nuestra aplicación, debemos iniciar el servidor de aplicaciones y el servidor de nivel de presentación (web). El servidor de aplicaciones "rack" está controlado por un archivo config.ru, que ahora debes crear y agregar al control de versiones, y que contiene lo siguiente:

1- require  './app' 
2- run MyApp

La primera línea le dice a Rack que nuestra aplicación vive en el archivo app.rb, que se creó anteriormente para guardar el código de tu aplicación. Tenemos que declarar explícitamente que nuestro archivo se encuentra en el directorio actual (.) Porque "require" normalmente solo busca en los directorios del sistema estándar para encontrar gemas.

ahora estamos listo para probar nuestra sencilla aplicación con esta línea de comando:

$ bundle exec rackup -p 3000 -o 127.0.0.1


Este comando inicia el servidor de aplicaciones Rack y el servidor web WEBrick. Prefijándolo con bundle exec asegura que está ejecutando con las gemas especificadas en Gemfile.lock. Rack buscará config.ru e intentará iniciar nuestra aplicación en función de la información de allí. 

Abre una nueva pestaña del navegador web, con la url:localhost:3000 y verifica que puedas ver "Hola mundo".



Ahora debes tener los siguientes archivos bajo control de versiones: Gemfile, Gemfile.lock, app.rb, config.ru. Esta es una aplicación SaaS mínima: el archivo de la aplicación en sí, la lista de gemas requeridas explícitamente, la lista de gemas reales instaladas (Gemfile.lock), incluidas las dependencias implicadas por las gemas requeridas, y un archivo de configuración que le dice al servidor de aplicaciones (rack) cómo iniciar la aplicación.

Modificar la aplicación

Modifica app.rb para que en lugar de "Hola mundo" imprima "Adios mundo cruel". Guarde los cambios app.rbe intenta actualizar la pestaña del navegador donde se ejecuta la aplicación.

¿Sin cambios? ¿Confundido?

Ahora regresa a la ventana del shell donde ejecutó rackup y presiona Ctrl-C para detener el Rack. Luego, vuelve a escribir bundle exec rackup -p 3000 -o 127.0.0.1 , y una vez que se esté ejecutando, vuelve a la pestaña del navegador  y actualiza la página. Esta vez debería funcionar.


Lo que esto muestra es que si modificas tu aplicación mientras está en ejecución, debes reiniciar Rack para que "vea" esos cambios. Ya que el reinicio manual es tedioso, usaremos la gema rerun, que reinicia Rack automáticamente cuando ve cambios en los archivos en el directorio de la aplicación. (Rails hace esto por tí de forma predeterminada durante el desarrollo, como veremos, pero Sinatra no).

Probablemente ya estés pensando: "¡Ajá! Si nuestra aplicación depende de esta gema adicional, debemos agregarla al Gemfile y ejecutar el paquete para asegurarnos de que esté realmente presente". Buen pensamiento. Pero también puede ocurrir que esta gema en particular no sea necesaria en un entorno de producción: solo la necesitamos como herramienta mientras desarrollamos. Afortunadamente, hay una forma de decirle a Bundler que algunas gemas solo son necesarias en ciertos entornos. Agrega lo siguiente al Gemfile (no importa dónde):

group :development do 
  gem 'rerun'
 end

Cualquier especificación de gemas dentro del bloque group :development solo se examinará si el paquete se ejecuta en el entorno de desarrollo. (Los otros entornos que puede especificar son :test y :production , y puedes definir nuevos entornos ti mismo). Se supone que las especificaciones de gemas fuera de cualquier bloque de grupo se aplican en todos los entornos.

ejecuta: bundle exec rerun -- rackup -p 3000 -o 127.0.0.1 en la ventana del terminal que inicia tsu aplicación y verifica que la aplicación se está ejecutando. Hay más detalles sobre el uso de la repetición disponible en GitHub README de la gema . Las gemas generalmente están en GitHub y sus README contienen instrucciones útiles sobre cómo usarlas.

En este caso, estamos prefijando de nuevo bundle exec para asegurarnos de que estamos usando las gemas en Gemfile.lock, y el símbolo -- está ahí para afirmar que el comando con el que queremos volver a ejecutar es rackup -p 3000 -o 127.0.0.1  . Podríamos lograr el mismo efecto con: bundle exec rerun "rackup -p 3000 -o 127.0.0.1". Ellos son equivalentes. Lo que es más importante, cualquier cambio detectado provocará que el servidor se reinicie automáticamente, de forma similar al uso de guard para volver a ejecutar automáticamente las especificaciones (specs) cuando los archivos cambian.


Modifica app.rb para imprimir un mensaje diferente y verifique que el cambio se detecta al volver a ejecutar una vez que actualiza la pestaña del navegador con la aplicación en ejecución. Además, antes de continuar, debes enviar tus últimos cambios a git.


Implementar a Heroku
Heroku es una plataforma en nube como servicio (PaaS) donde podemos implementar nuestras aplicaciones Sinatra (y posteriores Rails) de una manera más sólida que a través de Cloud9. Si todavía no tienes una cuenta, ve a inscribirse en http://www.heroku.com . Necesitará su nombre de usuario y contraseña para el siguiente paso.

Si usa Cloud9, actualice su instalación de Heroku Toolbelt escribiendo el siguiente comando:

$ wget -O- https://toolbelt.heroku.com/install-ubuntu.sh | sh
Inicie sesión en su cuenta Heroku escribiendo el comando: heroku loginen la terminal Cloud9. Esto conectará su espacio de trabajo Cloud9 con su cuenta Heroku.

Mientras estés en el directorio raíz de tu proyecto (no en tu espacio de trabajo completo), escribe heroku createpara crear un nuevo proyecto en Heroku. Esto le dirá al servicio de Heroku que se prepare para algún código entrante, y localmente en Cloud9, agregará un repositorio remoto de git para su llamada heroku.

A continuación, asegúrese de que el escenario y confirmar todos los cambios a nivel local como se indica más arriba (es decir git add, git commit, etc).

Anteriormente vimos que para ejecutar la aplicación localmente se ejecuta rackuppara iniciar el servidor de aplicaciones Rack, y Rack observa config.rupara determinar cómo iniciar su aplicación Sinatra. ¿Cómo le dice a un entorno de producción cómo iniciar un servidor de aplicaciones u otros procesos necesarios para recibir solicitudes y comenzar su aplicación? En el caso de Heroku, esto se hace con un archivo especial llamado Procfile, que especifica uno o más tipos de procesos de Heroku que usará tu aplicación y cómo iniciar cada uno. El tipo de proceso más básico de Heroku se llama Dyno o "trabajador web". One Dyno puede atender una solicitud de usuario a la vez. Como estamos en el nivel libre de Heroku, solo podemos tener un Dyno. Vamos a crear un archivo con nombre Procfile, y solo esto como el nombre (es decir, Procfile.txt no es válido). Escriba la siguiente línea en su Procfile:

web: bundle exec rackup config.ru -p $PORT
Esto le dice a Heroku que inicie un único trabajador web (Dyno) usando esencialmente la misma línea de comando que utilizó para iniciar Rack localmente. Tenga en cuenta que, en algunos casos, a Procfileno es necesario, ya que Heroku puede inferir de sus archivos cómo iniciar la aplicación. Sin embargo, siempre es mejor ser explícito.

Su repositorio local de Cloud9 ahora está listo para implementarse en Heroku:

$ git push heroku master
(se masterrefiere a qué rama del repositorio remoto de Heroku estamos impulsando. Aprenderemos sobre las ramas más adelante en el curso, pero por ahora, basta con decir que solo puedes implementarlo en la masterrama en Heroku.) Este impulso creará una instancia en ejecución de su aplicación en alguna URL que termina con herokuapp.com. Ingrese esa URL en una nueva pestaña del navegador (no en el IDE de Cloud9) para ver su aplicación ejecutándose en vivo. Felicitaciones, lo hiciste: ¡tu aplicación es en vivo!

Resumen
Comenzó un nuevo proyecto de aplicación al crear una Gemfileespecificación de las gemas que necesita y ejecutar bundlepara verificar que estén disponibles y crear el Gemfile.lockarchivo que registra las versiones de las gemas realmente en uso.

Creó una aplicación Sinatra en el archivo app.rb, apuntó a Rack en este archivo config.ruy se usó rackuppara iniciar el servidor de aplicaciones y el servidor web WEBrick.

Aprendió que cambiar el código de la aplicación no provoca automáticamente que Rack vuelva a cargar la aplicación. Para guardar el trabajo de reiniciar la aplicación manualmente cada vez que realiza un cambio, usó la rerungema, agregándola al Gemfile de una manera que especifica que no lo necesitará en producción, solo durante el desarrollo.

Usted versionó los archivos importantes que contienen no solo el código de su aplicación sino la información necesaria para reproducir todas las bibliotecas en las que se basa y el archivo que inicia la aplicación.

Has implementado esta sencilla aplicación para Heroku.

Siguiente: Parte 1 - Hangperson