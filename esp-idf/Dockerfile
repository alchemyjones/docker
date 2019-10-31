FROM voidlinux/voidlinux:latest AS build

RUN echo "LANG=en_US.UTF-8" > /etc/locale.conf \
 && echo "LC_ALL=en_US.UTF-8" >> /etc/locale.conf \
 && echo "en_US.UTF-8 UTF-8" >> /etc/default/libc-locales \
 && xbps-reconfigure -f glibc-locales \
 && xbps-install -Suv -y     \
 && xbps-install -S bash -y   \
 && xbps-install -S vim -y   \
 && xbps-install -S curl -y  \
 && xbps-install -S nano -y  \
 && xbps-install -S gcc -y  \
 && xbps-install -S bison -y  \
 && xbps-install -S check -y  \
 && xbps-install -S cmake -y  \
 && xbps-install -S flex -y  \
 && xbps-install -S git -y  \
 && xbps-install -S gperf -y  \
 && xbps-install -S lcov -y  \
 && xbps-install -S ncurses -y  \
 && xbps-install -S ncurses-devel -y  \
 && xbps-install -S libusb -y  \
 && xbps-install -S make -y  \
 && xbps-install -S ninja -y  \
 && xbps-install -S python3 -y  \
 && xbps-install -S python3-pip -y  \
 && xbps-install -S unzip -y  \
 && xbps-install -S wget -y  \
 && xbps-install -S xz -y  \
 && xbps-install -S zip -y  \
 && xbps-install -S ccache -y  \
 && xbps-install -S ca-certificates -y  \
 && rm -fr /var/cache/xbps/* \
 && python -m pip install --upgrade pip virtualenv

ARG IDF_CLONE_URL=https://github.com/espressif/esp-idf.git
ARG IDF_CLONE_BRANCH_OR_TAG=master
ARG IDF_CHECKOUT_REF=

ENV IDF_PATH=/opt/esp/idf
ENV IDF_TOOLS_PATH=/opt/esp

RUN echo IDF_CHECKOUT_REF=$IDF_CHECKOUT_REF IDF_CLONE_BRANCH_OR_TAG=$IDF_CLONE_BRANCH_OR_TAG \ 
  && git clone --recursive ${IDF_CLONE_BRANCH_OR_TAG:+-b $IDF_CLONE_BRANCH_OR_TAG} $IDF_CLONE_URL $IDF_PATH \ 
  && \
    if [ -n "$IDF_CHECKOUT_REF" ]; then \
      cd $IDF_PATH && \
      git checkout $IDF_CHECKOUT_REF && \
      git submodule update --init --recursive; \
    fi

RUN $IDF_PATH/install.sh \ 
  && rm -rf $IDF_TOOLS_PATH/dist

COPY entrypoint.sh /opt/esp/entrypoint.sh

FROM scratch
COPY --from=build / /
ENTRYPOINT [ "/opt/esp/entrypoint.sh" ]
CMD [ "/bin/bash" ]

