#!/bin/bash

set -ue
cd grpc
    # 来自https://gitee.com/mirrors/grpc/blob/master/test/distrib/cpp/run_distrib_test_cmake.sh
    # absl
cd third_party 
export THIRD_PARTY_DIR=$(pwd)   
#mkdir -p ${THIRD_PARTY_DIR}/abseil-cpp/cmake/build 
cd ${THIRD_PARTY_DIR}/abseil-cpp/cmake/build
rm -rf *
cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_POSITION_INDEPENDENT_CODE=TRUE ../..
make -j4 install 
    # c-ares
#mkdir -p ${THIRD_PARTY_DIR}/cares/cares/cmake/build &&  
cd ${THIRD_PARTY_DIR}/cares/cares/cmake/build
rm -rf *
cmake -DCMAKE_BUILD_TYPE=Release ../..  
make -j4 install
    # protobuf
#mkdir -p ${THIRD_PARTY_DIR}/protobuf/cmake/build    &&  
cd ${THIRD_PARTY_DIR}/protobuf/cmake/build 
rm -rf *
cmake -Dprotobuf_BUILD_TESTS=OFF -DCMAKE_BUILD_TYPE=Release ..  
make -j4 install 
    # re2
#mkdir -p ${THIRD_PARTY_DIR}/re2/cmake/build &&  
cd ${THIRD_PARTY_DIR}/re2/cmake/build
rm -rf *
cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_POSITION_INDEPENDENT_CODE=TRUE ../..  
make -j4 install
    # zlib
#mkdir -p ${THIRD_PARTY_DIR}/zlib/cmake/build    &&  
cd ${THIRD_PARTY_DIR}/zlib/cmake/build
rm -rf *
cmake -DCMAKE_BUILD_TYPE=Release ../..  
make -j4 install    
    # gRPC
#&&  mkdir -p ${THIRD_PARTY_DIR}/../cmake/build  &&  
cd ${THIRD_PARTY_DIR}/../cmake/build 
rm -rf *
cmake ../.. \
        -DCMAKE_BUILD_TYPE=Release  \
        -DgRPC_INSTALL=ON   \
        -DgRPC_BUILD_TESTS=OFF  \
        -DgRPC_CARES_PROVIDER=package   \
        -DgRPC_ABSL_PROVIDER=package    \
        -DgRPC_PROTOBUF_PROVIDER=package    \
        -DgRPC_RE2_PROVIDER=package \
        -DgRPC_SSL_PROVIDER=package \
        -DgRPC_ZLIB_PROVIDER=package
make -j4 install
