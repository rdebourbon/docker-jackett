FROM rdebourbon/docker-base:latest
MAINTAINER rdebourbon@xpandata.net

# add our user and group first to make sure their IDs get assigned regardless of what other dependencies may get added.
RUN groupadd -r librarian && useradd -r -g librarian librarian

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF && \
    apt install apt-transport-https && \
    echo "deb https://download.mono-project.com/repo/ubuntu stable-xenial main" | sudo tee /etc/apt/sources.list.d/mono-official-stable.list && \
    apt-get update -q && \
    apt-get install -qy libmono-cil-dev libcurl4-openssl-dev && \
    apt-get -y autoremove && \
    apt-get -y clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/tmp/* && \
    rm -rf /tmp/* 
	
RUN cd /opt && \
    curl -L -O $( curl -s https://api.github.com/repos/Jackett/Jackett/releases | grep Jackett.Binaries.Mono.tar.gz | grep browser_download_url | head -1 | cut -d \" -f 4 ) && \
	tar -xvzf Jackett.Binaries.Mono.tar.gz

RUN mkdir -p /volumes/config && \
    mkdir -p /volumes/media && \
    chown -R librarian:librarian /volumes && \
    chown -R librarian:librarian /opt/Jackett

VOLUME ["/volumes/config","/volumes/media"]

EXPOSE 9117 9117

ADD start.sh /
RUN chmod +x /start.sh

USER librarian

WORKDIR /opt/Jackett

ENTRYPOINT ["/start.sh"]
