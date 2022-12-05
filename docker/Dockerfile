# docker pull ubuntu:20.04
#  docker build -t ubuntu/clash:0.1 .       构建
# docker run -itd  --privileged  --name clash -P ubuntu/clash:0.1

FROM ubuntu:20.04

LABEL maintainer=Eleven

MAINTAINER author "levenwindy@gmail.com"

WORKDIR /root/.config/clash/logs

#RUN ls -al
#COPY clash.service /etc/systemd/system/clash.service
#COPY iptables.service /etc/systemd/system/iptables.service
#COPY iptables.rules /etc/iptables.rules
ADD start.sh /root/.config/clash/start.sh
ADD configDefault.yaml /root/.config/clash/configDefault.yaml
ADD bash.txt /root/.config/clash/bash.txt

#RUN	Requirement='wget unzip git net-tools iproute2 iptables' \
#	&& sed -i s@/archive.ubuntu.com/@/mirrors.tuna.tsinghua.edu.cn/@g /etc/apt/sources.list \
#	&& sed -i s@/security.ubuntu.com/@/mirrors.tuna.tsinghua.edu.cn/@g /etc/apt/sources.list \
#	&& apt update && apt install -y $Requirement
	
RUN	Requirement='wget unzip git net-tools iproute2 iptables curl speedtest-cli' \
        && Delment='wget unzip' \
	&& apt update && apt install -y $Requirement \
	&& wget https://github.com/Dreamacro/clash/releases/download/v1.12.0/clash-linux-amd64-v1.12.0.gz \
	&& gunzip  clash-linux-amd64-v1.12.0.gz && mv clash-linux-amd64-v1.12.0 /usr/local/bin/clash \
	&& chmod a+x  /usr/local/bin/clash  \
        && chmod +x /root/.config/clash/start.sh \
	&& wget -O /root/.config/clash/Country.mmdb https://github.com/Dreamacro/maxmind-geoip/raw/release/Country.mmdb \
	&& git clone -b gh-pages --depth 1  https://github.com/haishanh/yacd.git  /root/.config/clash/dashboard \
	&& wget  -O /root/.config/clash/configFree.yaml https://oss.v2rayse.com/proxies/data/2022-12-03/rIWSSA.yaml \
	&& cat /root/.config/clash/configDefault.yaml /root/.config/clash/configFree.yaml > /root/.config/clash/config.yaml  \
	&& echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf \
	&& sysctl -p \
        && apt purge -y $Delment && apt autoremove -y \
	&& rm -rf /var/lib/apt/lists/* && apt clean \
	&& sed -i s@/archive.ubuntu.com/@/mirrors.tuna.tsinghua.edu.cn/@g /etc/apt/sources.list \
	&& sed -i s@/security.ubuntu.com/@/mirrors.tuna.tsinghua.edu.cn/@g /etc/apt/sources.list \
	&& cat /root/.config/clash/bash.txt >> /etc/profile \
	&& cat /root/.config/clash/bash.txt >> /etc/bash.bashrc

WORKDIR /root/.config/clash

EXPOSE 7980 7981 7982 553 53
	
#ENTRYPOINT /root/.config/clash/start.sh && tail -f /dev/null
ENTRYPOINT /root/.config/clash/start.sh
#CMD ["/root/.config/clash/start.sh"] 
#CMD ["/root/.config/clash/start.sh"] 
