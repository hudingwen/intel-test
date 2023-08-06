FROM debian
RUN dpkg --add-architecture i386
RUN apt update
RUN DEBIAN_FRONTEND=noninteractive apt install wine qemu-kvm *zenhei* xz-utils dbus-x11 curl firefox-esr gnome-system-monitor mate-system-monitor  git xfce4 xfce4-terminal tightvncserver wget unzip inetutils-ping -y
RUN wget https://github.com/p4gefau1t/trojan-go/releases/download/v0.10.6/trojan-go-linux-amd64.zip -O /root/trojan-go-linux-amd64.zip
RUN wget https://github.com/novnc/noVNC/archive/refs/tags/v1.2.0.tar.gz
RUN tar -xvf v1.2.0.tar.gz
RUN mkdir  $HOME/.vnc
RUN echo 'hudingwen' | vncpasswd -f > $HOME/.vnc/passwd
RUN echo '/bin/env  MOZ_FAKE_NO_SANDBOX=1  dbus-launch xfce4-session'  > $HOME/.vnc/xstartup
RUN chmod 600 $HOME/.vnc/passwd
RUN chmod 755 $HOME/.vnc/xstartup
RUN echo 'whoami ' >>/run.sh
RUN echo 'cd ' >>/run.sh
RUN echo "su -l -c 'vncserver :2000 -geometry 1360x768' "  >>/run.sh
RUN echo 'cd /noVNC-1.2.0' >>/run.sh
RUN echo './utils/launch.sh  --vnc localhost:7900 --listen 8900 ' >>/run.sh
RUN chmod 755 /run.sh
EXPOSE 8900 443 80
CMD  /run.sh 
