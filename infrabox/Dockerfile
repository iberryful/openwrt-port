FROM ubuntu:16.04

ENV FORCE_UNSAFE_CONFIGURE=1

RUN apt-get update && \
    apt-get install -y \
    build-essential subversion libncurses5-dev zlib1g-dev gawk gcc-multilib flex git-core gettext libssl-dev \
    file unzip python wget time gperf && \
    apt-get clean

RUN git clone https://github.com/ccache/ccache.git /tmp/ccache && \
    pushd /tmp/ccache && git checkout v3.4.2 && ./autogen.sh && ./configure && \
    make && make install && popd && rm -rf /tmp/ccache

COPY . /openwrt

COPY infrabox/entrypoint.sh /openwrt/entrypoint.sh

RUN chmod +x /openwrt/entrypoint.sh && chmod +x /openwrt/compile.sh

WORKDIR /openwrt

CMD /openwrt/entrypoint.sh


