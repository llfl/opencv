FROM ubuntu:18.04
MAINTAINER i@imux.top

ARG CV_VERSION=4.3.0

RUN apt-get clean && apt-get update && apt-get install -y \
      build-essential \
      git \
      libgtk2.0-dev \ 
      pkg-config \
      libavcodec-dev \ 
      libavformat-dev \
      libswscale-dev \
      libatlas-base-dev \
      libatlas-dev \
      libboost-all-dev \
      libgflags-dev \
      libgoogle-glog-dev \
      libhdf5-dev \
      libleveldb-dev \
      liblmdb-dev \
      libprotobuf-dev \
      libsnappy-dev \
      lsb-release \
      protobuf-compiler \
      zip \
      wget \
      python-pip \
      python-dev \
      ffmpeg \
      cmake \
    && rm -rf /var/lib/apt/lists/*
RUN pip install --upgrade pip

# ADD 4.2.0.zip .
RUN wget https://github.com/opencv/opencv/archive/${CV_VERSION}.zip

RUN unzip /${CV_VERSION}.zip && cd opencv-${CV_VERSION} && mkdir -p build && cd build \
    && /cmake/bin/cmake -DCMAKE_BUILD_TYPE=Release -DOPENCV_GENERATE_PKGCONFIG=ON .. && make -j"$(nproc)" \
    && make install

RUN rm /${CV_VERSION}.zip && rm -rf /opencv-${CV_VERSION}

ENV PATH="/cmake/bin/:${PATH}"

CMD [ "/bin/bash" ]