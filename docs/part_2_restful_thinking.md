PARTE 2: Pensamiento RESTful para HangPerson

Nota: La Parte 2 es solo información de lectura / antecedentes para la Parte 3.

OBJETIVOS: comprender cómo exponer los comportamientos de su aplicación como acciones RESTful en un entorno SaaS, y cómo preservar el estado del juego en solicitudes HTTP (no preserva estado) a su aplicación utilizando la abstracción proporcionada por el servidor de aplicaciones para las "cookies".

LO QUE HARÁS: crea una aplicación Sinatra que haga uso de la lógica HangpersonGame desarrollada en la parte anterior, que te permite jugar Hangperson a través de un navegador.

ESTADO DEL JUEGO

A diferencia de una aplicación retráctil, SaaS se ejecuta sobre el protocolo HTTP sin estado, con cada solicitud HTTP que hace que algo suceda en la aplicación. Y como HTTP es sin estado, debemos pensar cuidadosamente sobre las siguientes 2 preguntas:

1. ¿Cuál es el estado total necesario para que la siguiente solicitud HTTP recoja el juego donde quedó la solicitud anterior?

2. ¿Cuáles son las diferentes acciones del juego, y cómo deberían las solicitudes HTTP mapear esas acciones?

El mecanismo ampliamente utilizado para mantener el estado entre un navegador y un servidor SaaS es una "cookie" . El servidor puede poner lo que quiera en la cookie (hasta un límite de longitud de 4K bytes); el navegador promete devolver la cookie al servidor en cada solicitud posterior. Dado que el navegador de cada usuario obtiene su propia cookie, la cookie se puede utilizar efectivamente para mantener el estado por usuario.

En la mayoría de las aplicaciones de SaaS, la cantidad de información asociada con la sesión de un usuario es demasiado grande para caber en los 4KB permitidos en una cookie, de modo que como veremos en Rails, la información de la cookie se usa más a menudo para mantener un puntero que indique el "estado" que vive en una base de datos. Pero para este simple ejemplo, el estado del juego es lo suficientemente pequeño como para poder guardarlo directamente en la cookie de sesión.



En una arquitectura orientada a servicios, no exponemos el estado interno directamente; en su lugar, exponemos un conjunto de solicitudes HTTP que muestran o realizan alguna operación en un recurso subyacente hipotético . La parte más delicada e importante del diseño RESTful es modelar cuáles son sus recursos y qué operaciones son posibles para ellos.

En nuestro caso, podemos pensar en el juego como el recurso subyacente. Al hacerlo, se obtienen algunas decisiones de diseño importantes sobre cómo las rutas (URL) se asignarán a las acciones y al código del juego en sí.

Como ya hemos identificado el estado del juego y las acciones del jugador que podrían cambiarlo, tiene sentido definir el juego como una clase. Una instancia de esa clase es un juego, y representa el recurso que está siendo manipulado por nuestra aplicación SaaS.

ASIGNACIÓN DE RUTAS DE RECURSOS A SOLICITUDES HTTP

Nuestra lista inicial de operaciones en el recurso podría verse así, donde también hemos dado un nombre sugerente a cada acción:

create: Crea un nuevo juego
show: Muestra el estado del juego actual
guess: Adivina una letra



HTTP es un protocolo de solicitud y respuesta y el navegador web es fundamentalmente una interfaz de usuario de solicitud y respuesta, por lo que cada acción del usuario debe provocar que el navegador muestre algo. Para la acción "mostrar el estado del juego actual", está bastante claro que lo que deberíamos mostrar es la representación HTML del juego actual, como lo hace el método word_with_guesses  de nuestra clase de juego. (En una implementación más elegante, nos ocuparíamos de dibujar una imagen de parte de la "persona ahorcada").

Pero cuando el jugador adivina una letra, ya sea que la suposición sea correcta o no, ¿cuál debería ser la "representación en HTML" del resultado de esa acción?

Respondiendo a esta pregunta es donde falla el diseño de muchas aplicaciones web.

En términos de juego, lo que probablemente tenga más sentido es que, después de que el jugador haga su adivinanza, se muestre el nuevo "estado del juego", resultante de la adivinanza. Pero ya tenemos una acción RESTful para mostrar el estado del juego (show). Así que podríamos usar una "redirección HTTP" para hacer uso de esa acción.

Esta es una distinción importante, porque un redireccionamiento HTTP desencadena una solicitud HTTP completamente nueva. Dado que la nueva solicitud no "sabe" qué letra fue adivinada, toda la responsabilidad de cambiar el estado del juego está asociada con la acción RESTful de adivinar una letra (guess), y toda la responsabilidad de mostrar el estado actual del juego (sin cambiarlo) está asociado con la acción de visualizarlo (show) . Esto es bastante diferente de un escenario en el que la acción de adivinar una letra también muestra el estado del juego, porque en ese caso, la acción de visualización del juego tendría acceso a la letra que se adivinaba. Un buen diseño RESTful mantendrá estas responsabilidades separadas, de modo que cada acción RESTful haga exactamente una cosa.

Un argumento similar se aplica a la acción de crear un nuevo juego. La responsabilidad de crear un nuevo objeto de juego recae en esa acción (create); pero una vez que se crea el nuevo objeto del juego, ya tenemos una acción para mostrar el estado actual del juego (show).

Entonces, podemos comenzar a mapear nuestras acciones RESTful en términos de solicitudes HTTP de la siguiente manera, usando algunos URI simples para las rutas:
<table>
<thead>
<tr>
<th> RUTA Y ACCIÓN </th><th>  OPERACIÓN EN EL  RECURSO</th> <th>  RESULTADO EN WEB</th>
</tr>
</thead>
<tbody>

<tr><td> <code>GET /show</code>      </td><td>   mostrar el estado del juego      </td><td>  mostrar aciertos y desaciertos hasta el momento</td></tr>
<tr><td> <code>POST /guess</code>    </td><td>   actualizar el estado del juego </td><td> redirigir a <code>show</code></td></tr>
<tr><td> <code>POST /create</code>   </td><td>   crear nuevo juego      </td><td>  redirigir a <code>show</code></td></tr>
</tbody>
</table>



En una verdadera arquitectura orientada a servicios, estaríamos casi listos. Pero un sitio visitdo a a través de un navegador web no es precisamente una verdadera "arquitectura orientada a servicios".

¿Por qué? Porque un usuario web humano necesita una forma de colocar (POST) un formulario. Un GET (visitar la página) puede lograrse simplemente escribiendo una URL en la barra de direcciones del navegador, pero el POST solo puede ocurrir cuando el usuario envía un formulario HTML (o, como veremos más adelante, cuando el código AJAX en JavaScript desencadena una acción HTTP).

Por lo tanto, para comenzar un juego nuevo, debemos proporcionar al usuario una forma de publicar el formulario que activará la acción: POST /create . Puedes pensar en el recurso en cuestión como "la oportunidad de crear un nuevo juego". Entonces podemos agregar otra fila a nuestra tabla de rutas:

RUTA Y ACCIÓN	| OPERACIÓN DE RECURSOS	       | RESULTADO WEB
GET /new      |	darle al usuario humano la oportunidad de comenzar un nuevo juego	| mostrar un formulario que incluye un botón "iniciar nuevo juego"

Del mismo modo, ¿cómo  el usuario humano genera POST para adivinar una nueva letra? Como ya tenemos una acción para mostrar el estado del juego actual (show), sería fácil incluir en la misma página HTML un formulario de "adivinar una letra" que, cuando se envía, genera la acción: POST /guess .

Veremos este patrón reflejado más adelante en Rails: un recurso típico (como la información sobre un jugador) tendrá operaciones create y update , pero para permitir que un ser humano proporcione los datos utilizados para crear o actualizar un registro de jugador, tendremos que proporcionar acciones new y edit  respectivamente que permitan al usuario ingresar la información en un formulario HTML.



Por último, cuando el juego termine (ya sea ganar o perder), no deberíamos aceptar más adivinanzas. Dado que estamos planificando que nuestra página show  incluya una forma de adivinar letras, quizás deberíamos tener un tipo diferente de acción show  cuando el juego haya finalizado, uno que no incluya una manera para que el jugador adivine otra letra, pero ( quizás) incluya un botón para comenzar un nuevo juego. Incluso podemos tener páginas separadas para ganar y perder, que den al jugador la oportunidad de comenzar un nuevo juego. Dado que la acción show  ciertamente puede decir si el juego ha terminado, puede redirigir condicionalmente a la acción win o lose cuando se llame.

Las rutas para cada una de las acciones RESTful en el juego, basadas en la descripción de lo que la ruta debería hacer:


Mostrar estado del juego, permitir que el jugador ingrese adivinar; puede redirigir a Win o Lose:	GET / show

Mostrar formulario que puede generar "POST /create":GET / new

Empieza un juego nuevo; redirige a Show luego de cambiar el estado de juego:	POST / create

Adivinar el proceso; redirige a Show luego de cambiar el estado:	POST / guess

Mostrar la página "win" con el botón para iniciar un juego nuevo:	GET / win

Mostrar la página "lose" con el botón para iniciar un juego nuevo:	GET / lose

RESUMEN DEL DISEÑO

Puede que te moleste no escribir ningún código todavía, pero has terminado la tarea más difícil e importante: definir los recursos básicos de la aplicación y cómo las rutas RESTful los asignarán a las acciones en una aplicación SaaS. Para resumir:

Ya tenemos una clase para encapsular el juego en sí, con variables de instancia que capturan el estado esencial del juego y los métodos de instancia que operan en él cuando el jugador hace una adivinanza. En el paradigma modelo-vista-controlador (MVC), este será  nuestro "modelo".

Usando Sinatra, facilitaremos las  operaciones sobre el modelo a través de solicitudes HTTP RESTful. En MVC, este será nuestro "controlador".

Crearemos vistas y formularios en HTML para representar el estado del juego, para permitir la adivinanza, para permitir el inicio de un nuevo juego y para mostrar un mensaje cuando el jugador gane o pierda. En MVC, estas serán nuestras "vistas".

Ten en cuenta que Sinatra no impone MVC o cualquier otro "patrón de diseño", en realidad , está más cerca del "patrón de controlador de páginas", donde hacemos coincidir explícitamente cada solicitud RESTful con una vista HTML, pero es un framework bastante simple que puede usarse para implementar MVC en esta aplicación ya que solo tenemos un modelo. Como veremos más adelante, los frameworks más poderosos basados ​​en MVC como Rails son mucho más productivos para crear aplicaciones que tienen muchos tipos de modelos.

Siguiente: Parte 3 - Conectando Hangperson a Sinatra
