# HACKING BÁSICO
## Material de apoyo:
### Repositorios
<a href="https://gtfobins.github.io/"> GTFObins </a>

### Información
<a href="https://culturacion.com/como-crear-cuentas-de-usuario-en-linux/">  Guía de creación de usuarios en linux </a> <br>
<a href="https://www.pedroventura.com/linux/administracion-de-usuarios-en-linux-crear-borrar-modificar-usuarios-y-grupos/"> Administración de usuarios en linux </a> <br>
<a href="https://blog.desdelinux.net/permisos-basicos-en-gnulinux-con-chmod/"> Permisos básicos en GNU/Linux con chmod </a> <br>
<a href="https://blog.desdelinux.net/permisos-y-derechos-en-linux/"> Permisos y derechos en Linux </a> <br>
<a href="https://mural.uv.es/oshuso/8339_permisos_y_atributos.html"> Permisos y atributos </a> <br>
<a href="https://www.ochobitshacenunbyte.com/2019/06/17/permisos-especiales-en-linux-sticky-bit-suid-y-sgid/"> Permisos especiales en Linux: Sticky Bit, SUID y SGID </a> <br>
<a href="https://www.ibiblio.org/pub/Linux/docs/LuCaS/Manuales-LuCAS/doc-curso-salamanca-admin-avanzada/html/ch08s06.html"> El permiso SUID </a> <br>
<a href="https://www.redeszone.net/tutoriales/servidores/cron-crontab-linux-programar-tareas/"> Como utilizar Cron y Crontab en Linux </a> <br>
<a href="https://man7.org/linux/man-pages/man7/capabilities.7.html"> Capabilites - Linux manual page </a> <br>
<a href="https://www.incibe-cert.es/blog/linux-capabilities"> Linux kernel capabilities - No solo de sudo vive root </a> <br>
<a href="https://deephacking.tech/path-hijacking-y-library-hijacking/"> Path Hijaking y Library Hijacking </a> <br>

## Conceptos Básicos
### Permisos
    drwxr-xr-x marcos marcos 4.0 KB Mon Dec 26 23:45:52 2022  marcos

  d = type: directory

  rwx r-x r-x <br>
  u&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;g&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;o <br>
  111 101 101 <br>
<br>
  rwx = 111 = 7<br>
  rw- = 110 = 6<br>
  r-x = 101 = 5<br>
  r-- = 100 = 4<br>
  -wx = 011 = 3<br>
  -w- = 010 = 2<br>
  --x = 001 = 1<br>
<br>
  u = owner<br>
  g = group<br>
  o = others<br>
<br>
  r = read permision<br>
  w = write permision<br>
  x = execution permision<br>
  
### Permisos SUID
  El permiso SUID permite a un usuario ejecutar programas con los privilegios del root <br>
  Por ejemplo: EL comando passwd necesita acceder a los ficheros /etc/passwd en modo escritura, <br>
  y solo root puede hacerlo.
  <br>
  Se asignan usando el sigiente comando: <br>
  ```
  chmod 4755 <programa>
  ```
  Estaremos asignando lor privilegios 755 más el privilegio 4 o SUID <br>

### Tarea Cron
  Tarea que se ejecuta a nivel de sistema, a nivel regulares de tiempo.
  ```
  cd /etc/cron.d
  echo "* * * * * root /home/user/file.sh" > tareaCron
  ```
  En este comando nos dirijimos al directorio que se situa en /etc/cron.d donde crearemos nuestra tarea cron. <br>
  Los cinco asteriscos significan que queremos que la tarea se ejecute cada minuto, root significa el usuario que queremos <br>
  que la ejectue y por último tenemos la ruta /home/user/file.sh que es donde está el script en bash que ejecutara la tareaCron. <br>
  
  ### Explotación del PATH Hijaking
  Es una técnica de escalada de privilegios, con la cuál se utiliza el PATH que es una variable que almacena las rutas de los programas <br>
  hasta que encuentra la ruta del programa que hemos ejecutado. <br>
  <br>
  Un ejemplo de Path Hijaking sería el siguiente: <br>

  1. Creamos un programa en c que en este caso llamaremos app.c <br>
  ```
  touch app.c
  nano app.c
  ```
  2. Insertamos el siguiente código.<br>
     Este código saca las 10 primeras lineas del archivo passwd dos veces, la primera vez<br>
     lo hace usando la ruta absoluta del archivo y la seguna vez usando la relativa.
  ```
  #include <studio.sh>
  
  void main(){
  
    setuid(0);
    
    print("\n\n[*] Enseñando las 10 primeras lineas del archivo /etc/passwd usando /usr/bin/head \n\n");
    system("/usr/bin/head /etc/passwd");
    
    print("\n\n[*] Enseñando las 10 primeras lineas del archivo /etc/passwd usando head \n\n");
    system("/etc/passwd");
  
  }
  ```
  3. Compilamos el archivo app.c
  ```
  gcc app.c -o app
  ```
  4. Si le asignamos al programa compilado app el permiso SUID, al ejecutar el binario lo estaremos<br>
  haciendo como el usuario root. De esta forma se podría llevar a cabo el Path Hijacking, y haciendo un <br>
  del binario podríamos identificar que se esta llamando al archivo de forma relativa.
  ```
  chmod 4755 app
  strings app
  ```
  Podemos fijarnos que la respuesta del string nos dice que se esta usando setuid en el código, <br>
  lo que significa que se ejecutará con el usuario UID.<br> <br>
  
  5. Ahora que ya sabemos que se está ejecutando con el usuario UID, vamos a cambiar el PATH añadiendo la <br>
  ruta actual en la cuál vamos a crear un archivo con el nombre del programa que queremos suplantar, en este <br>
  caso el head.
  ```
  export PATH=.:$PATH
  echo "bash -p" > head
  ```
  Lo que hacemos con el primer comando es añadir como primera ruta para buscar los programas el directorio actual <br> (es temporal), después creamos un archivo para suplantar ese programa y que lo detecte el cual contiene un <br>
  comando para entrar como root.
  De esta manera al ejecutar el binario app con permisoso SUID ejecutará el comando head, el PATH buscará en orden <br> el programa en nuestro directorio actual, y ejecutará el código que hemos metido entrando al sistema como root.

### Abuso y explotación de las capabilities
En el caso de que ya se haya comprometido un equipo y hayamos dejado una una persistencia privilegiada, en este caso utilizaremos las capabilities.<br>

  
  
  
  
  
  
  
  
  