#!/usr/bin/env bash

# echo "Your Passwd is: ${PASSWD}"

echo "root:${PASSWD}" | chpasswd

echo "add user ${USER2} with passwd  ${PASSWD2}"
useradd -r -m -p '' -u 1000 --shell /bin/bash  $USER2
echo "${USER2}:${PASSWD2}" | chpasswd
echo "${USER2}   ALL=(ALL)       ALL" > /etc/sudoers

exec "/usr/sbin/sshd" "-D"