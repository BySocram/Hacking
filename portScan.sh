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
