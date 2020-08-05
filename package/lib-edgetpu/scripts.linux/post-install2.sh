#!/bin/bash


if [ -d "$INSTALL_DIR/install/lib64" ]; then

    if ! [ -d "$INSTALL_DIR/install/lib" ]; then
        mkdir ${INSTALL_DIR}/install/lib
    fi

    cp -r ${INSTALL_DIR}/install/lib64/* ${INSTALL_DIR}/install/lib
fi
