# Use Alpine Linux
FROM debian:jessie

# Declare maintainer
MAINTAINER Muhammad Zamroni <halo@matriphe.com>

# Set environment
ENV DEBIAN_FRONTEND noninteractive

# Timezone
ENV TIMEZONE Asia/Jakarta

# Let's roll
RUN	echo "${TIMEZONE}" > /etc/timezone && \
    dpkg-reconfigure -f noninteractive tzdata && \
    apt-get update && \
	apt-get install -y build-essential software-properties-common ruby ruby-dev libsqlite3-dev && \
	gem install mailcatcher  --no-ri --no-rdoc && \
	apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false -o APT::AutoRemove::SuggestsImportant=false build-essential software-properties-common && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 1025 1080

# Command
ENTRYPOINT ["mailcatcher", "--foreground", "--ip=0.0.0.0"]