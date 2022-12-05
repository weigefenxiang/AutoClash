# docker pull ubuntu:20.04
#  docker build -t ubuntu/clash:0.1 .       构建
# docker run -itd  --privileged  --name clash -P ubuntu/clash:0.1

FROM ubuntu:20.04

LABEL maintainer=Eleven

MAINTAINER author "levenwindy@gmail.com"

WORKDIR /root/.config/clash

#RUN ls -al
#COPY clash.service /etc/systemd/system/clash.service
#COPY iptables.service /etc/systemd/system/iptables.service
#COPY iptables.rules /etc/iptables.rules
ADD start.sh /root/.config/clash/start.sh
ADD configDefault.yaml /root/.config/clash/configDefault.yaml

#RUN	Requirement='wget unzip git net-tools iproute2 iptables' \
#	&& sed -i s@/archive.ubuntu.com/@/mirrors.tuna.tsinghua.edu.cn/@g /etc/apt/sources.list \
#	&& sed -i s@/security.ubuntu.com/@/mirrors.tuna.tsinghua.edu.cn/@g /etc/apt/sources.list \
#	&& apt update && apt install -y $Requirement
	
RUN	Requirement='wget unzip git net-tools iproute2 iptables' \
        && Delment='wget unzip' \
	&& apt update && apt install -y $Requirement \
	&& wget https://github.com/Dreamacro/clash/releases/download/v1.12.0/clash-linux-amd64-v1.12.0.gz \
	&& gunzip  clash-linux-amd64-v1.12.0.gz && mv clash-linux-amd64-v1.12.0 /usr/local/bin/clash \
	&& chmod a+x  /usr/local/bin/clash  \
        && chmod +x /root/.config/clash/start.sh \
	&& wget -O /root/.config/clash/Country.mmdb https://github.com/Dreamacro/maxmind-geoip/releases/download/20221112/Country.mmdb \
	&& git clone -b gh-pages --depth 1  https://github.com/haishanh/yacd.git  /root/.config/clash/dashboard \
	&& wget  -O /root/.config/clash/configFree.yaml https://oss.v2rayse.com/proxies/data/2022-12-03/rIWSSA.yaml \
	&& cat /root/.config/clash/configDefault.yaml /root/.config/clash/configFree.yaml > /root/.config/clash/config.yaml  \
	&& echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf \
	&& sysctl -p \
        && apt purge -y wget && apt purge -y unzip \
	&& apt autoremove -y

WORKDIR /root/.config/clash

EXPOSE 7980 7981 7982 553 53
	
#CMD ["/bin/bash","/root/.config/clash/start.sh","&"] 
