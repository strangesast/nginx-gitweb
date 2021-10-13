from alpine

run apk add --no-cache \
  perl-cgi \
  fcgiwrap \
  spawn-fcgi \
  supervisor \
  nginx \
  openssh \
  git \
  git-gitweb \
  highlight

run ssh-keygen -A && \
  mkdir -p /mnt/keys && \
  adduser -D -s /bin/sh git && \
  passwd -d git && \
  install -d -o git -g git /home/git/repositories && \
  chown -R git:git /mnt/keys && \
  cd /home/git && \
  mkdir .ssh && \
  chown -R git:git .ssh && \
  chmod 700 .ssh && \
  truncate -s0 /etc/motd

volume /mnt/keys

workdir /tmp
copy sshd_config /etc/ssh/
copy gitweb.conf supervisord.conf /etc/
copy nginx.conf fastcgi_params /etc/nginx/
copy start.sh .

cmd ["sh", "start.sh"]
