FROM ubuntu:latest

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

RUN apt-get update
RUN apt-get install -y libgconf-2-4 net-tools systemd sudo lsb-core x11-xserver-utils libqca-qt5-2 v4l-utils

RUN unlink /etc/localtime
RUN ln -s /usr/share/zoneinfo/America/New_York /etc/localtime

COPY assets/vidireports.sh /vidireports.sh
COPY assets/configure_vidireports.sh /configure_vidireports.sh

RUN /vidireports.sh

RUN usermod -aG video root 

ENTRYPOINT /vidireports.sh -d -c /etc/vidireports -p "/var/run/vidireports.pid" > /dev/null 2>&1
