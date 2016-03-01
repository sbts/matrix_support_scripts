#!/bin/bash

URL="${1:-matrix.mozboz.com}"

PORT="${1:-8448}"

if [[ -z $COLUMNS ]]; then export COLUMNS=`tput cols`; fi

if (( COLUMNS < 110 )); then
    clear
    printf "Your terminal is currently $COLUMNS wide.\n"
    printf "This script is designed to work with at least 110 columns available in the terminal\n"
    printf "please increase the width of your terminal before continuing."
    read -n1 -p 'Continue ? [Y/n] ' K
    printf "\n\n"
    if [[ ! yY =~ ${K:-y} ]]; then exit 1; fi
fi

clear
cat <<EOF

You can pass your server domain name and port on the command line like this
$0 matrix.org 8448


EOF

read -e -i "$URL" -p 'Please enter your Home Server URL: ' URL
read -e -i "$PORT" -p 'Please enter your Home Server PORT: ' PORT

#_service._proto.name. TTL class SRV priority weight port target.

read -t10 r_srv r_ttl r_j1 r_class r_pri r_weight r_port r_tgt < <(dig -t srv _matrix._tcp.matrix.org | grep '^_matrix';)

read -t10 u_srv u_ttl u_j1 u_class u_pri u_weight u_port u_tgt < <(dig -t srv _matrix._tcp."$URL"  | grep '^_matrix';)

printf " ============================================================================================================\n"
printf "| Service                                 |   TTL  | Priority | Weight |  Port  | Target                     |\n"
printf " ============================================================================================================\n"
printf "| %-39s | %6s | %8s | %6s | %5s  | %-26s |\n" "$r_srv" "$r_ttl" "$r_pri" "$r_weight" "$r_port" "$r_tgt"
printf "| %-39s | %6s | %8s | %6s | %5s  | %-26s |\n" "$u_srv" "$u_ttl" "$u_pri" "$u_weight" "$u_port" "$u_tgt"
printf " ============================================================================================================\n"


if [[ ! $PORT == $u_port ]]; then
    printf " ============================================================================================================\n"
    printf "| ERROR: Your SRV record has a different port to the one you entered                                         |\n"
    printf " ============================================================================================================\n"
fi

echo