# docker pull ubuntu:20.04
#  docker build -t ubuntu/clash:0.1 .       构建
# docker run -itd  --privileged  --name clash -P ubuntu/clash:0.1

FROM ubuntu:20.04

LABEL maintainer=Eleven

MAINTAINER author "levenwindy@gmail.com"

WORKDIR /config/clash

#RUN ls -al
#COPY clash.service /etc/systemd/system/clash.service
#COPY iptables.service /etc/systemd/system/iptables.service
#COPY iptables.rules /etc/iptables.rules
ADD start.sh /config/clash/start.sh

#RUN	Requirement='wget unzip git net-tools iproute2 iptables' \
#	&& sed -i s@/archive.ubuntu.com/@/mirrors.tuna.tsinghua.edu.cn/@g /etc/apt/sources.list \
#	&& sed -i s@/security.ubuntu.com/@/mirrors.tuna.tsinghua.edu.cn/@g /etc/apt/sources.list \
#	&& apt update && apt install -y $Requirement
	
RUN	Requirement='wget unzip git net-tools iproute2 iptables' \
	&& apt update && apt install -y $Requirement
	
RUN	wget https://github.com/Dreamacro/clash/releases/download/v1.12.0/clash-linux-amd64-v1.12.0.gz \
	&& gunzip  clash-linux-amd64-v1.12.0.gz && mv clash-linux-amd64-v1.12.0 /usr/local/bin/clash \
	&& chmod a+x  /usr/local/bin/clash && mkdir -p  /config/clash \
	&& wget -O /config/clash/Country.mmdb https://www.sub-speeder.com/client-download/Country.mmdb \
	&& git clone -b gh-pages --depth 1  https://github.com/haishanh/yacd.git  /config/clash/dashboard \
	&& wget  -O /config/clash/configFree.yaml https://oss.v2rayse.com/proxies/data/2022-12-03/rIWSSA.yaml \
	&& cat /config/clash/configDefault.yaml /config/clash/configFree.yaml > /config/clash/config.yaml  \
	&& echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf \
	&& sysctl -p
	
WORKDIR /config/clash

EXPOSE 7980 7981 7982 553 53

RUN chkconfig --add /config/clash/start.sh \
    && chkconfig /config/clash/start.sh on
	
CMD ["/bin/bash"]
