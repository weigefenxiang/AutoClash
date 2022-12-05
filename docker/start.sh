#!/usr/bin/env bash
# iptables-restore /etc/iptables.rules 路由规则
# 添加标记路由
ip rule show |grep "fwmark 0x1 lookup 100"| grep -v grep &>/dev/null
if [ $? != 0 ]; then
	ip rule add fwmark 0x1 table 100
fi
	
ip route add local 0.0.0.0/0 dev lo table 100

# 重置 iptables
#iptables -t mangle -F  && iptables -t mangle -X 
#iptables -t nat    -F  && iptables -t nat -X  

#iptables -t mangle -L  
#iptables -t nat -L  
iptables -t mangle -N P_MARK                                   #新建表
iptables -t mangle -A P_MARK -d 127.0.0.1 -j RETURN
iptables -t mangle -A P_MARK -d 192.168.0.0/16 -j RETURN    #放行局域网数据
iptables -t mangle -A P_MARK -d 255.255.255.255 -j RETURN   #放行广播数据包
# iptables -t mangle -A P_MARK -m owner --uid-owner clash -j RETURN   #放行clash发出的数据
iptables -t mangle -A P_MARK -p udp -j MARK --set-mark 0x1    #标记并重路由

# TCP转发
iptables -t nat -N TCP_REDIR
iptables -t nat -A TCP_REDIR -d 127.0.0.1/8 -j RETURN
iptables -t nat -A TCP_REDIR -d 192.168.0.0/16 -j RETURN
iptables -t nat -A TCP_REDIR -p tcp -j REDIRECT --to-ports 7892   #转发TCP到指定端口
# UDP转发
iptables -t mangle -N UDP_REDIR
iptables -t mangle -A UDP_REDIR -d 127.0.0.1 -j RETURN
iptables -t mangle -A UDP_REDIR -d 192.168.0.0/16 -j RETURN 
iptables -t mangle -A UDP_REDIR -d 255.255.255.255 -j RETURN
iptables -t mangle -A UDP_REDIR -p udp -j TPROXY --on-port 7892 --tproxy-mark 0x1/0x1   #按标记路由转发UDP到指定端口

# 应用规则
iptables -t mangle -A PREROUTING -j UDP_REDIR                      #转发来自其它设备的UDP包
iptables -t mangle -A OUTPUT -j P_MARK                            #重路由本机发出的UDP包
iptables -t nat -A PREROUTING -j TCP_REDIR                        #转发来自其它设备的TCP包
# iptables -t nat -A OUTPUT -m owner ! --uid-owner clash -j TCP_REDIR  #转发本机非clash的流量

# 开始
/usr/local/bin/clash -d /config/clash/
