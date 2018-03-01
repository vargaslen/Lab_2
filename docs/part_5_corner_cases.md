
PARTE 5: CASOS DE ESQUINA

Ahora ya deberías estar familiarizado con el ciclo:

Elige un nuevo escenario para trabajar (deberías tener 2/4 trabajando en este punto)
Ejecuta el escenario y mira cómo falla
Desarrolla el código necesario que haga que cada paso del escenario valide bien
Repite hasta que validen bien  todos los pasos.
Usa este proceso para desarrollar el código para las acciones restantes: win y lose. Necesitarás agregar código a la acción show  que verifique si el estado del juego que está a punto de mostrar es en realidad un estado "ganador" (win) o perdedor (lose), y si es así, debes redireccionar a la acción apropiada: /win o /lose . Recuerda que tu modelo de lógica de juego tiene un método para probar si el estado actual del juego es ganar(:win), perder(:lose) o seguir jugando(:play). El escenario: game_over.feature prueba estos comportamientos en tu aplicación SaaS.

Ejcuta "push" a Heroku y asegúrate de que todo siga funcionando. Tómate un descanso y juega algunas rondas del juego "hangperson".

Mientras juegas, ¿qué sucede si agregas directamente en el navegador /win al final de la URL de tu aplicación? Asegúrate de que el jugador no pueda hacer trampa simplemente visitando: GET /win. Considera cómo modificar las acciones para win, lose y show para evitar este comportamiento.

Asegúrate de que todos los escenarios de Cucumber estén en proceso. Una forma abreviada de ejecutar todos ellos es: cucumber features/ , lo cual ejecuta todos los archivos de tipo ".feature"  en el directorio:  features.

Por último, visite la  URL con tu navegador web para asegurar  que tu aplicación se esté ejecutando correctamente en esa dirección.El nombre que Heroku asigna al azar a tu aplicacion,puede ser modificado a uno que te sea más fácil de recordar, pero el prefijo en la dirección URL siempre será: herokuapp.com .

Siguiente: Conclusión
