#!/usr/bin/env bash

set -e

echo "Your Passwd is: ${PASSWD}"

echo "root:${PASSWD}" | chpasswd

exec "/usr/sbin/sshd" "-D"