#!/bin/sh

if [ "$(ls -A /mnt/keys/)" ]; then
  cd /home/git
  cat /mnt/keys/*.pub > .ssh/authorized_keys
  chown -R git:git .ssh
  chmod 700 .ssh
  chmod -R 600 .ssh/*
fi


/usr/bin/supervisord -c /etc/supervisord.conf
