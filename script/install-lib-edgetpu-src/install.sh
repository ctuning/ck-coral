#! /bin/bash

#
# Copyright (c) 2020 cTuning foundation.
# See CK COPYRIGHT.txt for copyright details.
#
# See CK LICENSE.txt for licensing details.
#   
# Installation script for the EDGE TPU  library.
#

function stage() {
  echo; echo "--------------------------------"; echo $1; echo
}

function exit_if_error() {
 if [ "${?}" != "0" ]; then exit 1; fi
}

function remove_dir_if_exists() {
  if [ -d $1 ]; then rm -rdf $1; fi
}

if [ "${PACKAGE_GIT}" == "YES" ] ; then
  stage "Cloning package ${PACKAGE_URL} ..."
  remove_dir_if_exists ${PACKAGE_SUB_DIR}
  git clone ${PACKAGE_GIT_CLONE_FLAGS} ${PACKAGE_URL} ${PACKAGE_SUB_DIR}
  exit_if_error

  stage "Checking out branch ${PACKAGE_GIT_CHECKOUT} ..."
  cd ${PACKAGE_SUB_DIR}
  git checkout ${PACKAGE_GIT_CHECKOUT}
  exit_if_error
fi

if [ "${PACKAGE_PATCH}" == "YES" ] ; then
  if [ -d ${ORIGINAL_PACKAGE_DIR}/patch.${CK_TARGET_OS_ID} ] ; then
    stage "Patching source directory ..."
    cd ${INSTALL_DIR}/${PACKAGE_SUB_DIR}
    for i in ${ORIGINAL_PACKAGE_DIR}/patch.${CK_TARGET_OS_ID}/*
    do
      echo "$i"
      patch -p1 < $i
      exit_if_error
    done
  fi
fi

cd ${INSTALL_DIR}/${PACKAGE_SUB_DIR}

#stage "Build shared library"
#bazel build edgetpu/libedgetpu:libedgetpu_dynamic --jobs ${CK_HOST_CPU_NUMBER_OF_PROCESSORS} --config optimization --define openmp=true
#exit_if_error

#bazel shutdown

remove_dir_if_exists ${INSTALL_DIR}/install/lib
remove_dir_if_exists ${INSTALL_DIR}/install/include
remove_dir_if_exists ${INSTALL_DIR}/install
mkdir ${INSTALL_DIR}/install
mkdir ${INSTALL_DIR}/install/lib
mkdir ${INSTALL_DIR}/install/include
#cp bazel-bin/edgetpu/libedgetpu/libedgetpu.so ${INSTALL_DIR}/install/lib
#cp edgetpu/public/*.h ${INSTALL_DIR}/install/include

return 0
