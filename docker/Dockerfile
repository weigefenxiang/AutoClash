# docker pull ubuntu:20.04
#  docker build -t ubuntu/clash:0.1 .       构建
# docker run -itd  --name clash -P ubuntu/clash:0.1

FROM ubuntu:20.04

LABEL maintainer=Eleven

MAINTAINER author "levenwindy@gmail.com"

RUN ls -al
COPY clash.service /etc/systemd/system/clash.service
COPY iptables.rules /etc/iptables.rules

#RUN sed -i s@/archive.ubuntu.com/@/mirrors.tuna.tsinghua.edu.cn/@g /etc/apt/sources.list && \
#	sed -i s@/security.ubuntu.com/@/mirrors.tuna.tsinghua.edu.cn/@g /etc/apt/sources.list && \
#	apt update && \
#	apt install -y wget unzip git
	
RUN	wget --no-check-certificate https://github.com/Dreamacro/clash/releases/download/v1.12.0/clash-linux-amd64-v1.12.0.gz && \
	gunzip  clash-linux-amd64-v1.12.0.gz && \
	mv clash-linux-amd64-v1.12.0 /usr/local/bin/clash && \
	chmod a+x  /usr/local/bin/clash && \
	mkdir -p  /config/clash && \
	wget --no-check-certificate -O /config/clash/Country.mmdb https://www.sub-speeder.com/client-download/Country.mmdb && \
	/usr/local/bin/clash && \
	git clone -b gh-pages --depth 1  https://github.com/haishanh/yacd.git  /config/clash/dashboard && \
	wget --no-check-certificate -O /config/clash/config.yaml  https://oss.v2rayse.com/proxies/data/2022-12-03/rIWSSA.yaml && \
	systemctl daemon-reload && \
	systemctl enable clash && \
	echo "net.ipv4.ip_forward=1" /etc/sysctl.conf && \
	sysctl -p && \
	ip rule add fwmark 0x1 table 100 && \
	ip route add local 0.0.0.0/0 dev lo table 100 && \
	iptables-restore /etc/iptables.rules
	
WORKDIR /root

EXPOSE 7980 7981 7982 553

CMD ["/bin/bash"]
