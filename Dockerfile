M ubuntu:15.10
MAINTAINER Selenium <selenium-developers@googlegroups.com>

#========================
# Miscellaneous packages
# Includes minimal runtime used for executing non GUI Java programs
#========================
RUN apt-get update -qqy \
  && apt-get -qqy --no-install-recommends install \
    ca-certificates \
    openjdk-8-jre-headless \
    sudo \
    unzip \
    wget \
  && rm -rf /var/lib/apt/lists/* \
  && sed -i 's/securerandom\.source=file:\/dev\/random/securerandom\.source=file:\/dev\/urandom/' ./usr/lib/jvm/java-8-openjdk-amd64/jre/lib/security/java.security

#==========
# Download and install Browsermob
#==========
RUN wget https://github.com/lightbody/browsermob-proxy/releases/download/browsermob-proxy-2.1.0-beta-4/browsermob-proxy-2.1.0-beta-4-bin.zip && unzip *.zip
COPY entry_point.sh /opt/bin/entry_point.sh
RUN chmod +x /opt/bin/entry_point.sh
CMD ["/opt/bin/entry_point.sh"]

#========================================
# Add normal user with passwordless sudo
#========================================
RUN sudo useradd seluser --shell /bin/bash --create-home \
  && sudo usermod -a -G sudo seluser \
  && echo 'ALL ALL = (ALL) NOPASSWD: ALL' >> /etc/sudoers \
  && echo 'seluser:secret' | chpasswd

EXPOSE 9000
EXPOSE 8081-8181

