FROM ubuntu:16.04
MAINTAINER Arseniy Shestakov <me@arseniyshestakov.com>

# Install the python script required for "add-apt-repository"
RUN apt-get update && apt-get install -y software-properties-common

# Add daily builds PPA and install VCMI
RUN add-apt-repository -y ppa:vcmi/ppa \
 && apt-get update \
 && apt-get install -y vcmi wget unar unzip \
 && apt-get clean all

# Create user for server and some directories
RUN useradd vcmi --home /vcmi --create-home \
 && mkdir -p /vcmi/.local/share/vcmi/ \
 && mkdir -p /vcmi/.config/vcmi/

# Download and unpack H3 mac demo and VCMI assets
RUN cd /vcmi \
 && wget http://vcmi.arseniyshestakov.com/demo/heroes_3_complete_demo.sit \
 && wget http://vcmi.arseniyshestakov.com/docker/Mods.zip \
 && wget http://vcmi.arseniyshestakov.com/docker/modSettings.json \
 && unar /vcmi/heroes_3_complete_demo.sit \
 && unzip /vcmi/Mods.zip \
 && mv "/vcmi/Heroes III Demo/data/" "/vcmi/.local/share/vcmi/Data" \
 && mv "/vcmi/Mods" "/vcmi/.local/share/vcmi/" \
 && mv "/vcmi/modSettings.json" "/vcmi/.config/vcmi/" \
 && rm -rf "/vcmi/Heroes III Demo/" \
 && rm -f "/vcmi/heroes_3_complete_demo.sit" \
 && rm -f "/vcmi/Mods.zip"

COPY run.sh /vcmi/run.sh
RUN chmod +x /vcmi/run.sh

RUN chown -R vcmi:vcmi /vcmi

USER vcmi
WORKDIR /vcmi

EXPOSE 3030/tcp
CMD ["/vcmi/run.sh"]
