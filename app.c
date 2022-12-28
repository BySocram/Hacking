#include <studio.sh>

void main(){

  setuid(0);
  
  print("\n\n[*] Enseñando las 10 primeras lineas del archivo /etc/passwd usando /usr/bin/head \n\n");
  system("/usr/bin/head /etc/passwd");
  
  print("\n\n[*] Enseñando las 10 primeras lineas del archivo /etc/passwd usando head \n\n");
  system("/etc/passwd");

}
