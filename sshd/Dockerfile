FROM ubuntu:18.04

RUN mkdir /var/run/sshd && apt-get update \
 && apt-get install --yes --no-install-recommends \
    dnsutils \
    curl \
    iputils-ping \
    mtr-tiny \
    net-tools \
    openssh-server \
    sudo \
    && apt-get autoremove --yes --purge

ADD node-v12.16.2-linux-x64.tar /usr/local/nodejs

# RUN echo 'root:THEPASSWORDYOUCREATED' | chpasswd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config  \
    && sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/g' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed -i 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo -e  "export VISIBLE=now\nexport NODE_HOME=/usr/local/nodejs/node-v12.16.2-linux-x64\nexport PATH=/usr/local/nodejs/node-v12.16.2-linux-x64/bin:$PATH" >> /etc/profile

VOLUME /data

EXPOSE 22

RUN chmod 0777 /data
COPY entry.sh /entry.sh

ENTRYPOINT ["/entry.sh"]