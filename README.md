Vigilar archivo web
=================

Un programa que revisa si un archivo en la web ha cambiado y almacena sus diferentes versiones.

El comando se ejecuta asi:

./vigilararchivoweb.sh http://moviles.gobiernoenlinea.gov.co/index.php/recursos/preguntas-frecuentes

./vigilararchivoweb.sh http://moviles.gobiernoenlinea.gov.co/images/joomlart/pdf/condiciones_y_terminos.pdf

Si quiere hacerlo automaticamente pongalo en cron y ejecutelo una vez por hora, la linea es asi:
  0 *  *   *   * /home/ubuntu/vigilararchivoweb/vigilararchivoweb.sh http://moviles.gobiernoenlinea.gov.co/images/joomlart/pdf/condiciones_y_terminos.pdf

Configuracion
================
si quiere que se guarden los archivos en otra carpeta modifique la variable dir:
dir=~/files

Ejemplo
================
En el servidor de acomprar.co esta corriendo el programa para revisar los archivos de gobierno movil y sus resultados se pueden ver en http://www.acomprar.co/gobiernomovil/
