# HACKING BÁSICO
## Índice
<ol>
    <li> <a href="https://github.com/BySocram/hacking/blob/main/README.md#material-de-apoyo"> Material de apoyo </a> </li>
    <li> <a href="https://github.com/BySocram/hacking/blob/main/README.md#conceptos-b%C3%A1sicos"> Conceptos Básicos </a> </li>
    <li> <a href="https://github.com/BySocram/hacking/blob/main/README.md#pentesting"> Pentesting </a> </li>
</ol>

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
<a href="https://www.redeszone.net/tutoriales/configuracion-puertos/nmap-escanear-puertos-comandos/"> Nmap: Manual de uso </a> <br>
<a href="https://protegermipc.net/2018/11/07/tutorial-y-listado-de-comandos-mas-utiles-para-nmap/"> Tutorial y listado de comandos útiles para nmap </a> <br>
<a href="https://esgeeks.com/como-usar-nmap-con-comandos/#:~:text=Nmap%20es%20una%20utilidad%20muy,puerto%20correspondiente%20(detecci%C3%B3n%20de%20servicios)"> Como usar nmap para principiantes </a> <br>
<a href="https://www.hostinger.es/tutoriales/bash-script-linux/"> Guía de scripting en Bash </a> <br>
<a href="https://programmerclick.com/article/27511173495/"> Script de shell para ver el uso de IP del segmento de red </a> <br>

## Conceptos Básicos
### Permisos
    drwxr-xr-x marcos marcos 4.0 KB Mon Dec 26 23:45:52 2022 marcos

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
Para ver las capabilities que hayan definidas a nivel de sistema utilizamos el siguiente comando:
```
getcap -r / 2>/dev/null
```
Cuando estemos dentro de un equipo y asignemos una capabilite podemos asignar distintos tipos para que a la hora de entrar de nuevo al equipo no tenr <br>
que explotar la misma vulnerabilidad y entrar mas seguramente. Estas pasan desapercibidas ya que no tienen permisos SUID.<br>
En el siguiente enlace podemos ver una web donde muestra distintos tipos de capabilities que podemos crear para luego explotarlas y entrar facilmente:
<a href="https://gtfobins.github.io/#+capabilities"> GTFOBins: Capabilities </a> <br>
Para definir una capabilitie se usa el siguiente comando:
```
setcap cap_setuid+ep /usr/bin/<capabilitie>
```
Para remover una capabilitie se usa el siguiente comando:
```
setcap -r /usr/bin/<capabilitie>
```
## Pentesting
### Fase de Reconocimiento
Usaremos la herramienta nmap para esta fase.<br>
```
nmap -p- --open -sS --min-rate 5000 -vvv -n -Pn 192.168.0.1 -oG allPorts
```
**-p-** -> Indica que queremos escanear todos los puertos <br>
**--open** -> Indica que queremos escanear los puertos abiertos<br>
**-sS** -> Modo de escaneo para que vaya rápido y sigiloso, ya que no concluye la conexión(SYN -> [RST (cerrado) | SYN/ACK -> ACK])<br>
**--min-rate 5000** -> Para indicar que no queremos paquetes mas lentos a 5000 pqtes/s <br>
**-vvv** -> Para que los puertos que vaya detectando los vaya poniendo por consola <br>
**-n** -> Indica que no queremos que nos aplique la resolución DNS <br>
**-Pn** -> Para que no aplique host discovery. Que no aplique descubrimiento de hosts a través del ARP <br>
**192.168.0.1** -> IP de la cual queremos sacar los puertos<br>
**-oG allPorts** -> Indicamos que queremos que nos lo exporte en formato grepeable al archivo allPorts <br>
<br>
Ahora con el siguiente comando nos extrae la ip y los puertos de esta.
```
extractPorts allPorts
```
Los puertos se nos copiarán automáticamente en la clipboard.<br>
<br>
Ahora lanzamos un comando para detectar la versión y servicio que corren los puertos. <br>
```
nmap -sC -sV -p22,80,201 192.168.0.1 -oN targeted
```
**-sC** -> Para lanzar unos scripts defaults <br>
**-sV** -> Para sondear el servicio y versión del puerto <br>
**-oN targeted** -> Para exportarlo a el archivo targeted en formato nmap <br>
<br>
Ahora realizamos un reconocimiento superficial con la herramienta whatweb: <br>
```
whatweb http://<dirección-ip>
```
Podemos complementar el whatweb con el plugin del navegador wappalyzer, que también hace un reconocimiento superficial. <br>
<br>
Ahora crearemos nuestra propia herramienta en bash para extraer los puertos y hacer de esta mandera menos ruido. <br>
```
touch portScan.sh
nano portScan.sh
```
Copiaremos el siguiente código dentro de portScan.sh <br>
```
#!/bin/bash

# ./portScan.sh <ip-adress>

if [ $1 ]; then

  ip_adress=$1

  for port in $(seq 1 65535); do

    timeout 1 bash -c "echo '' > /dev/tcp/$ip_adress/$port" 2>/dev/null && echo "[*] Port $port - Open" &

  done; wait

else

  echo -e "\n[*] Uso: ./portScan.sh <ip-adress>\n"
  exit 1

fi
```
La forma de usar este código es ejecutarlo sobre la ip que queremos extraer los puertos
```
./portScan <ip-adress>
```
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  

  
  
