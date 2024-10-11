ARG RUBY_VERSION=3.3.5
FROM docker.io/library/ruby:$RUBY_VERSION-slim AS base

# ssh 関連
RUN apt-get update && apt-get install -y openssh-server vim
RUN mkdir /var/run/sshd
RUN echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config
COPY id_rsa.pub /root/.ssh/authorized_keys
RUN chmod 700 /root/.ssh && chmod 600 /root/.ssh/authorized_keys

# cap, rails 関連
ENV CAPISTRANO_ROOT_DIR "/var/www/app"

WORKDIR $CAPISTRANO_ROOT_DIR

RUN apt-get install --no-install-recommends -y build-essential git curl sudo sqlite3

COPY .env "${CAPISTRANO_ROOT_DIR}/shared/.env"
COPY puma.rb "${CAPISTRANO_ROOT_DIR}/shared/puma.rb"
COPY config/database.yml "${CAPISTRANO_ROOT_DIR}/shared/config/database.yml"

# systemd
COPY docker-resources/puma.service /etc/systemd/system/puma.service


EXPOSE 22 3000
CMD ["/sbin/init"]
