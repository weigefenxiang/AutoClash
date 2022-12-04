#!/usr/sbin
/usr/sbin/iptables -t mangle -F  && iptables -t mangle -X 
/usr/sbin/iptables -t nat    -F  && iptables -t nat -X  

/usr/sbin/ip rule add fwmark 0x1 table 100
/usr/sbin/ip route add local 0.0.0.0/0 dev lo table 100
/usr/sbin/iptables-restore /etc/iptables.rules
