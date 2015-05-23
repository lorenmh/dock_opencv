FROM ubuntu:14.04

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive \
    apt-get install -y build-essential \
    cmake git libgtk2.0-dev pkg-config libavcodec-dev \
    libavformat-dev libswscale-dev 

ENV OPENCV_VERSION 2.4.11

RUN git clone https://github.com/itseez/opencv.git /usr/local/src/opencv

WORKDIR /usr/local/src/opencv

RUN git checkout ${OPENCV_VERSION} \
    && mkdir release

WORKDIR /usr/local/src/opencv/release

RUN cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local ..

RUN make && make install

WORKDIR /

RUN rm -rf /usr/local/src/opencv \
    && apt-get purge -y cmake

ENV LD_LIBRARY_PATH /usr/local/lib
