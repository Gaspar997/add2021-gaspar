# Recursos compartidos SMB-CIFS
### 1.Preparativos y crear usuarios
- Creamos un servidor GNU/Linux y lo configuramos.
- Nombre del servidor `server25g`.
- En el fichero `/etc/host` añadir los equipos `cliente25g` y `cliente25w` con la ip asignada.
- Luego crearemos los grupos `piratas`, `soldados` y `sambausers`.
- En el grupo `piratas`, añadimos a `pirata1`, `pirata2` y `supersamba`.
- En el grupo `soldados`, añadimos a `soldado1`, `soldado2` y `supersamba`.
- En el grupo `sambausers`, añadimos a todos los usuarios `soldados`, `piratas`, `supersamba` y `sambaguest`.

### 1.4 Configurar servidor Samba
- Lo primero será abirir `Yast -> Samba Server`:
    - En Workgroup: `curso2021`.
    - Sin controlador de dominio.
    - En la pestaña `Inicio` modificamos lo siguiente:
    - Iniciar durante el arranque.
    - Configuración de cortafuegos -> puerto abierto en el cortafuegos.

![](img/1,4.png)
- Para comprobar el cortafuegos, ejecutar el comando `nmap -Pn 172.19.21.31` desde otra máquina GNU/Linux. Observamos que los puertos SMB/CIFS (139 y 445) están abiertos.

![](img/05.png)

### 1.5 Crear los recursos compartidos de red
Para configurar los recursos compartidos de red en el servidor lo haremos modificando directamente el fichero de configuración: `/etc/samba/smb.conf`.
- Configurar las secciones `global`, `public`, `barco` y `castillo` de la siguiente manera:

![](img/06.png)
![](img/07.png)

- Ejecutar el comando `testparm` para verificar si la sintaxis del archivo de configuración es correcta.

![](img/08.png)

### 1.6 Usuario Samba
Después de crear los usuarios en el sistema, hay que añadirlos a samba. Para ello tendremos que ejecutar el comando `smbpasswd -a USUARIO` para cada uno de los usuarios que queramos añadir.
Para comprobar la lista de usuarios bastará con ejecutar el comando `pdbedit -L`.

![](img/09.png)

### 1.7 Reiniciar
- Ahora que hemos configurado el servidor samba hay que recargar los ficheros de configuración. Para ello reiniciaremos los servicios `smb` y `nmb`.
- Con el comando `lsof -i` comprobamos que elservicio SMB/CIFS está a la escucha.

![](img/10.png)

---
## 2 Windows
Primero tendremos que configurar nuestra máquina Windows. Usaremos el nombre y la IP que hemos establecido en el fichero `/etc/hosts` del servidor.
Una vez configurada la máquina editaremos el fichero `.../etc/hosts` y le introduciremos el nombre y la IP de nuestro servidor.

![](img/11.png)

### 2.1 Cliente Windows GUI
- Si escribimos `\\172.19.21.31` en el explorador de archivos vemos lo siguiente:

![](img/12.png)

- Al acceder al recurso `public`, no nos pide ningún tipo de identificador pero no nos permite realizar ningún cambio.
- Al intentar entrar al recurso `barco` nos pedirá identificarnos. Si ponemos el usuario `pirata1` nos permitirá entrar.

![](img/13.png)

![](img/14.png)
- Para ver las conexiones abiertas ejecutar el comando `net use`.

![](img/15.png)
- Hacer lo mismo con el recurso compartido `castillo` y el usuario `soldado1`.
- Volver al servidor Samba.
- Ejecutar `smbstatus`:

![](img/16.png)
- Ejecutar `lsof -i`:

![](img/17.png)

### 2.2 Cliente Windows comandos
- Con el comando `net view \\172.19.21.31` vemos los recursos compartidos del servidor remoto.

![](img/18.png)
Vamos a montar el recurso `barco` de forma persistente.
- Ejecutar el siguiente comando:

![](img/19.png)
- Ahora podemos entrar en la unidad S: y crear carpetas:

![](img/21.png)
![](img/22.png)

- Volver al servidor Samba
- Ejecutar `smbstatus`:

![](img/20.png)
- Ejecutar `lsof -i`:

![](img/23.png)

---

## 3 Cliente GNU/Linux
### 3.1 Cliente GNU/Linux GUI
- Entrar al explorador de archivos de Linux, pulsar `CTRL + L` y escribir `smb://172.19.21.31` para ver todos los recursos compartidos.

![](img/24.png)

- Intentar crea una carpeta en `barco`:

![](img/25.png)
![](img/26.png)
- Intentar crea una carpeta en `castillo`:

![](img/27.png)
![](img/28.png)

- Si intentamos crear una carpeta en `public` vemos que no tenemos permiso, pues es de sólo lectura.

![](img/29.png)

- Volver al servidor Samba
- Ejecutar `smbstatus`:

![](img/30.png)

- Ejecutar `lsof -i`:

![](img/31.png)

### 3.2 Cliente GNU/Linux comandos
- Con el comando `smbcliente --list 172.19.21.31` comprobamos los recursos compartidos del servidor remoto.

![](img/32.png)
- Crear la carpeta local `/mnt/remoto21/castillo`.

![](img/33.png)
- Montamos el recurso compartido en la carpeta que acabamos de crear con el comando `mount -t cifs //172.19.21.31/castillo /mnt/remoto21/castillo -o username=soldado1` y comprobamos que se ha montado correctamente con el comando `df -hT`.

![](img/34.png)
- Probamos a crear un archivo `soldado1.txt` desde el cliente.

![](img/35.png)
- Al comprobarlo desde el servidor vemos que se ha creado correctamente.

![](img/36.png)
- Ejecutar `smbstatus`:

![](img/37.png)
- Ejecutar `lsof -i`:

![](img/38.png)

### 3.3 Montaje automático
- Al reiniciar la máquina y volver a ejecutar el comando `df -hT` vemos que el recurso castillo ya no está montado.

![](img/39.png)
- Para que el montaje sea permanente tendremos que configurar el fichero `/etc/fstab` añadiendo la línea `//172.19.21.31 castillo /mnt/remoto21/castillo cifs username=soldado1,password=soldado1 0 0`.

![](img/41.png)
- Si reiniciamos la máquina y volvemos a ejecutar el comando `df -hT` vemos que ahora sí se queda grabada la configuración.

![](img/40.png)
