FROM ros:melodic-perception-bionic

WORKDIR /home/

RUN apt-get update -y && apt-get install -y --fix-missing \
    apt-utils \
    sox libsox-fmt-all \
    vim curl ssh sudo psmisc\
    libprotobuf-dev protobuf-compiler \
    libgoogle-glog-dev \
    libatlas-base-dev \
    libceres-dev \
    libompl-dev \
    net-tools \
    libcgal-dev \
    libcgal-qt5-dev \
    liblua5.2-dev \
    sqlite3 \
    ros-melodic-rviz \
    ros-melodic-rqt-image-view \
    ros-melodic-eigen-conversions \
    ros-melodic-navigation \
    ros-melodic-libg2o \
    ros-melodic-image-transport \
    ros-melodic-diagnostic-updater \ 
    ros-melodic-camera-info-manager \
    ros-melodic-roslint \
    ros-melodic-robot-state-publisher \
    ros-melodic-rosbridge-suite \
    ros-melodic-tf2-web-republisher \
    ros-melodic-xacro \
    ros-melodic-urdf \
    libusb-1.0-0-dev \
    && rm -rf /var/lib/apt/lists/*

ENV CMAKE_PREFIX_PATH /opt/ros/melodic:${CMAKE_PREFIX_PATH}
ENTRYPOINT ["/ros_entrypoint.sh"]

# Change Source
RUN \
    echo "deb https://mirrors.aliyun.com/ubuntu/ bionic main restricted universe multiverse \ndeb https://mirrors.aliyun.com/ubuntu/ bionic-security main restricted universe multiverse \ndeb https://mirrors.aliyun.com/ubuntu/ bionic-updates main restricted universe multiverse \ndeb https://mirrors.aliyun.com/ubuntu/ bionic-proposed main restricted universe multiverse \ndeb https://mirrors.aliyun.com/ubuntu/ bionic-backports main restricted universe multiverse " > /etc/apt/sources.list && \
    apt-get update && \
    apt-get upgrade -y

# Install CMake
RUN apt-get install -y build-essential clang  wget  make gcc g++ libssl-dev
# WORKDIR /tmp
# RUN wget https://github.com/Kitware/CMake/releases/download/v3.17.2/cmake-3.17.2.tar.gz
# RUN tar zvxf cmake-3.17.2.tar.gz && cd cmake-3.17.2 && ./bootstrap && make -j8  && make install
# RUN rm -rf cmake*

RUN apt-get update -y && apt-get install -y --fix-missing \
    qt5-default \
    git \
    wget \
    python3-dev \
    python3-pip \
    libflann-dev \
    pkg-config


# Install libboost
RUN apt-get install -y libboost-all-dev

# Install yaml gflags 
RUN apt-get -y install libyaml-cpp-dev
RUN apt-get -y install libgflags-dev
RUN apt-get -y install libadolc-dev

#Install zcm
RUN apt-get install -y openjdk-8-jdk-headless cython cython3 libzmq3-dev libelf-dev
RUN apt-get install -y libpqxx-dev

# Install ZCM
WORKDIR /tmp
COPY ./scripts/install_zcm.sh /tmp/scripts/install_zcm.sh
RUN bash ./scripts/install_zcm.sh

#Install google test
WORKDIR /tmp
# RUN git clone https://github.com/google/googletest.git \
#     && cd googletest \
#     && mkdir build \
#     && cd build \
#     && make -j4 \
#     && make install
COPY ./third_party/googletest/ googletest/
RUN cd googletest \
    && mkdir build \
    && cd build \
    && cmake .. \
    && make -j4 \
    && make install

#Install btree
RUN apt-get install -y libzmq3-dev




WORKDIR /tmp
COPY ./third_party/BehaviorTree.CPP/ BehaviorTree.CPP/
RUN cd BehaviorTree.CPP \
    && mkdir build \
    && cd build \
    && cmake .. \
    && make -j3 \
    && make install

# RUN git clone https://github.com/BehaviorTree/BehaviorTree.CPP.git \
#     && cd BehaviorTree.CPP \
#     && mkdir build \
#     && cd build \
#     && cmake .. \
#     && make -j3 \
#     && make install

WORKDIR /tmp
COPY ./third_party/osqp osqp/
RUN cd osqp \
    && mkdir build \
    && cd build \
    && cmake .. \
    && make -j3 \
    && make install

WORKDIR /tmp
COPY ./third_party/grpc grpc/

RUN cd grpc \
    && ./grpc_install.sh

WORKDIR /home

CMD ["/bin/bash"] 
