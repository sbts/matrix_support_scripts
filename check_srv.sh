#!/bin/bash

URL="${1:-matrix.mozboz.com}"

#_service._proto.name. TTL class SRV priority weight port target.

#_matrix._tcp.matrix.org. 600	IN	SRV	10 5 8448 matrix.org.
#_matrix._tcp.matrix.mozboz.com.	1800 IN	SRV	0 0 443 matrix.mozboz.com.
#_service._proto.name. TTL class SRV priority weight port target.

read -t10 r_srv r_ttl r_j1 r_class r_pri r_weight r_port r_tgt < <(dig -t srv _matrix._tcp.matrix.org | grep '^_matrix';)

read -t10 u_srv u_ttl u_j1 u_class u_pri u_weight u_port u_tgt < <(dig -t srv _matrix._tcp.matrix.mozboz.com  | grep '^_matrix';)

#read -t10 r_srv r_ttl r_j1 r_j2 r_class r_pri r_weight r_port r_tgt < <(echo "a b c d e f g h i";)

#read -t10 u_srv u_ttl u_j1 u_j2 u_class u_pri u_weight u_port u_tgt < <(echo ". . . . . . . . . . . x";)

printf " ============================================================================================================\n"
printf "| Service                                 |   TTL  | Priority | Weight |  Port  | Target                     |\n"
printf " ============================================================================================================\n"
printf "| %-39s | %6s | %8s | %6s | %5s  | %-26s |\n" "$r_srv" "$r_ttl" "$r_pri" "$r_weight" "$r_port" "$r_tgt"
printf "| %-39s | %6s | %8s | %6s | %5s  | %-26s |\n" "$u_srv" "$u_ttl" "$u_pri" "$u_weight" "$u_port" "$u_tgt"
printf " ============================================================================================================\n"
