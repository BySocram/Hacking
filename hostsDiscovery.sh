#!/bin/bash

PING() {

touch hostsActive

  for I in {2..255};do

    if ping -c 1 -w 1 192.168.0.$I &>/dev/null;then

      echo -e "\e[1;32m 192.168.0.$I is up \e[0m" >> hostsActive
      echo -e "\e[1;32m 192.168.0.$I is up \e[0m"

    fi

  done

}

PING





