# vim:set ft=dockerfile:
FROM debian:jessie-backports

ENV CASSANDRA_VERSION 2.2.5

# explicitly set user/group IDs
RUN  apt-key adv --keyserver ha.pool.sks-keyservers.net --recv-keys 514A2AD631A57A16DD0047EC749D6EEC0353B12C \
    && echo 'deb http://www.apache.org/dist/cassandra/debian 22x main' >> /etc/apt/sources.list.d/cassandra.list \
    && apt-get update && apt-get install -y --no-install-recommends ca-certificates wget cron curl \
    && apt-get install -y cassandra="$CASSANDRA_VERSION"
COPY snapshot /etc/cron.hourly/
RUN service cassandra stop
RUN service cron restart
CMD ["/sbin/init"]
