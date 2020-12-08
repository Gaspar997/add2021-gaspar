## Tema 3
# Servidor de impresión en Windows
## 1. Impresora compartida
### 1.1 Rol impresión
* Vamos a necesitar un Windows Server y ademas un windows cliente.
* Nos vamos al server, instalamos en rol/función de servicios de impresión.

![](img/1.PNG)

- Necesitaremos par esta practica la Impresión en Internet.

![](img/2.PNG)

### 1.2 Instalar impresora PDF
* Ahora tendremos que descargar la herramienta `PDFCreator`.

![](img/3.PNG)

* Una vez instalado vamos a configurarlo y nos dirigiremos a `Perfiles -> Guardar`, cuando estemos en este apartado configuraremos el guardado automático y además indicaremos la carpeta de destino para cuando vayamos a imprimir.

![](img/4.PNG)

### 1.3 Probar impresión en local
* Ahora vamos a probar la impresión local, para ello creamos un archivo `imprimir25s-local`.

![](img/5.PNG)

* Imprimimos el documento utilizando `PDFCreator`.

![](img/6.PNG)

* Como podemos observar aparece el archivo, en la ruta que le habiamos indicado en la configuracion.

![](img/7.PNG)

---
## 2. Compartir por red
### 2.1 En el servidor
* Para este paso lo primero será dirigirnos  `Herramientas -> Administrador de impresión -> Impresoras -> PDFCreator -> Compartir` y cambiar el nombre que aparece ahi por `PDFGaspar25`.

![](img/8.PNG)

### 2.2 Comprobar desde el cliente
* Buscar recursos de red en el servidor con `\\192.168.1.100` y seleccionamos la impresora y nos conectamos.

![](img/9.PNG)

* Ahora tendremos que hacer lo mismo que hicimos en local, primero craemos un documento esta vez llamado `imprimir25w-remoto`.

* Imprimimos seleccionando `PDFCreator`.

* Ahora al volver a la carpeta de destino en el servidor vemos que aparece el documento que creamos en el cliete.

![](img/10.PNG)

---
## 3. Acceso Web
### 3.1 Instalar característica Impresión WEB
* Vamos al servidor
- Comprobamos que está instalado el servicio `Impresión de Internet`, que como lo habiamos hecho previamente pues está instalado.

### 3.2 Configurar impresión WEB
* Vamos al cliente.

* Ahora vamos a abrir el navegador y ponemos la URL `http://192.168.1.100/printers`. Aparecerá lo que se muestra a continuación, entraremos con el usuario administrador.

![](img/11.PNG)

* Vamos a `Propiedades` y copiamos el nombre de la red.

![](img/12.PNG)

* Ahora una vez copiado el nombre de la red agregamos una nueva impresora de red, en la opción `seleccionar una impresora` pegamos el nombre de la red.

![](img/13.PNG)

* Ponemos el usuario y la contraseña, usuario administrador.

![](img/14.PNG)

* Una vez hecho esto nos aparecerá un mensaje de que se agrego correctamente.

### 3.3 Comprobar desde el navegador
* Para probar si funciona lo primero será poner la impresora en pausa desde el servidor. Entonces una vez hecho esto crearemos un archivo `imprimir25w-Web`,imprimir y seleccionamos la impresora en `http://192.168.1.100`.

![](img/15.PNG)

- Como la impresora estaba en pausa, no se a impreso el documento, asi que le daremos a reanudar.

![](img/16.PNG)

- Y como vemos una vez reanudado, el archivo nos aparece en la carpeta.

![](img/17.PNG)
