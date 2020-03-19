FROM ubuntu:18.04

RUN mkdir /var/run/sshd && apt-get update \
 && apt-get install --yes --no-install-recommends \
    dnsutils \
    curl \
    iputils-ping \
    mtr-tiny \
    net-tools \
    openssh-server \
    && apt-get autoremove --yes --purge
# RUN echo 'root:THEPASSWORDYOUCREATED' | chpasswd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed -i 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

VOLUME /data

EXPOSE 22

COPY entry.sh /entry.sh

ENTRYPOINT ["/entry.sh"]